date=$(date +%s)
WATER_THICKNESS=""

if [ "${SIMULATION_TYPE,,}" = "water_phantom" ]
then
    WATER_THICKNESS="${WATER_PHANTOM_THICKNESS}WPT_"
fi
# Water Phantom Secondaries
if [ "${SIMULATION_TYPE,,}" = "water_phantom_secondaries" ]
then
    WATER_THICKNESS="${WATER_PHANTOM_THICKNESS}WPT_"
fi

FILENAME="${SIMULATION_TYPE}_${PRIMARY_COUNT}Primaries_${BEAM_ENERGY}MeV_${WATER_THICKNESS}$date"
