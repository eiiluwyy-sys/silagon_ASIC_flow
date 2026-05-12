#!/bin/bash
################################################################################
# Rebuild canonical Task 2 / Task 3 summary tables used by the consolidated main
# workspace and the presentation deck.
################################################################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/.." && pwd )"

cd "${PROJECT_ROOT}" || exit 1
python ./syn/scr/build_summary_reports.py
