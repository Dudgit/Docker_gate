# Water Phantom
if [ "${SIMULATION_TYPE,,}" = "simple_geometry" ]
then
  cd $MC_SIMULATIONS/simple_geometry/
  echo 'Simulating simple_geometry...'
  Gate -a "[PRIMARY_COUNT, $PRIMARY_COUNT] [WATER_PHANTOM_THICKNESS, $WATER_PHANTOM_THICKNESS] [BEAM_ENERGY, $BEAM_ENERGY] [FILENAME, $OUTPUT_PATH/$FILENAME] [PARTICLE_TYPE, $PARTICLE_TYPE] [SEED, $SEED]" Main.mac &>/dev/null

  echo 'Gate simulation finished. Root file can be found under /output'
fi
