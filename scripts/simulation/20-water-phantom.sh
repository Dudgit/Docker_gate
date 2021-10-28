# Water Phantom
if [ "${SIMULATION_TYPE,,}" = "water_phantom" ]
then
  cd $MC_SIMULATIONS/water_phantom/
  echo 'Simulating water phantom...'
  Gate -a "[PRIMARY_COUNT, $PRIMARY_COUNT] [WATER_PHANTOM_THICKNESS, $WATER_PHANTOM_THICKNESS] [BEAM_ENERGY, $BEAM_ENERGY] [FILENAME, $OUTPUT_PATH/$FILENAME] [PARTICLE_TYPE, $PARTICLE_TYPE] [SEED, $SEED]" TestMain.mac

  echo 'Gate simulation finished. Root file can be found under /output'
fi
