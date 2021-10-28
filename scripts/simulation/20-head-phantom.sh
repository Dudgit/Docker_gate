# Head Phantom
if [ "${SIMULATION_TYPE,,}" = "head_phantom" ]
then
  cd $MC_SIMULATIONS/head_phantom/
  echo 'Simulating head phantom...'
  Gate -a "[PRIMARY_COUNT, $PRIMARY_COUNT] [WATER_PHANTOM_THICKNESS, $WATER_PHANTOM_THICKNESS] [BEAM_ENERGY, $BEAM_ENERGY] [FILENAME, $OUTPUT_PATH/$FILENAME] [PARTICLE_TYPE, $PARTICLE_TYPE] [SEED, $SEED]" TestMain.mac &>/dev/null

  echo 'Gate simulation finished. Root file can be found under /output'
fi
