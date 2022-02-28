#!/bin/bash

##
# Source gate dependencies
#
source /geant4/geant4.10.05-install/bin/geant4.sh
source /cern/root-install/bin/thisroot.sh

# Paths and other globals
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export MC_TESTS=${MONTE_CARLO_TESTS:-"$DIR/../tests/func"}
export MC_SIMULATIONS=${MONTE_CARLO_SIMULATIONS:-"$DIR/../monte-carlo-simulations"}
export SCRIPT_PATH=${SCRIPT_PATH:-"$DIR/../scripts"}
export OUTPUT_PATH=${OUTPUT_PATH:-"$DIR/../output"}

#Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m'

# Declare default values
SIMULATION_TYPE=""
RUN_TESTS=true
RUN_HELP=false
# Default amount of primaries
PRIMARY_COUNT=1000
# Default thickness of the water phantom specified in mm
PHANTOM_MODULE=Module_phantom_box.mac
WATER_PHANTOM_THICKNESS=200.0
WATER_PHANTOM_X=50.0
WATER_PHANTOM_Y=40.0
# Default energy of the beam in MeV
BEAM_ENERGY=230
BEAM_DELTA_X=0.0
BEAM_DELTA_Y=0.0
# Default beam type
PARTICLE_TYPE="proton"
# Set a user defined seed
SEED="auto"

# Readout parameter and set variables
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -dt|--disable-tests)
    RUN_TESTS=false
    shift
    ;;
    -s|--simulation)
    SIMULATION_TYPE="$2"
    shift
    shift
    ;;
    -p|--primaries)
    PRIMARY_COUNT="$2"
    shift
    shift
    ;;
    -wpm|--water-phantom-module)
    if [ "$2" = "sphere" ]; then
      PHANTOM_MODULE=Module_phantom_sphere.mac
    fi
    shift
    shift
    ;;
    -wpt|--water-phantom-thickness)
    WATER_PHANTOM_THICKNESS="$2"
    shift
    shift
    ;;
    -wpx|--water-phantom-deltax)
    WATER_PHANTOM_X="$2"
    shift
    shift
    ;;
    -wpy|--water-phantom-deltay)
    WATER_PHANTOM_Y="$2"
    shift
    shift
    ;;
    -t|--particle-type)
    PARTICLE_TYPE="$2"
    shift
    shift
    ;;
    -e|--beam-energy)
    BEAM_ENERGY="$2"
    shift
    shift
    ;;
    -bdx|--beam-deltax)
    BEAM_DELTA_X="$2"
    shift
    shift
    ;;
    -bdy|--beam-deltay)
    BEAM_DELTA_Y="$2"
    shift
    shift
    ;;
    --seed)
    SEED="$2"
    shift
    shift
    ;;
    --help)
    RUN_HELP=true
    shift
    ;;
    *)
    shift
    ;;
esac
done

for file in "$SCRIPT_PATH/pre-simulation"/*.sh
do
    . $file
    if [ $? -ne 0 ]; then
        exit $?
    fi
done

for file in "$SCRIPT_PATH/simulation"/*.sh
do
    . $file
    if [ $? -ne 0 ]; then
        exit $?
    fi
done

for file in "$SCRIPT_PATH/post-simulation"/*.sh
do
    . $file
    if [ $? -ne 0 ]; then
        exit $?
    fi
done


