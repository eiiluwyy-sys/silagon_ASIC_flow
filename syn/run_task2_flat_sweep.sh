#!/bin/bash
################################################################################
# Task 2 four-point flat-synthesis sweep launcher.
################################################################################

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/.." && pwd )"

cd "${PROJECT_ROOT}" || exit 1

if [ "$#" -gt 0 ]; then
    CLOCK_PERIODS=("$@")
else
    CLOCK_PERIODS=("20.0" "10.0" "8.0" "6.0")
fi

for clock_period in "${CLOCK_PERIODS[@]}"; do
    echo "Running Task 2 flat synthesis at ${clock_period} ns"
    bash ./syn/run_synthesis.sh flat "${clock_period}"
done

python ./syn/scr/build_evidence_artifacts.py all
echo "Task 2 sweep finished and evidence artifacts refreshed."
