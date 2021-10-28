# Water Phantom secondaries
if [ "${SIMULATION_TYPE,,}" = "water_phantom_secondaries" ]
then
  cd $MC_SIMULATIONS/water_phantom/
  echo 'Simulating water phantom secondaries...'
  Gate -a "[PRIMARY_COUNT, $PRIMARY_COUNT] [WATER_PHANTOM_THICKNESS, $WATER_PHANTOM_THICKNESS] [BEAM_ENERGY, $BEAM_ENERGY] [FILENAME, $OUTPUT_PATH/$FILENAME] [PARTICLE_TYPE, $PARTICLE_TYPE] [SEED, $SEED]" TestSecondaries.mac &>/dev/null

  echo 'Gate simulation finished. Root file can be found under /output'
fi
