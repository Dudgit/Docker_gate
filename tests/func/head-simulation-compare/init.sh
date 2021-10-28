#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

### Run the Gate simulations with a head phantom
cd $MC_SIMULATIONS/head_phantom/
echo 'Simulating head phantom...'
Gate  -a "[PRIMARY_COUNT, 100] [WATER_PHANTOM_THICKNESS, 0.0] [BEAM_ENERGY, 230] [FILENAME, $MC_SIMULATIONS/head_phantom/Test_Head_Phantom_230MeV] [PARTICLE_TYPE, proton] [SEED, default]" TestMain.mac &>/dev/null

cd ../
echo 'Converting simulation...'
root -b -q "$SCRIPT_PATH/root_csv_converter.cpp (\"$MC_SIMULATIONS/head_phantom/Test_Head_Phantom_230MeV.root\")" >/dev/null
echo $(md5sum $MC_SIMULATIONS/head_phantom/Test_Head_Phantom_230MeV_Hits.csv)

echo 'Comparison of the files...'
if cmp -s "$DIR/Functional-Test_Head-Phantom_230MeV_epi.csv" "$MC_SIMULATIONS/head_phantom/Test_Head_Phantom_230MeV_Hits.csv"; then
        exit 0
else
        exit 1
fi

