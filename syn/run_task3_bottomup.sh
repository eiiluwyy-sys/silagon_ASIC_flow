#!/bin/bash
################################################################################
# Task 3 convenience launcher
################################################################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/.." && pwd )"

cd "${PROJECT_ROOT}" || exit 1

MODE=${1:-run}
CLOCK_PERIOD=${2:-20.0}

case "${MODE}" in
    run)
        bash ./syn/run_synthesis.sh bottomup "${CLOCK_PERIOD}" || exit 1
        python ./syn/scr/build_summary_reports.py || exit 1
        echo "Task 3 raw synthesis flow finished and canonical summary tables refreshed."
        ;;
    summary|historical-summary)
        python ./syn/scr/build_summary_reports.py || exit 1
        echo "Task 3 canonical historical summary refreshed from syn/data/task3_bottomup_summary.csv."
        ;;
    evidence|extract-archive|extract)
        python ./syn/scr/build_evidence_artifacts.py all || exit 1
        echo "Task 3 evidence artifacts refreshed from preserved raw reports and PPT tables."
        ;;
    sweep)
        shift
        if [ "$#" -gt 0 ]; then
            CLOCK_PERIODS=("$@")
        else
            CLOCK_PERIODS=("20.0" "10.0" "8.0" "6.0")
        fi
        for period in "${CLOCK_PERIODS[@]}"; do
            bash ./syn/run_synthesis.sh bottomup "${period}" || exit 1
        done
        python ./syn/scr/build_summary_reports.py || exit 1
        python ./syn/scr/build_evidence_artifacts.py all || exit 1
        echo "Task 3 sweep finished and evidence artifacts refreshed."
        ;;
    *)
        echo "Usage:"
        echo "  ./syn/run_task3_bottomup.sh run [clock_period_ns]"
        echo "  ./syn/run_task3_bottomup.sh summary"
        echo "  ./syn/run_task3_bottomup.sh evidence"
        echo "  ./syn/run_task3_bottomup.sh sweep [clock_period_ns ...]"
        exit 1
        ;;
esac
