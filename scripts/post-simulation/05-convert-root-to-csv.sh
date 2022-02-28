for file in $OUTPUT_PATH/$FILENAME*.root
do
    root -b -q "$SCRIPT_PATH/root_csv_converter.cpp (\"$file\")" 
done
