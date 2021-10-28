# Helper function to join arrays
function join { local IFS="$1"; shift; echo "$*"; }
re='^[0-9]+$'
re2='^[0-9]+([.][0-9]+)?$'

possible_simulation_types=("head_phantom" "rotated_geometry" "water_phantom" "water_phantom_secondaries" "simple_geometry")
possible_particle_type=("proton" "helium" "gamma")

if [[ $RUN_HELP = true ]]
then
    echo "Usage: docker run ???????????? simulation-environment:latest [OPTIONS]"
    echo "  -dt, --disable-tests"
    echo "                  Do not run any tests."
    echo "  -s, --simulation"
    echo "                  Specify the type of simulation to be executed, possible types are: [$(join , ${possible_simulation_types[@]})]"
    echo "  -p, --primaries"
    echo "                  Set the amount of primaries."
    echo "  -wpt, --water-phantom-thickness"
    echo "                  Specify the thickness of the water phantom. If no water phantom is used this parameter will be ignored."
    echo "  -t, --particle-type"
    echo "                  Set the particle type of the beam. Possible types are: [$(join , ${possible_particle_type[@]})]"
    echo "  -e, --beam-energy"
    echo "                  Set the amount of beam energy in MeV."
    echo "  --seed"
    echo "                  Specify a seed. Default: auto"
    exit 1
fi



if [[ ! "${possible_simulation_types[@]}" =~ "${SIMULATION_TYPE,,}" ]]
then
    echo "ERROR: The simulation \"$SIMULATION_TYPE\" did not exists. Possible values are:"
    join , ${possible_simulation_types[@]}
    exit 1
fi

if [[ ! $PRIMARY_COUNT =~ $re ]]
then
    echo "ERROR: The primary count must be a number without delimeter."
    exit 1
fi

if [[ ! $WATER_PHANTOM_THICKNESS =~ $re2 ]]
then
    echo "ERROR: The water phantom thickness must be a number."
    exit 1
fi


if [[ ! "${possible_particle_type[@]}" =~ "${PARTICLE_TYPE,,}" ]]
then
    echo "ERROR: The beam particle type \"$SIMULATION_TYPE\" did not exists. Possible values are:"
    join , ${possible_particle_type[@]}
    exit 1
fi

if [[ ! $BEAM_ENERGY =~ $re ]]
then
    echo "ERROR: The beam energy must be a number without delimeter."
    exit 1
fi
