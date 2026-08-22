---
id: RUNTIME-QWEN-EXP020-CURRENT-65B8-PHASE-PAIR-POSTRUN-RANKING-20260822
date: 2026-08-22
status: terminal-descriptive-next-action-parser-warmup-split
scope: reconcile completed current-65b8 phase diagnostic and rank follow-up; no rerun, patch, or promotion
parent: EXP-20260822-020-qwen-singleton-correction
---

# EXP020 current-65b8 post-run reconciliation and next-action ranking

## Receipt closure

The matched pair completed under one current instrumented runtime. The
authoritative compact receipts are:

- manifest `current-65b8-phase-pair-20260822/SHA256SUMS.txt`, SHA-256
  `070950d2bca67fa7586b35e98029a5c1d589b346b44433a6508b488d3e61f9b2`;
- summary `summary.json`, SHA-256
  `4e51b43710694f2895e4b783e01ee993e52f2cfb24d6195926161e1d57c7204b`;
- terminal `terminal.md`, SHA-256
  `a6d2c9fe6227e852d04a7c9fdb56501f1ca30744eadc1e2378deac4e7f6fdfd0`;
- cleanup `cleanup.json`, SHA-256
  `92e16f04cf29c7bd0be4664efdb6c85bca4930b63e0b93a600fabdad151f79cb`.

Frozen identities remained target `3895b6e...`, Q4 drafter `18a380e...`,
client `477b271d...`, prompt `374eea10...`, current server `fcbf4b9d...`,
current `libllama-common` `65b8a862...`, and implementation `fd5a9bf6...`.
The task-local runner SHA is `1adb22e41338f57e11910505e149d6b73d50e3b5a33e4c5e76688a6455601843`;
the phase parser SHA is
`610f8466e64e7b9a1d30bbd07796485898ced38f5598be1b22109ca5c57dbc1b`.
Both arms used cache-off, greedy temperature 0/top-k 1/seed 42, context 4096,
one GPU process sequentially, `LLAMA_TRACE=1`, `PQ020_TRACE=1`, and no
low-margin or split-flash overrides. Cleanup ended with the RTX 3060 at 1 MiB,
0% utilization, and no task processes.

## Observed evidence

### Target-only diagnostic (task 70)

- Fresh target oracle passed assistant-message SHA
  `0f76b6ae57040714633aa638719e0c2a9b3c594cc2ff0ce4bafc75cabee56a6c`,
  64 completion tokens, and `finish_reason=length`.
- Client timing: prompt `504.999 ms`, predicted decode `2772.969 ms`, wall
  `3285.829014 ms`; no speculative marker rows, as expected.
- Target phases are therefore prompt/prefill plus non-speculative decode;
  draft, verification, correction, and accepted-vector phases are
  `not_applicable` or `unknown`, never zero-imputed.

### Q4 n=1 no-override diagnostic (task 42)

- Fresh current-65b8 request produced assistant SHA
  `1d5020bfedee4bbc2c878d7d3805bf76ccd2e85dfc90817c4b3422af75122646`,
  64 tokens, and `length`. It is a diagnostic output record, **not** a
  target-equivalence oracle; its content differs from the target oracle.
- Client timing: prompt `633.091 ms`, predicted decode `2184.524 ms`, wall
  `2823.176715 ms`.
- Diagnostic client counters: 35 proposed, 28 accepted, acceptance fraction
  `28/35=0.8`, `cache_n=0`. This is not an exactness or general acceptance
  claim.
- The raw Q4 log has a clean task-ID boundary: warmup task `1` and diagnostic
  task `42`, each with 35 verify cycles. The current parser aggregated both;
  its log-wide counters are 70 proposed, 56 accepted, 14 rollback, and 126
  accepted-vector rows.
- For the diagnostic task alone, an offline task-ID split of the preserved log
  yields marker-derived intervals: `VERIFY_BATCH_BEGIN → VERIFY_BEGIN`
  `1745.412 ms`, `VERIFY_BEGIN → VERIFY_RESULT` `55.829 ms`, and
  `VERIFY_RESULT → MEMORY_AFTER` `0.601 ms`. The corresponding warmup values
  are `1853.610 ms`, `58.786 ms`, and `0.605 ms`. These are derived from the
  immutable raw log, not a new run.
- The Q4 `spec common_specu` timing lines report cumulative draft-generation
  durations `382.432 ms` after warmup and `761.097 ms` after diagnostic; the
  derived diagnostic increment is about `378.665 ms` across 35 draft calls.
  Treat this as a source/runtime timing clue only, not a standalone speed
  result.

## Confounds and claim boundary

The current `pq020.phase.v1` summary reports Q4 verify-batch construction
`3599.022 ms`, target verification `114.615 ms`, and rollback `1.206 ms` over
both requests. It does not encode request IDs. The task-ID split above is the
smallest read-only repair and must be represented in a follow-up parser
receipt before phase totals are used to prioritize code work. No phase is
causal merely because its interval is large; the interval between batch-begin
and verify-begin may include draft generation, graph scheduling, target work,
and transaction preparation. The Q4 output mismatch also blocks any
faster-and-correct or losslessness claim.

Do not compare these intervals to the historical `d07ed8b4...` trace. Do not
retune the low-margin policy, change cache/sampler/rollback semantics, rerun
the same pair, or infer Arm-B state from generic source. The completed result
is descriptive phase evidence only.

## Ranked next actions

### 0. Offline parser/warmup split — smallest safe action

Use only the preserved `raw/q4-server.log`, `raw/target-server.log`, client
JSON, and current parser source. Extend the parser receipt (without launching
anything) to retain the server task IDs (`task 1` warmup, `task 42` Q4
diagnostic; target's diagnostic task is `task 70`) and emit separate warmup
and diagnostic phase objects. Recompute marker counts, proposed/accepted/
rollback counters, `spec common_specu` draft duration, print-timing lines, and
per-request intervals. Preserve the existing parser/runner hashes and record
the additive offline parser hash; never overwrite the terminal receipt.

Stop the analysis if task IDs are missing, a marker is assigned to two tasks,
the 35/35 cycle split fails, timestamps are malformed, or a derived interval
would be imputed as zero. This is the only immediately admissible next action;
it is documentation/analysis-only and needs no GPU, source mutation, or CEO
execution approval.

### 1. Conditional source-backed candidate: verify-batch/transaction preparation

If the split confirms that `VERIFY_BATCH_BEGIN → VERIFY_BEGIN` remains the
largest stable subtotal after warmup normalization, perform a read-only source
map of the current `tools/server/server-context.cpp` and
`common/speculative.cpp` paths that emit the markers (source identities
`c060c9f5...` and `6a24e473...`; current marker regions include
`server-context.cpp:3841–3889` and the speculative marker sites recorded in
the preflight). This map is a local/read-only inspection of already preserved
source snapshots and receipts; it does not require a new remote session, build,
model load, or GPU. If those snapshots are not present or their hashes do not
match the pinned identities, record the missing source-only receipt and stop
instead of fetching or guessing. The hypothesis is that repeated per-cycle
batch/position/mask/transaction preparation or graph scheduling is a removable
overhead. This is not yet a patch proposal: no source receipt currently
isolates one operation, and the interval may include target/draft work.

Only after a source audit binds one causal operation and proves that a proposed
change preserves token ordering, positions, masks, KV/cache extents, rollback,
sampler state, and output serialization may a new one-variable implementation
card be drafted. It must first pass a target-only oracle and Q4 output/transaction
correctness gate, then repeated matched end-to-end timing; no speed promotion
from this diagnostic is allowed.

### 2. Conditional source-backed candidate: fixed-n draft-generation overhead

The derived `~378.665 ms / 35` draft-generation increment is a secondary
runtime clue (about 10.8 ms per draft call), not evidence to retrain or alter
proposal length. A future candidate could inspect whether fixed `n=1` graph/
allocator setup is repeated unnecessarily, but only a source-bound, logging-
free one-variable change with unchanged draft tokens, acceptance accounting,
and rollback semantics is admissible. It remains behind action 0 and the
correctness gate because the Q4 output already differs from target.

### 3. Deprioritize correction/rollback micro-cost

The diagnostic rollback interval is `0.601 ms` (14 log-wide rollback rows),
far smaller than batch-to-verify and draft-generation totals. Do not patch
rollback or memory transactions from this receipt; the unresolved exactness/
Arm-B state problem is a correctness blocker, not evidence of a cheap speed
win.

### 4. Retire blind intervention branches

No new depth, data-scale, precision, cache, low-margin threshold, selector,
split-flash, or training run is ranked from this result. Existing evidence is
negative, narrow, or contract-confounded, and the external Arm-B/rendering/
evaluator bundle remains the prerequisite for a faster-and-correct verifier
claim.

## Planner disposition

**Terminal diagnostic reconciled; next action is offline parser/warmup split.**
The phase pair is complete and clean, but it authorizes neither a rerun nor a
source patch. The only source-backed optimization candidate is conditional on
the parser split and a fresh static source map; any future intervention needs a
new planner card, critic review, literature review, exactness gate, matched
target-only baseline, repeated timing, and a separate terminal receipt.

## Rank-1 source-map audit result

The conditional local source-map audit was performed after the parser/ranking
packet. The exact source payloads are **absent** from the preserved local
workspace: `common/speculative.cpp` SHA
`6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0` and
`tools/server/server-context.cpp` SHA
`c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2` appear
only as hash references in receipts. Marker logs and parser outputs remain
available, but they cannot bind a causal source operation. The compact audit
receipt is
`receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/source-map-audit-20260822.json`.

Disposition: **NO-CANDIDATE / SOURCE GAP**. Do not draft or authorize a
verify-batch, transaction-preparation, or graph/allocator patch. The smallest
reopen is a source-only intake of both exact files (full bytes and matching
hashes), followed by the same read-only map. No SSH, download, build, model
load, GPU, rerun, or source mutation was used or authorized by this audit.
