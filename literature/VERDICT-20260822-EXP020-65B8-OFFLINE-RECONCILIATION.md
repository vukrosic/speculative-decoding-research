---
date: 2026-08-22
kind: literature/evidence disposition
scope: EXP020 current-65b8 offline parser split and source-map audit
status: descriptive diagnostic closed; source-backed optimization blocked
---

# Offline phase reconciliation

## Confirmed descriptive evidence

The preserved logs now have a task-ID split: Q4 warmup task `1` and
diagnostic task `42`, each with 35 verification cycles; target-only diagnostic
task `70` has no speculative markers. For Q4 diagnostic task `42`, immutable
log parsing yields `VERIFY_BATCH_BEGIN → VERIFY_BEGIN` 1745.412 ms,
`VERIFY_BEGIN → VERIFY_RESULT` 55.829 ms, and `VERIFY_RESULT → MEMORY_AFTER`
0.601 ms. Warmup values are 1853.610, 58.786, and 0.605 ms. The derived
diagnostic draft-generation increment is approximately 378.665 ms over 35
draft calls. These are marker-derived intervals from the current 65b8 log,
not a new run.

The target oracle remains `0f76b6ae…`; Q4 remains `1d5020bf…` with 35 proposed
and 28 accepted draft tokens. The output difference is preserved as a
diagnostic boundary. The source-map audit found only hash references for the
pinned `common/speculative.cpp` and `tools/server/server-context.cpp` files,
not their exact source payloads, so no marker can be assigned to a causal
source operation.

## Interpretation and claim boundary

The split improves accounting scope and supports a bounded within-runtime
phase-cost description. It does not establish end-to-end speed, exactness,
target equivalence, acceptance improvement, verifier/state correctness,
losslessness, or a removable bottleneck. The large batch-to-verify subtotal
and smaller rollback interval are prioritization clues only; they may include
draft, target, graph, and transaction work. Do not compare these intervals to
the historical `d07ed8b4…` trace or treat the 35/28 counters as an exactness
metric.

## Next admissible action

Do not rerun, patch, rebuild, or launch another GPU arm. The smallest
source-backed follow-up is read-only intake of the two exact pinned source
files (full bytes matching `6a24e473…` and `c060c9f5…`), followed by the same
local marker-to-source map. Until that source payload exists, retain the
`NO_CANDIDATE / SOURCE GAP` disposition and keep any verify-batch, graph,
allocator, or draft-generation intervention behind a new planner/critic/
literature packet with correctness-first gates.

Sources: `experiments/planning/runtime-qwen-exp020-current-65b8-phase-pair-postrun-ranking-20260822.md`,
`receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/pq020-request-cycle-joined.json`,
`source-map-audit-20260822.json`, and the current pair summary/terminal. No
GPU, source patch, build, or rerun occurred in this review.
