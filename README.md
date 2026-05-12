# SiLagoNN ASIC Flow Portfolio

Portfolio-oriented ASIC/FPGA project repository centered on a SiLagoNN DRRA-based design flow. The repo is organized to let recruiters and interviewers understand the project in three passes:

1. What the design is and what was achieved
2. How the RTL, synthesis, and physical-design flows are organized
3. Where the original evidence, reports, and archived course artifacts live

## Project Snapshot

- **Design scope:** VHDL RTL for a DRRA-style accelerator wrapper and supporting compute / memory tiles
- **Flow scope:** RTL simulation, flat logic synthesis, bottom-up logic synthesis, and physical-synthesis evidence
- **Tooling:** ModelSim / Questa-style simulation scripts, Synopsys Design Compiler Tcl flows, physical-design handoff artifacts
- **Focus for interviews:** flow automation, synthesis tradeoff analysis, hierarchy-aware implementation, and evidence-backed reporting

## Key Results

### Task 2: Flat Logic Synthesis

| Clock (ns) | Total Power (mW) | Total Cell Area (um^2) | Slack (ps) |
| --- | ---: | ---: | ---: |
| 20 | 10.4133 | 358652 | 20.10 |
| 10 | 20.6254 | 359511 | 37.47 |
| 8 | 25.9535 | 365373 | 3.23 |
| 6 | 34.4214 | 389591 | 0.10 |

### Task 3: Bottom-Up Logic Synthesis

| Clock (ns) | Total Power (mW) | Total Cell Area (um^2) | Slack (ps) |
| --- | ---: | ---: | ---: |
| 20 | 10.4048 | 363814 | 9.22 |
| 10 | 20.6061 | 364621 | 8.61 |
| 8 | 26.8799 | 392192 | 0.12 |
| 6 | 35.3253 | 394994 | -209.41 |

### Task 4: Logic vs Physical Synthesis Comparison

| Stage | Total Power (mW) | Total Cell Area (um^2) | Slack (ps) |
| --- | ---: | ---: | ---: |
| Logic Synthesis | 10.4048 | 363814 | 29.24 |
| Physical Synthesis | 80.4640 | 381986 | -280.85 |

## Repository Layout

| Path | Purpose |
| --- | --- |
| `rtl/` | Main VHDL / Verilog source tree and simulation entry files |
| `tb/` | Standalone testbench material |
| `syn/` | Design Compiler scripts, summaries, reports, and handoff databases |
| `phy/` | Physical-design scripts, screenshots, reports, and evidence |
| `docs/` | Recruiter-facing documentation, flow index, and interview notes |
| `assets/` | Presentation decks, project brief PDF, and figures |
| `references/` | Supporting architecture views, package/interface snapshots, and course-side reference artifacts |

## Recommended Reading Order

1. `docs/FLOW_INDEX.md`
2. `syn/rpt/summary_tables/task2_flat_summary.md`
3. `syn/rpt/summary_tables/task3_bottomup_summary.md`
4. `phy/rpt/task4_historical_summary/README.md`
5. `docs/resume_project_intro.md`

## How To Run

Run RTL simulation from the repository root:

```bash
cd rtl
./START_SIMULATION.sh
```

Run synthesis from the repository root:

```bash
./syn/run_synthesis.sh flat 20.0
./syn/run_synthesis.sh bottomup 20.0
```

## Notes

- The repository still contains historical run artifacts because they support traceable explanation in interviews.
- Some generated synthesis outputs are large; GitHub accepts them but warns about file size.
- Local scratch outputs such as simulator libraries, transcripts, and temporary logs are ignored where practical via `.gitignore`.
