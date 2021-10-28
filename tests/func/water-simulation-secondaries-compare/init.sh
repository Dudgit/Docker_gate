#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

### Run the Gate simulations with a water phantom secondaries
cd $MC_SIMULATIONS/water_phantom/
echo 'Simulating water phantom secondaries...'
Gate -a "[PRIMARY_COUNT, 10000] [WATER_PHANTOM_THICKNESS, 160.0] [BEAM_ENERGY, 150] [FILENAME, $MC_SIMULATIONS/water_phantom/Test_Water_Phantom_150MeV] [PARTICLE_TYPE, proton] [SEED, default]" TestSecondaries.mac &>/dev/null

cd ../
echo 'Converting simulation...'
root -b -q "$SCRIPT_PATH/root_csv_converter.cpp (\"$MC_SIMULATIONS/water_phantom/Test_Water_Phantom_150MeV.root\")" >/dev/null
echo $(md5sum $MC_SIMULATIONS/water_phantom/Test_Water_Phantom_150MeV_Hits.csv)

echo 'Comparison of the files...'
if cmp -s "$DIR/Functional-Test_Water-Phantom_150MeV_secondaries.csv" "$MC_SIMULATIONS/water_phantom/Test_Water_Phantom_150MeV_Hits.csv"; then
        exit 0
else
        exit 1
fi

rm $MC_SIMULATIONS/water_phantom/Test_Water_Phantom_*

echo
