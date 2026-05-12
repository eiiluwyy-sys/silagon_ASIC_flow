# Reexam Mapping Draft

This file is a working map for explaining the project from one repository root:

- main workspace: repository root
- supporting sources: `SilagoNN_1` and `SiLagoNN_2`
- PPT reference: `project_presentation.pptx`

The goal is not to claim that every PPT number is reproduced by the current `main`
tree. The goal is to explain which task flow belongs to which script family, which
results are still present, and which PPT pages appear to be manually organized from
older runs.

## Overall judgment

The current repository root is the best single workspace for reexam preparation, but it is
already a merged workspace rather than one original author's untouched run.

Current evidence suggests:

- `main/rtl` is the best Task 1 entry point.
- `main/phy/scr` is mostly the Task 4/5/6 script family from `SilagoNN_1`, with
  extra wrapper scripts and notes added later.
- `main/syn/scr` is closer to the `SiLagoNN_2` script family than to the tutorial-
  style Task 2 script in `SilagoNN_1`.
- `main/syn/rpt_10ns` and `main/syn/rpt_500ps` match the `SiLagoNN_2/Task4/.../syn`
  result set.
- `main/syn/db/task2` is now staged from the preserved `SiLagoNN_2/Task4` 10 ns
  flat-synthesis handoff.
- `main/syn/db/task3` is now staged from the preserved `SilagoNN_1` bottom-up 20 ns
  handoff.
- Task 6 screenshots in the PPT are directly traceable to `SilagoNN_1`, and copies
  of them were later placed in `main`.

## Task-by-task map

## Task 1 - RTL simulation

Primary explanation folder:

- `rtl/`

Best scripts/files to explain:

- `rtl/compile.do`
- `rtl/simulate.do`
- `rtl/START_SIMULATION.sh`
- `rtl/RUN_SIMULATION.md`
- `rtl/vsim.wlf`

Assessment:

- `main` is the cleanest place to explain Task 1.
- `SilagoNN_1` does not preserve the same complete simulation launcher set.
- PPT waveform screenshots are consistent with a ModelSim/Questa flow like the one
  in `main`, but an exact source image file has not been identified yet.

Confidence:

- High for using `main` as the Task 1 story.
- Medium for exact screenshot provenance.

## Task 2 - Flat logic synthesis

Primary script candidates:

- `syn/scr/dc_flat.tcl`
- `SilagoNN_1/SiLagoNN/syn/scr/dc_flat.tcl`
- `SiLagoNN_2/Task4/Synthesis-of-the-DRRA-Fabric-main/SiLagoNN/syn/scr/dc_flat.tcl`

What each source looks like:

- `main/syn/scr/dc_flat.tcl`
  - complete reexam-oriented script
  - accepts `CLOCK_PERIOD` and writes to `task2_<period>` directories
  - simplified so the Task 2 flow is easier to explain from `main`
- `SilagoNN_1/.../dc_flat.tcl`
  - tutorial-style Task 2 script
  - clearly labeled as Task 2
  - real flat reports are preserved, but only for `20ps` and `5ns`
- `SiLagoNN_2/Task2/syn/scr/dc_flat.tcl`
  - only a header placeholder
  - not enough to use as the main explanation script
- `SiLagoNN_2/Task4/.../syn/scr/dc_flat.tcl`
  - complete script
  - nearly the same family as `main/syn/scr/dc_flat.tcl`

Most likely relationship:

- The current `main` Task 2 script lineage comes from the `SiLagoNN_2` script family.
- The current `main` Task 2 script has been simplified and aligned with the
  multi-period explanation flow for reexam preparation.
- `SilagoNN_1` keeps an older but clearer "Task2" script and real flat reports,
  although not the same clock sweep shown in the PPT.
- `main` now keeps the useful preserved evidence under:
  - `syn/archive/task2/from_silagonn_2_task4`
  - `syn/archive/task2/from_silagonn_1`

PPT table assessment for Task 2:

- PPT numbers shown:
  - 20ns: power `10.4133`, area `358652`, slack `20.10`
  - 10ns: power `20.6254`, area `359511`, slack `37.47`
  - 8ns: power `25.9535`, area `365373`, slack `3.23`
  - 6ns: power `34.4214`, area `389591`, slack `0.10`
- Exact full four-point source set is not preserved in the current folders.
- The 10ns pair `20.6254` + `359511` matches:
  - `syn/rpt_10ns`
  - `SiLagoNN_2/Task4/.../syn/rpt_10ns`
- The corresponding slack in those preserved reports is `57.47`, not `37.47`.
- The 20ns/8ns/6ns values from the PPT do not match the preserved flat reports in
  `SilagoNN_1`, and no exact file with all four PPT rows has been found.

Conclusion for Task 2:

- Explain Task 2 from `main/syn/scr/dc_flat.tcl`, but explicitly note that the PPT
  PPA table is now preserved canonically in:
  - `main/syn/data/task2_flat_summary.csv`
  - `main/syn/rpt/summary_tables/task2_flat_summary.md`
- This gives the consolidated workspace one stable summary source even though the raw
  four-point flat report sweep is only partially preserved.

Confidence:

- High for script-family relationship.
- Medium for the exact source of the PPT table.

## Task 3 - Bottom-up logic synthesis

Primary script candidates:

- `syn/scr/dc_bottomup.tcl`
- `SilagoNN_1/SiLagoNN/syn/scr/dc_bottomup.tcl`
- `SiLagoNN_2/Task4/.../syn/scr/dc_bottomup.tcl`

Relationship:

- `main/syn/scr/dc_bottomup.tcl` is much closer to the `SiLagoNN_2` family than to
  the tutorial-style `SilagoNN_1` version.
- `SilagoNN_1` preserves the cleanest multi-point bottom-up report set:
  - `bottom_20ns`
  - `bottom_10ns`
  - `bottom_8ns`
  - `bottom_6ns`

Best preserved Task 3 results:

- `SilagoNN_1/SiLagoNN/syn/report/bottom_20ns`
- `SilagoNN_1/SiLagoNN/syn/report/bottom_10ns`
- `SilagoNN_1/SiLagoNN/syn/report/bottom_8ns`
- `SilagoNN_1/SiLagoNN/syn/report/bottom_6ns`

Important note:

- Some PPT Task 3 / Task 2 tables appear to mix numbers from different runs or from
  manually prepared summary tables.
- The preserved `main` bottom-up reports are incomplete compared with `SilagoNN_1`.
- The consolidated workspace now preserves the Task 3 presentation table explicitly in:
  - `main/syn/data/task3_bottomup_summary.csv`
  - `main/syn/rpt/summary_tables/task3_bottomup_summary.md`
- This Task 3 table now serves as the canonical historical summary used by the PPT,
  rather than pretending to be a direct dump of one untouched archived report folder.

Confidence:

- High for using `SilagoNN_1` as the strongest evidence source for Task 3 results.
- High for using `main` as the explanation shell after mapping those results back.

## Task 4 - Flat physical synthesis

Primary script family:

- `phy/scr/pnr_flat.tcl`
- `SilagoNN_1/SiLagoNN/phy/scr/pnr_flat.tcl`

Relationship:

- `main/phy/scr/pnr_flat.tcl` and `SilagoNN_1/.../pnr_flat.tcl` are almost the same,
  with path adjustments for the merged workspace.
- `main/phy/scr/run_flat_pnr.sh` is a later wrapper added on top of that family.

Current simplified handoff:

- `main/phy/scr/global_variables.tcl` now resolves to `main/syn/db/task2`.
- `main/syn/db/task2` is staged from the preserved `SiLagoNN_2/Task4` 10 ns result
  set so Task 4 can be explained from `main` without jumping folders.

PPT relation:

- The flat physical synthesis screenshots are present in the PPT.
- The final before/after PPA comparison table used in the presentation is now
  preserved canonically in:
  - `main/phy/data/task4_flat_physical_summary.csv`
  - `main/phy/rpt/task4_historical_summary/`
- This lets the consolidated workspace keep the final Task 4 result table even
  though one untouched original raw report set was not preserved.

Confidence:

- High for script family.
- Medium for the canonical historical summary now preserved in `main`.

## Task 5 - Floorplanning

Primary explanation scripts in `main`:

- `phy/scr/create_partitions.tcl`
- `phy/scr/floorplan.tcl`
- `phy/scr/design_variables.tcl`
- `phy/scr/run_task5_only.sh`

Relationship:

- Core Task 5 scripts in `main` are effectively the same family as
  `SilagoNN_1/SiLagoNN/phy/scr`.
- `main` adds helper docs and wrappers that make it better for a one-person reexam.
- Historical screenshots useful for Task 5/6 are now archived in
  `main/phy/archive/task5_task6`.

PPT relation:

- The floorplanning story in the PPT matches this script family well.
- The exact screenshot used for Task 5 in the PPT is not a byte-identical copy of
  `SilagoNN_1/SiLagoNN/phy/task5_output.png`; it looks like a different export or crop.

Confidence:

- High for script provenance.
- Medium for exact screenshot provenance.

## Task 6 - Hierarchical physical synthesis

Primary scripts in `main`:

- `phy/scr/pnr_partition.tcl`
- `phy/scr/pnr_partition.sh`
- `phy/scr/pnr_top.tcl`
- `phy/scr/assemble_design.tcl`
- `phy/scr/run_hierarchical_pnr.sh`

Relationship:

- Core hierarchical physical synthesis scripts are strongly aligned with the
  `SilagoNN_1` physical synthesis family.
- `main` adds wrapper scripts and guide documents to make the flow easier to explain.

Strong source evidence:

- `assets/figures/Hierarchical Physical synthesis.png` is identical to
  `SilagoNN_1/SiLagoNN/phy/task6_Hierarchical Physical synthesis.png`
- `assets/figures/Hierarchical Physical synthesis (2).png` is identical to
  `SilagoNN_1/SiLagoNN/phy/task6_Hierarchical Physical synthesis (2).png`

Conclusion:

- Task 6 results in the PPT are fundamentally from the `SilagoNN_1` result set,
  then copied into `main`.

Confidence:

- High.

## PPT-to-source quick map

- Task 1 pages:
  - use `main/rtl` as the story and execution entry
- Task 2 page:
  - explain with `main/syn/scr/dc_flat.tcl`
  - note that the exact four-row PPT PPA table is not fully reproducible from the
    current preserved flat-report directories
- Task 3 pages:
  - explain with `main/syn/scr/dc_bottomup.tcl`
  - use `SilagoNN_1` report folders as the strongest preserved evidence set
- Task 4 pages:
  - explain with `main/phy/scr/pnr_flat.tcl`
  - use the simplified reexam handoff in `main/syn/db/task2`
- Task 5 page:
  - explain with `main/phy/scr/create_partitions.tcl` and `floorplan.tcl`
- Task 6 pages:
  - explain with `main/phy/scr/run_hierarchical_pnr.sh`
  - use copied images in `main` and original images in `SilagoNN_1`

## What is still missing

- Exact preserved source files for the full PPT Task 2 four-row flat-synthesis table.
- Exact preserved source files for the PPT Task 4 before/after physical synthesis
  comparison table.
- Some PPT summary numbers that appear to have been manually assembled across runs.

## Current integration status

The `main` workspace now contains:

1. a unified Task 2 launcher and Task 3 launcher
2. `syn/synopsys_dc.setup` copied in from the strongest preserved Synopsys setup
3. canonical handoff directories:
   - `syn/db/task2`
   - `syn/db/task3`
4. historical evidence archives:
   - `syn/archive/task2`
   - `syn/archive/task3`
   - `phy/archive/task5_task6`
5. canonical presentation summary tables:
   - `syn/data/task2_flat_summary.csv`
   - `syn/data/task3_bottomup_summary.csv`
   - regenerated into `syn/rpt/summary_tables/`

This is enough to use `main` as the single folder for explaining all six tasks,
while still being honest about which historical results came from folder `1` or `2`.
