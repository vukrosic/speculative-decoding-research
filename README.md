# Speculative Decoding Research

A durable research repository for speculative decoding, DFlash and DFlash2,
block diffusion, multi-token prediction, verification runtimes, drafter
training, exactness, acceptance, quality, hardware behavior, and end-to-end
serving performance.

This repository is designed for many years of experiments. It preserves what
worked, what failed, what remains uncertain, and the evidence behind every
claim. Large model/data artifacts are deliberately excluded from Git.

## North star

Build reusable knowledge and systems for training, verifying, benchmarking,
optimizing, and deploying speculative-generation methods across models,
workloads, runtimes, and hardware.

## Evidence ladder

An experiment may establish one level without establishing the next:

1. construction and finite-gradient correctness;
2. teacher-forced loss and token accuracy;
3. autoregressive draft acceptance;
4. task/output quality;
5. exact target-equivalence or a clearly declared approximate contract;
6. matched end-to-end latency and throughput;
7. generalization across workloads, hardware, and runtimes.

## Repository map

| Path | Purpose |
|---|---|
| `experiments/cards/` | One immutable, append-oriented card per experiment |
| `results/INDEX.md` | Cross-experiment result table and current incumbents |
| `failures/INDEX.md` | Negative results and failed assumptions |
| `models/`, `drafters/` | Target and drafter metadata records |
| `hardware/`, `runtimes/` | Reproducibility metadata |
| `datasets/`, `benchmarks/` | Data and evaluation contracts |
| `papers/` | Paper notes, implementation mappings, replication questions |
| `daily/` | Chronological lab notebook |
| `open-questions/` | Prioritized unknowns and proposed discriminating tests |
| `receipts/` | Small machine-readable receipts and hashes only |
| `templates/` | Required metadata templates |
| `prompts/` | Prompts for agents running and documenting research |
| `docs/` | Methodology, taxonomy, glossary, roadmap, and decisions |

## Start here

1. Read `AGENTS.md`.
2. Read `docs/RESEARCH-METHOD.md` and `results/INDEX.md`.
3. Create an experiment card from `templates/experiment-card.md`.
4. Freeze evaluation and define the promotion gate before running anything.
5. End with receipts and update the indexes, including failures.

## Current seeded knowledge

- SmolLM2-135M DFlash2-style on-policy block-3 training and capacity scaling.
- Qwen3.8-27B IQ1_S DFlash2 runtime exactness failures.
- Qwen compact 47.2M-drafter objective, capacity, proposal-length, quantization,
  and block-shape-alignment studies.
- The central recurring lesson: better teacher-forced metrics have repeatedly
  failed to guarantee better acceptance or serving speed.

## Artifact policy

Git stores knowledge, metadata, compact receipts, and hashes. It does not store
weights, GGUFs, feature corpora, datasets, environments, or large logs. See
`AGENTS.md` and `.gitignore`.

