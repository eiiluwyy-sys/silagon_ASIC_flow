#!/bin/bash
################################################################################
# Rebuild raw-report extracts, PPT-table extracts, and the evidence-gap map.
################################################################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/.." && pwd )"

cd "${PROJECT_ROOT}" || exit 1
python ./syn/scr/build_evidence_artifacts.py all
