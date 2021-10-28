# Check if tests should be executed
if $RUN_TESTS
then
  /usr/local/bin/run_tests.sh
else
  echo "Skipping tests."
fi
