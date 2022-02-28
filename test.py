import pandas as pd
from glob import glob
from pathlib import Path

DATADIR = 'output'
Nchunk = 100000
Nchunk = 10000
Nbin = 50

for f in glob(DATADIR+'/water*WPT*Hits.csv'):
#for f in glob(DATADIR+'/water_phantom_1000000Primaries_230MeV_225WPT_1644934479_Hits.csv'):
   fdat = f.rsplit( ".", 1 )[ 0 ] + '.dat'
   if Path(fdat).exists():
      print("Skipping {}: file exists".format(fdat))
   else:
      print("Converting {} -> {}".format(f,fdat))
      df = pd.read_csv(f, usecols=[2,5,17,18,33])
      df['Layer'] = 2*df['baseID']+df['level1ID']
      df['eventbin'] = df['eventID'] // Nchunk
      evrange = df['eventbin'].unique()
      res = df.groupby(['Layer','eventbin'])['edep'].sum().reset_index()
      fout = open(fdat,'w')
      for l in sorted(df['Layer'].unique()):
        fout.write(','.join([str(x['edep']) for i,x in res[res['Layer']==l].iterrows()])+'\n')
      fout.close()
