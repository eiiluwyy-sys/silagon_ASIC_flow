# SiLagoNN Project Cram Guide

This note is a fast review guide for the IL2225 project presentation and Q&A.
Course PDFs under `related_lectures/` are **not tracked in Git** (clone size / portfolio focus); keep them locally if you still need them. For a single canonical intro PDF in the portfolio repo, see the repository root `Project_2025_intro.pdf`. This guide was originally built from `related_lectures/Project_2025.pdf` and the current `project_presentation.pptx`.

## What the teacher is checking

From `Project_2025.pdf`:

- All six tasks should be completed to pass.
- The presentation slot is 20 minutes.
- There are about 40 minutes for questions and script checking.
- Each student is expected to understand all tasks, even if the group divided the work.

That means the real goal is:

- know the purpose of each task
- know the script entry point for each task
- know what input each task consumes
- know what output each task produces
- know why the next task depends on it
- know the main trade-offs and limitations

## Official six tasks

1. Task 1: RTL simulation in Questa
2. Task 2: flat logic synthesis in DC
3. Task 3: bottom-up logic synthesis in DC
4. Task 4: flat physical synthesis in Innovus
5. Task 5: floorplanning and partition creation
6. Task 6: hierarchical physical synthesis in Innovus

## One-sentence story of the whole project

We start by verifying that the RTL works functionally, then compare two logic-synthesis
styles, then move into physical implementation, first flat and then hierarchical, where
Task 5 prepares the partitions and Task 6 implements and reassembles them.

## End-to-end handoff chain

- Task 1 checks RTL behavior before synthesis.
- Task 2 creates a flat synthesized handoff under `syn/db/task2*/`.
- Task 3 creates a bottom-up synthesized handoff under `syn/db/task3*/`.
- Task 4 reads the flat synthesis handoff through `phy/scr/global_variables.tcl`.
- Task 5 reads the bottom-up handoff through `phy/scr/global_variables_hrchy.tcl` and creates partitions.
- Task 6 reuses those partitions, runs block P&R, then top-level P&R, then assembly.

## Task 1

### Goal

Show that the RTL design works before synthesis.

### Official input

- hierarchy file: `rtl/silagonn_hierarchy.txt`
- testbench in `tb/`

### Main scripts

- `rtl/compile.do`
- `rtl/simulate.do`
- `rtl/START_SIMULATION.sh`

### What the scripts do

- `compile.do` creates `work` and `dware` libraries
- compiles DesignWare helper files
- reads `silagonn_hierarchy.txt`
- compiles the full RTL hierarchy and testbench
- `simulate.do` launches `work.testbench`
- adds clock/reset, instruction-load, and DPU `<0,0>` signals to the waveform
- runs simulation and optionally saves waveform images

### What to say in the presentation

- The goal is functional verification, not PPA.
- We use the provided testbench for a simple vector-add style workload.
- The key observable is the DPU output of tile `<0,0>`.
- This task proves that later synthesis is applied to a functionally correct RTL.

### Common teacher questions

- Why do Task 1 first?
  Because synthesis and P&R only make sense after RTL behavior is validated.
- What exactly do you inspect?
  Reset, instruction loading, DPU inputs, and DPU outputs in the waveform.
- Why is `instruction.bin` important?
  The testbench needs it to load instructions that configure the data path.

## Task 2

### Goal

Run flat logic synthesis of `drra_wrapper` in Design Compiler and study PPA versus clock period.

### Official input

- hierarchy file: `rtl/drra_wrapper_hierarchy.txt`

### Main scripts

- `syn/run_task2_flat.sh`
- `syn/run_task2_flat_sweep.sh`
- `syn/run_task2_flat_sweep.ps1`
- `syn/run_synthesis.sh flat <clock>`
- `syn/scr/dc_flat.tcl`

### What `dc_flat.tcl` does

- loads `syn/synopsys_dc.setup`
- reads the full RTL hierarchy for `drra_wrapper`
- elaborates and links the top-level design
- sources `syn/constraints.sdc`
- overrides the clock period with `CLOCK_PERIOD`
- compiles the whole design flat
- writes reports for constraints, area, cells, timing, power, QoR
- writes synthesized outputs to `syn/db/task2_<period>/`

### Outputs

- reports: `syn/rpt/task2_<period>/`
- netlist and handoff: `syn/db/task2_<period>/`
- canonical summary table: `syn/rpt/summary_tables/task2_flat_summary.md`

### What to say in the presentation

- Flat synthesis gives the tool full visibility of the whole design.
- That usually helps global optimization, but the run is heavier and less modular.
- As the target clock gets tighter, power and area rise and slack shrinks.

### Safe comparison line

- Flat synthesis is better for whole-chip global optimization.
- It is less aligned with later hierarchical reuse.

## Task 3

### Goal

Run bottom-up logic synthesis and compare it with flat synthesis.

### Official input

- hierarchy file: `rtl/silego.txt` in the original project statement

### Main scripts

- `syn/run_task3_bottomup.sh`
- `syn/run_task3_bottomup.ps1`
- `syn/run_synthesis.sh bottomup <clock>`
- `syn/scr/dc_bottomup.tcl`

### What `dc_bottomup.tcl` does

- loads the DC setup and constraints
- compiles lower-level blocks first, especially `divider_pipe` and `silego`
- characterizes constraints for reused blocks
- protects previously compiled blocks with `dont_touch`
- compiles unique tile wrappers
- finally compiles `drra_wrapper` using those preserved blocks
- writes final reports and handoff files to `syn/db/task3_<period>/`

### Why bottom-up exists

- lower runtime and memory pressure
- preserve hierarchy
- support block reuse
- provide a more natural handoff for hierarchical physical design

### What to say in the presentation

- Bottom-up sacrifices some cross-boundary optimization.
- It is usually slightly worse in raw PPA than flat synthesis.
- Its real advantage is hierarchy preservation, which is exactly what Tasks 5 and 6 need.

### The most important sentence

Task 3 is not just another synthesis experiment. It is the setup step for hierarchical implementation.

## Task 4

### Goal

Run flat physical synthesis in Innovus and compare logic-level PPA with layout-aware PPA.

### Main scripts

- `phy/scr/run_flat_pnr.sh`
- `phy/scr/pnr_flat.tcl`
- `phy/scr/global_variables.tcl`
- `phy/scr/read_design.tcl`

### What the flow does

- reads MMMC, LEF, synthesized netlist, and SDC
- creates a floorplan
- runs power planning
- places the design
- runs CTS with `ccopt_design`
- routes the design
- writes final database, netlist, and timing/area/power/DRC reports

### Current handoff in this workspace

`phy/scr/global_variables.tcl` is set up to read `syn/db/task2` first, so the consolidated
main workspace tells the Task 4 story as the physical counterpart of Task 2.

### What to say in the presentation

- Logic synthesis is optimistic because it does not include real interconnect, clock-tree, and routing effects.
- Physical synthesis introduces wire RC, buffering, clock-tree insertion, and congestion effects.
- That usually increases power and area and worsens slack.

### Important honesty note

The current workspace preserves Task 4 presentation numbers as a canonical historical summary.
Do not claim every Task 4 table entry is reproducible from one untouched raw report folder.

## Task 5

### Goal

Create the floorplan and physical partitions needed for hierarchical implementation.

### Main scripts

- `phy/scr/create_partitions.tcl`
- `phy/scr/floorplan.tcl`
- `phy/scr/powerplan.tcl`
- `phy/scr/partition.tcl`
- `phy/scr/design_variables.tcl`

### What the flow does

- reads the hierarchical synthesis handoff
- creates a top-level floorplan sized for an 8x2 arrangement
- creates fence constraints for each tile region
- creates physical partitions for each repeated block
- assigns partition pins
- commits partitions
- writes partition databases under `phy/db/part/`

### What to say in the presentation

- Task 5 is the bridge between synthesis hierarchy and physical hierarchy.
- The floorplan decides where blocks live physically.
- Partitioning reduces the problem size and enables divide-and-conquer implementation.

### Key defense point

Task 5 is not the final implementation. It prepares the physical structure that Task 6 will implement.

## Task 6

### Goal

Implement the design hierarchically: run block-level P&R first, then top-level integration and assembly.

### Main scripts

- `phy/scr/run_hierarchical_pnr.sh`
- `phy/scr/pnr_partition.sh`
- `phy/scr/pnr_partition.tcl`
- `phy/scr/pnr_top.tcl`
- `phy/scr/assemble_design.tcl`

### What `run_hierarchical_pnr.sh` does

1. runs `create_partitions.tcl`
2. runs partition P&R using `pnr_partition.sh`
3. runs top-level P&R using `pnr_top.tcl`
4. runs final assembly using `assemble_design.tcl`

### Why ILM matters

- each partition is implemented separately
- each block exports an ILM abstraction
- the top-level run uses those ILMs instead of reopening every block as a full flat design
- this reduces complexity while preserving a top-level integration view

### What to say in the presentation

- Hierarchical P&R scales better for repeated blocks and large designs.
- We first solve each block locally, then reconnect them at top level.
- This is why Task 5 and Task 6 are tightly coupled.

## Key comparisons you must be ready to explain

### Flat vs bottom-up synthesis

- Flat: better global visibility, usually better raw optimization
- Bottom-up: preserves hierarchy, easier reuse, better for later hierarchical P&R

### Logic synthesis vs physical synthesis

- Logic synthesis: wireload-model level estimate, no real placement/routing
- Physical synthesis: actual floorplan, placement, CTS, routing, RC effects

### Flat physical vs hierarchical physical

- Flat physical: one large design, simpler flow to describe, less modular
- Hierarchical physical: partitioned flow, better scalability and reuse, more setup complexity

## High-risk Q&A points

### Q1. Why does Task 3 exist if Task 2 already synthesized the design?

Because Task 3 preserves hierarchy and creates a better handoff for Tasks 5 and 6.
It answers a different implementation question than Task 2.

### Q2. Why does physical synthesis usually worsen timing and power?

Because real wires, clock-tree buffers, routing congestion, and extraction effects are added.
Logic synthesis does not model all of those realistically.

### Q3. Why not just do everything flat?

Flat can optimize globally, but hierarchy becomes harder to preserve and the run scales worse.
For repeated blocks and partitioned implementation, hierarchical flow is more practical.

### Q4. What exactly is partitioning helping with?

It reduces problem size, enables parallel block implementation, and lets repeated structures be reused.

### Q5. Why does bottom-up often lose some PPA?

Because cross-boundary optimization is more limited when blocks are compiled separately and protected.

### Q6. What is the role of `dont_touch` in bottom-up synthesis?

It preserves previously compiled sub-blocks so the top-level compile does not re-optimize across those boundaries.

### Q7. What is the role of `create_timing_budget` in partitioning?

It tries to allocate timing expectations across partitions so block-level implementation can target compatible timing.

### Q8. Why is Task 5 required before Task 6?

Task 6 needs the partitions and floorplan produced in Task 5. Without them, there is no hierarchical physical structure to implement.

### Q9. What is an ILM in this context?

It is an interface-level abstract model of an implemented block that the top-level tool can reuse during hierarchical integration.

### Q10. If some summary numbers are historical, how should we answer?

Say clearly that the consolidated workspace keeps the presentation tables as canonical historical summaries,
while the preserved raw archives still support the methodology, the flow, and the main trend.

## What not to say

- do not claim every PPA table is a direct dump from one preserved report folder
- do not say Task 5 is optional if you are discussing hierarchical flow
- do not describe Task 3 as only a slower version of Task 2
- do not mix up the logical purpose of Task 4 and Task 6

## Minimal speaking spine for the 20-minute talk

1. Start with the six-task roadmap and dependencies.
2. Explain Task 1 as functional verification.
3. Explain Task 2 and Task 3 as a logic-synthesis comparison.
4. Explain why Task 3 leads naturally into Tasks 5 and 6.
5. Explain Task 4 as layout-aware flat implementation.
6. Explain Task 5 as physical preparation.
7. Explain Task 6 as block P&R plus top-level integration.
8. End with the trade-off summary: global optimization versus hierarchy preservation.

## Best study order tonight

1. Memorize the one-sentence purpose of each task.
2. Memorize the main script entry point for each task.
3. Memorize the handoff chain between tasks.
4. Memorize three comparisons:
   flat vs bottom-up, logic vs physical, flat physical vs hierarchical physical.
5. Practice answering why Tasks 5 and 6 depend on Task 3.
6. Only then switch to slide-by-slide speaker notes.
