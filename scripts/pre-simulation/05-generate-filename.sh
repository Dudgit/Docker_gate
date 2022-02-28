date=$(date +%s)
WATER_THICKNESS=""
WATER_X=""
WATER_Y=""
BEAM_X=""
BEAM_Y=""
GEOMETRY=""

if [ "${SIMULATION_TYPE,,}" = "water_phantom" ]
then
    TEMP=${PHANTOM_MODULE#Module_phantom_}
    GEOMETRY="${TEMP%.mac}_"
    WATER_THICKNESS="${WATER_PHANTOM_THICKNESS}WPT_"
    WATER_X="${WATER_PHANTOM_X}WPX_"
    WATER_Y="${WATER_PHANTOM_Y}WPY_"
    BEAM_X="${BEAM_DELTA_X}BX_"
    BEAM_Y="${BEAM_DELTA_Y}BY_"
fi
# Water Phantom Secondaries
if [ "${SIMULATION_TYPE,,}" = "water_phantom_secondaries" ]
then
    WATER_THICKNESS="${WATER_PHANTOM_THICKNESS}WPT_"
fi

FILENAME="${SIMULATION_TYPE}_${PRIMARY_COUNT}Primaries_${BEAM_ENERGY}MeV_${BEAM_X}${BEAM_Y}${GEOMETRY}${WATER_THICKNESS}${WATER_X}${WATER_Y}$date"

