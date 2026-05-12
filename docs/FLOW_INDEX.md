# Main Flow Index

This file is the canonical "how to tell the whole story from main" index.

## Canonical speaking order

1. `Task 1` - RTL simulation
2. `Task 2` - Flat logic synthesis
3. `Task 3` - Bottom-up logic synthesis
4. `Task 4` - Flat physical synthesis
5. `Task 5` - Floorplanning / partition creation
6. `Task 6` - Hierarchical physical synthesis

## Canonical script entry points

### Task 1

- `rtl/compile.do`
- `rtl/simulate.do`
- `rtl/START_SIMULATION.sh`

### Task 2

- `syn/run_task2_flat.sh`
- `syn/run_task2_flat_sweep.sh`
- `syn/run_task2_flat_sweep.ps1`
- `syn/run_synthesis.sh flat <clock_period_ns>`
- `syn/scr/dc_flat.tcl`
- `syn/build_summary_reports.sh`
- `syn/build_evidence_artifacts.sh`
- `syn/build_evidence_artifacts.ps1`
- `syn/scr/build_evidence_artifacts.py`

Outputs are organized as:

- `syn/db/task2_<period>/`
- `syn/rpt/task2_<period>/`

Canonical presentation summary:

- `syn/data/task2_flat_summary.csv`
- `syn/data/task2_flat_summary_from_ppt.csv`
- `syn/data/task2_flat_raw_extract.csv`
- `syn/data/task2_flat_evidence_map.csv`
- `syn/rpt/summary_tables/task2_flat_summary.md`
- `syn/rpt/summary_tables/task2_flat_summary.txt`

Canonical physical-design handoff directory:

- `syn/db/task2/`

Historical evidence kept for explanation:

- `syn/archive/task2/from_silagonn_2_task4/db_10ns/`
- `syn/archive/task2/from_silagonn_2_task4/rpt_10ns/`
- `syn/archive/task2/from_silagonn_2_task4/rpt_500ps/`
- `syn/archive/task2/from_silagonn_1/report_20ps/`
- `syn/archive/task2/from_silagonn_1/report_5ns/`

### Task 3

- `syn/run_task3_bottomup.sh`
- `syn/run_task3_bottomup.ps1`
- `syn/run_synthesis.sh bottomup <clock_period_ns>`
- `syn/scr/dc_bottomup.tcl`
- `syn/build_summary_reports.sh`
- `syn/build_evidence_artifacts.sh`
- `syn/build_evidence_artifacts.ps1`
- `syn/scr/build_evidence_artifacts.py`
- `syn/TASK3_RECONSTRUCTED_FLOW.md`

Outputs are organized as:

- `syn/db/task3_<period>/`
- `syn/rpt/task3_<period>/`

Canonical presentation summary:

- `syn/data/task3_bottomup_summary.csv`
- `syn/data/task3_bottomup_summary_from_ppt.csv`
- `syn/data/task3_bottomup_raw_extract.csv`
- `syn/data/task3_bottomup_evidence_map.csv`
- `syn/rpt/summary_tables/task3_bottomup_summary.md`
- `syn/rpt/summary_tables/task3_bottomup_summary.txt`
- `syn/rpt/task3_historical_summary/`

Canonical physical-design handoff directory:

- `syn/db/task3/`

Historical evidence kept for explanation:

- `syn/archive/task3/from_silagonn_1/bottom_20ns/`
- `syn/archive/task3/from_silagonn_1/bottom_10ns/`
- `syn/archive/task3/from_silagonn_1/bottom_8ns/`
- `syn/archive/task3/from_silagonn_1/bottom_6ns/`

### Task 4

- `phy/scr/run_flat_pnr.sh`
- `phy/scr/export_task4_physical_ppa.sh`
- `phy/scr/export_task4_physical_ppa.ps1`
- `phy/scr/pnr_flat.tcl`
- `phy/data/task4_flat_physical_summary.csv`
- `phy/data/task4_flat_physical_summary_from_ppt.csv`
- `phy/data/task4_flat_physical_raw_extract.csv`
- `phy/data/task4_flat_physical_evidence_map.csv`
- `phy/rpt/task4_historical_summary/`
- `EVIDENCE_GAP_MAP.md`

Expected Task 2 input:

- `syn/db/task2/`

### Task 5

- `phy/scr/run_task5_only.sh`
- `phy/scr/create_partitions.tcl`
- `phy/scr/floorplan.tcl`

### Task 6

- `phy/scr/run_hierarchical_pnr.sh`
- `phy/scr/pnr_partition.sh`
- `phy/scr/pnr_partition.tcl`
- `phy/scr/pnr_top.tcl`
- `phy/scr/assemble_design.tcl`

Expected Task 3 input:

- `syn/db/task3/`

Historical screenshots:

- `phy/archive/task5_task6/`

## Historical evidence archive

To support explanation without modifying the original student folders:

- historical synthesis evidence is copied under `syn/archive/`
- canonical presentation tables are rebuilt from `syn/data/` into `syn/rpt/summary_tables/`
- historical physical screenshots are copied under `phy/archive/`
- canonical Task 2 handoff netlist is staged in `syn/db/task2/`
- canonical Task 3 handoff netlist is staged in `syn/db/task3/`

## Important caveat

The PPT contains presentation-oriented summary tables. In the consolidated `main`
workspace, those tables now have an explicit canonical source under `syn/data/`
and generated summary reports under `syn/rpt/summary_tables/`, so the speaking flow,
summary tables, and supporting scripts remain aligned.
