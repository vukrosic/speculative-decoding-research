---
id: CRITIQUE-QWEN-EXP020-CURRENT-65B8-PHASE-PAIR-POSTRUN-20260822
date: 2026-08-22
kind: post-run diagnostic critique
verdict: DESCRIPTIVE DIAGNOSTIC VALID; NO SPEED OR EXACTNESS RESULT; NO NEW SEMANTIC CANDIDATE
---

# Post-run decision

The matched target-only/Q4 n=1 run completed on the same current instrumented
runtime and is valid as a **one-prompt, descriptive phase diagnostic**. The
machine-bound receipt proves the current server `fcbf4b9d...`, common library
`65b8a862...`, implementation `fd5a9bf6...`, target `3895b6ea...`, Q4 drafter
`18a380ef...`, client `477b271d...`, prompt `374eea10...`, parser
`610f8466...`, and runner `1adb22e4...`. Both arms used cache off, greedy
temperature 0/top-k 1, seed 42, context 4096, cap 64, and no low-margin or
split-flash override. Cleanup is clean: the RTX 3060 is idle at 1 MiB/0%, no
task process remains, and the `/dev/shm` and workspace receipts are preserved.

This closes the former current-library identity blocker. It does **not** turn
the pair into a serving benchmark, exactness test, or causal verifier result.

## Observed outputs and phase evidence

- Target-only reproduced assistant hash `0f76b6ae...`, 64 completion tokens,
  and `finish_reason=length`. Its diagnostic client timing was prompt/prefill
  504.999 ms, predicted decode 2,772.969 ms, and wall 3,285.829 ms.
- Q4 n=1 produced a fresh no-override hash `1d5020bf...`, 64 tokens, and
  `finish_reason=length`; it did **not** match the target assistant hash.
  The diagnostic client reported 35 proposed and 28 accepted draft tokens,
  `cache_n=0`, wall 2,823.177 ms, and 0.8 accepted/proposed. These are
  diagnostic counters, not an acceptance-quality result.
- The Q4 log contains 70 marker cycles, 56 accepted drafts, 14 rollback rows,
  and 126 accepted-vector rows. The client diagnostic itself is 35 cycles;
  the parser/phase intervals cover warmup plus diagnostic. Accordingly, the
  marker-derived totals are log-wide: verify-batch construction 3,599.022 ms,
  target verification 114.615 ms, and correction/rollback 1.206 ms. They must
  not be divided or compared as if they were the single diagnostic request
  without a per-request split.
- Target-only has no speculative markers, so draft/verify/rollback fields are
  `not_applicable` or `unknown`, never zero. The two arms' client and marker
  clocks are separate; the receipt explicitly forbids cross-arm phase sums.
- The Q4 startup warning that draft memory could not be measured is recorded
  as the normal `ctx_other` memory-fitting warning, followed by successful
  model load and requests. It is still a startup/measurement confound, not a
  performance signal.

## What the result supports

The receipt supports only this statement: in this exact current 65b8
instrumented runtime and one public prompt, Q4 emitted the expected verifier,
draft-vector, accepted-vector, memory-after, and rollback markers, while
target-only emitted none; the logged event families and client accounting are
available for a future per-request decomposition.

The trace does not support:

- target-equivalent exactness or losslessness (the Q4 assistant hash differs);
- a speed or tok/s improvement (one warmup/one timed request, separate process
  startup, different phase coverage, and no repeated statistical estimate);
- acceptance quality or generalization (one prompt and 35 diagnostic cycles);
- verifier correctness, state localization, rollback fidelity, or a causal
  explanation of the output mismatch;
- comparison with the historical `d07ed8b4...` Q4 trace or any prior low-margin
  run.

## Adversarial measurement review

The apparent Q4 wall-time difference is not interpretable as an end-to-end
speed result: target wall time is 3,285.829 ms and Q4 wall time is 2,823.177
ms, but each arm has one warmup, different server startup/model-loading
paths, and the Q4 phase rows include both warmup and diagnostic traffic. The
Q4 hash mismatch is also a semantic/output confound. The 0.8 accepted/proposed
ratio is an observed local counter, not a target-equivalence or quality score.

The large verify-batch interval total is a useful hypothesis generator, not a
causal bottleneck finding. Its timestamp pairs are marker-derived, overlap
with other work, and are not closed against a complete target-only phase
table; unknown residuals must not be imputed as zero. A future analysis would
need request/rep boundaries and per-cycle joins before ranking phase costs.

## Source-backed next action

No new semantic Qwen intervention is justified by this receipt. The current
`common/speculative.cpp` (`6a24e473...`) and `server-context.cpp`
(`c060c9f5...`) changes are trace instrumentation only; they do not provide a
source-backed verifier, mask, rollback, or selector repair. Do not patch the
apparent verify-batch cost or rerun a speed sweep from this one trace.

The smallest safe follow-up is documentation/CPU-only reconciliation: retain
the raw logs, add a parser/report that separates warmup from diagnostic
requests and emits per-request/per-cycle marker joins, and label all unknown
phases explicitly. The current parser's marker allowlist also omits the
available `PQ020_VERIFY_BATCH_ROW` and `PQ020_VERIFY_ROW` lines. The repair
should preserve those rows and bind `task_id`, slot, warmup/diagnostic label,
marker timestamp, prompt/position fields, batch global/local index, token and
sequence fields, acceptance/rollback fields, memory extents, source-log hash,
parser/schema hash, clock/unit, and explicit unknown/residual values. In this
run the request boundaries are mechanically visible as q4 task IDs 1 and 42
and target task IDs 1 and 70, but the parser must derive them from the
`new prompt`/`stop processing`/`print_timing` records rather than assume those
numeric IDs.

If a true speculative intervention is later pursued, the
next source-backed candidate remains the external PLAN-001/PQ008
deployment-shaped verifier/state contract and correction boundary—not a
guessed scalar runtime knob. That lane stays blocked until the authoritative
source/build/state/evaluator/replay bundle arrives.

## Terminal disposition

**PASS for descriptive phase evidence; TERMINAL for improvement promotion.**
Preserve the pair as a knowledge update and negative exactness result. No
follow-up GPU run, timing claim, acceptance claim, or source patch is approved
from this post-run receipt.

Sources: `receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/summary.json`,
`terminal.md`, `cleanup.json`, `raw/target-diagnostic.json`,
`raw/q4-diagnostic.json`, `raw/target-phase.json`, `raw/q4-phase.json`,
`pq020_phase_parser.py`, and `pq020_run_current_65b8_phase_pair.sh`.
