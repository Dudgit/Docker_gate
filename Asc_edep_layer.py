import pandas as pd
from glob import glob
from pathlib import Path
import re
import os

DATADIR = 'output'

for f in glob(DATADIR+'/water*WPT*[0-9]Hits.dat'):
   fRun = re.sub('Hits.dat','Run.dat',f)
   fdat = re.sub('Hits.dat','_Hits.dat',f)
   if Path(fdat).exists():
      print("Skipping {}: file exists".format(fdat))
   else:
      os.remove(fRun)
      print("Converting {} -> {}".format(f,fdat))
      df = pd.read_csv(f, usecols=[1,2,4,5,11],delimiter=r'\s+')
      df.columns=['eventID','parentID','baseID','level1ID','edep']
#      df['Layer'] = 2*df['baseID']+df['level1ID']
      df['Layer'] = 2*df['baseID']+df['level1ID']
      res = df.groupby(['Layer'])['edep'].sum().reset_index()
      fout = open(fdat,'w')
      for index, row in res.iterrows():
         fout.write("{}\n".format(row['edep']))
      fout.close()

