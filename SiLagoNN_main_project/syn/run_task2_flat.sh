#!/bin/bash
################################################################################
# Task 2 convenience launcher
################################################################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/.." && pwd )"

cd "${PROJECT_ROOT}" || exit 1
bash ./syn/run_synthesis.sh flat "${1:-20.0}"
