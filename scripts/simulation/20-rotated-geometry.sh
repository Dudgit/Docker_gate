# Water Phantom
if [ "${SIMULATION_TYPE,,}" = "rotated_geometry" ]
then
    cd $MC_SIMULATIONS/rotated_geometry/
    echo 'Simulating rotated water phantom...'

    while IFS=" " read -r angle s1_x_transition s1_z_transition s2_x_transition s2_z_transition
    do
	    echo -e "${ORANGE}Running simulation for $angle degrees.${NC}"
	    Gate -a "[PRIMARY_COUNT, $PRIMARY_COUNT] [PHANTOM_MODULE, $PHANTOM_MODULE] [WATER_PHANTOM_THICKNESS, $WATER_PHANTOM_THICKNESS] [BEAM_ENERGY, $BEAM_ENERGY] [FILENAME, $OUTPUT_PATH/$FILENAME] [PARTICLE_TYPE, $PARTICLE_TYPE] [SEED, $SEED] [angle, $angle] [scanner_one_x, $s1_x_transition] [scanner_one_z, $s1_z_transition] [scanner_two_x, $s2_x_transition] [scanner_two_z, $s2_z_transition]" Main_PSA.mac &>/dev/null
    done < "transition_values.txt"

    echo 'Gate simulation finished. Root file can be found under /output'
fi


