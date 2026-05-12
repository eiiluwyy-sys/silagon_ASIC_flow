# Task 3 Reconstructed Flow

This note explains how Task 3 is organized in the consolidated `main` workspace.

## Why there is a reconstructed summary layer

The final Task 3 numbers used in the presentation were kept as the canonical team
result, but the original full report set that produced those exact PPA values was
not preserved in one untouched folder.

To keep the project explainable from one directory:

- the bottom-up synthesis script family is kept under `syn/scr/dc_bottomup.tcl`
- the preserved historical raw evidence remains under `syn/archive/task3/`
- the final presentation result table is preserved under `syn/data/task3_bottomup_summary.csv`
- summary reports regenerated from that table are written under `syn/rpt/summary_tables/`

## Canonical Task 3 files

- `syn/run_task3_bottomup.sh`
- `syn/run_task3_bottomup.ps1`
- `syn/scr/dc_bottomup.tcl`
- `syn/data/task3_bottomup_summary.csv`
- `syn/rpt/summary_tables/task3_bottomup_summary.md`

## How to explain the flow

1. `dc_bottomup.tcl` is the logic-synthesis flow that preserves hierarchy.
2. The preserved archives show the same bottom-up methodology and the same slack trend.
3. The final presentation numbers are kept canonically in `syn/data/task3_bottomup_summary.csv`.
4. `build_summary_reports.py` regenerates the summary artifacts used by the PPT and by the consolidated main workspace.

## Useful commands

```bash
./syn/run_task3_bottomup.sh run 20.0
./syn/run_task3_bottomup.sh summary
python ./syn/scr/build_summary_reports.py
```

```powershell
.\syn\run_task3_bottomup.ps1 -Mode run -ClockPeriod 20.0
.\syn\run_task3_bottomup.ps1 -Mode summary
```
