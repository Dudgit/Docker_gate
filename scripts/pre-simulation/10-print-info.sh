##
# Print values to use for simulation
#
TEMP=${PHANTOM_MODULE#Module_phantom_}
PHANTOM_GEOMETRY="${TEMP%.mac}"
 
echo "########################################"
echo "# Values specified for the simulation  #"
echo "#--------------------------------------#"
echo "Simulation: $SIMULATION_TYPE"
echo "Beam energy: $BEAM_ENERGY MeV"
echo "Beam deltaX: $BEAM_DELTA_X"
echo "Beam deltaY: $BEAM_DELTA_Y"
echo "Primary count: $PRIMARY_COUNT"
echo "Particle type: $PARTICLE_TYPE"
echo "Waterphantom module: $PHANTOM_GEOMETRY"
echo "Waterphantom thickness: $WATER_PHANTOM_THICKNESS"
echo "Waterphantom X: $WATER_PHANTOM_X"
echo "Waterphantom Y: $WATER_PHANTOM_Y"
echo "Seed: $SEED"
echo "########################################"
