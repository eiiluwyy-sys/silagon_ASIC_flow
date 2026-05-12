# Canonical Synthesis Handoff Directories

This directory is the simplified handoff point between logic synthesis and
physical synthesis in the reexam version of `main`.

## Canonical directories

- `task2/`
  - canonical flat-synthesis handoff for Task 4
  - seeded from the preserved `SiLagoNN_2/Task4` 10 ns result set
- `task2_10ns/`
  - explicit historical copy of the same preserved 10 ns flat result set
- `task3/`
  - canonical bottom-up handoff for Task 6
  - seeded from the preserved `SilagoNN_1` bottom-up 20 ns result set
- `task3_20ns/`
  - explicit historical copy of the same preserved 20 ns bottom-up result set

## Why this exists

The original student folders do not preserve one perfectly clean run directory for
every PPT table and every task. For reexam preparation, the goal is to keep one
coherent story:

1. Task 2 produces a flat netlist in `syn/db/task2/`
2. Task 4 reads `syn/db/task2/`
3. Task 3 produces a hierarchical handoff netlist in `syn/db/task3/`
4. Task 6 reads `syn/db/task3/`

Detailed historical evidence is stored separately under `syn/archive/`.
