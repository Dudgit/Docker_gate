#include "TH1.h"
#include "TMath.h"
#include "TF1.h"
#include "TLegend.h"
#include "TCanvas.h"
#include "TH1F.h"
#include "TH2F.h"
#include "TTree.h"
#include "TFile.h"

#include <string>
#include <iostream>
#include <fstream>

class CSV_Writer {
	private:
		std::string filename;
		ofstream file;

	public:
		CSV_Writer(std::string filename);
		void write_file(TTree* tree);
};


CSV_Writer::CSV_Writer(std::string filename) {
	this->filename = filename;
}

void CSV_Writer::write_file(TTree* tree) {
	file.open(filename + ".csv");
	std::cout << "Writing to file: " << filename + ".csv" << std::endl;
	char delimiter = ',';

	// Get names of the branches and save them as the columns at the beginning of the .csv file
	for(Int_t i=0; i<tree->GetListOfLeaves()->GetEntries(); i++) {
		TLeaf* leaf = (TLeaf*)tree->GetListOfLeaves()->At(i);
		if (i != tree->GetListOfLeaves()->GetEntries()-1) {
			file << leaf->GetBranch()->GetName() << delimiter;
		} else {
			file << leaf->GetBranch()->GetName() << std::endl;
		}
	}

	// Iterate through each entry in the .root file and save it in the .csv file
	for(Int_t entry = 0; entry < tree->GetEntries(); entry++) {
		// Checks whether the entry exists and is readable to prevent incorrect file conversion
		if (entry != -1) {
			Int_t ret = tree->LoadTree(entry);
			if (ret == -2) {
				Error("Show()", "Cannot read entry %d (entry does not exist)", entry);
				return;
			} else if (ret == -1) {
				Error("Show()", "Cannot read entry %d (I/O error)", entry);
				return;
			}
			ret = tree->GetEntry(entry);
			if (ret == -1) {
				Error("Show()", "Cannot read entry %d (I/O error)", entry);
				return;
			} else if (ret == 0) {
				Error("Show()", "Cannot read entry %d (no data read)", entry);
				return;
			}
		}

		// For each leaf (parameter) of the entry, the amount of values will be determined
		// and saved appropriately.
		// When there amount of values is bigger than one, those will be saved in the form
		// of an array with a ';' (semi-colon) as a delimiter between the values
		TObjArray* leaves  = tree->GetListOfLeaves();
		Int_t nleaves = leaves->GetEntriesFast();
		Int_t ltype;
		for (Int_t i = 0; i < nleaves; i++) {
			TLeaf* leaf = (TLeaf*) leaves->At(i);
			TBranch* branch = leaf->GetBranch();
			if (branch->TestBit(kDoNotProcess)) {
				continue;
			}
			Int_t len = leaf->GetLen();
			if (len <= 0) {
				file << delimiter;
				continue;
			}
			if (branch->GetListOfBranches()->GetEntriesFast() > 0) {
				continue;
			}
			ltype = 10;
			if (leaf->IsA() == TLeafF::Class() || leaf->IsA() == TLeafD::Class()) {
				ltype = 5;
			}
			if (leaf->IsA() == TLeafC::Class()) {
				len = 1;
				ltype = 5;
			}

			if (len > 1) {
				file << "[";
				delimiter = ';';
			}
			for (Int_t l = 0; l < len; l++) {

				if (leaf->IsA() == TLeafC::Class()) {
					file << std::setprecision(64) << (char*)leaf->GetValuePointer();
				} else {
					file << std::setprecision(64) << leaf->GetValue(l);
				}
				if (l == (len - 1)) {
					if(len > 1) {
						file << "]";
						delimiter = ',';
					}
				}
				if (i != nleaves-1) {
					file << delimiter;
				}
			}
	    }
		file << std::endl;
	}

	file.close();
}



void root_csv_converter(char const* fname){

	// The .root file is opened and the determined tree is loaded. Currently the tree 'Hits' is
	// the one where all entries are  saved, but that could chage.
	TFile *inFile = new TFile(fname);
	std::string filename = fname;

	if (inFile->IsOpen()) {
		TTree* tree = NULL;
		CSV_Writer* writer = NULL;
		for(int i = 0; i<inFile->GetListOfKeys()->GetEntries(); i++){
			TKey *key = (TKey *) inFile->GetListOfKeys()->At(i);
			if(std::strcmp(key->GetClassName(), "TTree") || std::strcmp(key->GetName(), "OpticalData") == 0){
				continue;
			}
			bool skip = false;
			for (int k = 0; k<i; k++) {
				TKey *prevKey = (TKey *) inFile->GetListOfKeys()->At(k);
				if (std::strcmp(key->GetName(), prevKey->GetName()) == 0)
					skip = true;
			}
			if (skip)
				continue;
			std::cout << "Exporting tree " << key->GetName() << " to csv.\n";
			tree = (TTree*)inFile->Get(key->GetName());

			std::string csvFilename = filename.substr(0, filename.find(".root")) + "_" + key->GetName();
			writer = new CSV_Writer(csvFilename);
			writer->write_file(tree);
		}
//		TTree* tree = (TTree*)inFile->Get(inFile->GetList()->At(0)->GetName());
//		TTree* tree = (TTree*)inFile->Get("Hits");

		delete writer;
	}
}

