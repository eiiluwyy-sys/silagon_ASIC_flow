#!/bin/bash
################################################################################
# Unified synthesis launcher for reexam preparation
#
# Usage:
#   ./run_synthesis.sh [flat|bottomup] [clock_period_ns]
# Examples:
#   ./run_synthesis.sh flat 20.0
#   ./run_synthesis.sh bottomup 10.0
################################################################################

MODE=${1:-flat}
CLOCK_PERIOD=${2:-20.0}

case "${MODE}" in
    flat|task2)
        TCL_SCRIPT="syn/scr/dc_flat.tcl"
        TASK_LABEL="Task 2 - Flat logic synthesis"
        ;;
    bottomup|task3)
        TCL_SCRIPT="syn/scr/dc_bottomup.tcl"
        TASK_LABEL="Task 3 - Bottom-up logic synthesis"
        ;;
    *)
        echo "Error: unknown mode '${MODE}'. Use 'flat' or 'bottomup'."
        exit 1
        ;;
esac

echo "=========================================="
echo "DRRA_wrapper Synthesis Launcher"
echo "Flow: ${TASK_LABEL}"
echo "Clock Period: ${CLOCK_PERIOD}ns"
echo "=========================================="

if [ ! -f "rtl/drra_wrapper_hierarchy.txt" ] || [ ! -f "${TCL_SCRIPT}" ]; then
    echo "Error: please run from SiLagoNN_main_project root."
    exit 1
fi

if ! command -v dc_shell >/dev/null 2>&1; then
    echo "Error: dc_shell not found in PATH."
    exit 1
fi

mkdir -p exe
export CLOCK_PERIOD

cd exe || exit 1
dc_shell -f "../${TCL_SCRIPT}"

