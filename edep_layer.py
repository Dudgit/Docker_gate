import pandas as pd
from glob import glob
from pathlib import Path

DATADIR = 'output'

for f in glob(DATADIR+'/water*WPT*Hits.csv'):
#for f in glob(DATADIR+'/water_*230MeV_40BX_0BY_*Hits.csv'):
   fdat = f.rsplit( ".", 1 )[ 0 ] + '.dat'
   if Path(fdat).exists():
      print("Skipping {}: file exists".format(fdat))
   else:
      print("Converting {} -> {}".format(f,fdat))
      df = pd.read_csv(f, usecols=[2,5,17,18,33])
#      df['Layer'] = 2*df['baseID']+df['level1ID']
      df['Layer'] = 2*df['baseID']+df['level1ID']
      res = df.groupby(['Layer'])['edep'].sum().reset_index()
      fout = open(fdat,'w')
      for index, row in res.iterrows():
         fout.write("{}\n".format(row['edep']))
      fout.close()

