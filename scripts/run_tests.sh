#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export MC_TESTS=${MONTE_CARLO_TESTS:-"$DIR/../tests/func"}
export MC_SIMULATIONS=${MONTE_CARLO_SIMULATIONS:-"$DIR/../monte-carlo-simulations"}
export SCRIPT_PATH=${SCRIPT_PATH:-"$DIR/../scripts"}
COUNTER=0
TESTS_TOTAL=0
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m'

for directory in $MC_TESTS/* ; do
    echo -e "${ORANGE}--Executing Test: $directory--${NC}"
    ((TESTS_TOTAL++))
    $directory/init.sh
    if [ $? -eq 0 ]
    then
        ((COUNTER++))
        echo -e "${GREEN}Test finished successful${NC}"
    else
        echo -e "${RED}Test finished with errors.${NC}"
    fi
done

echo -e "${ORANGE}$COUNTER out of $TESTS_TOTAL tests passed.${NC}"
