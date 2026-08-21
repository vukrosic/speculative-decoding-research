---
id: QWEN-V30-RERUN-POSTRUN-CRITIQUE-20260821
date: 2026-08-21
status: completed-negative
verdict: completed-negative
terminal_disposition: completed-negative
---

# Post-run evidence review — EXP-20260821-004 v30 rerun

Documentation-only reconciliation of the receipt set under
`receipts/EXP-20260821-004-v30-rerun-20260821/`. No additional execution was
performed.

## Gate review

- **Schema/provenance: PASS.** `environment.json` pins target, F16/Q4_K_M/Q8_0
  hashes, runtime commit/binary, evaluator wrappers, prompt/contract hashes,
  flags, seed, host, and GPU. SHA-256 values in `summary.json` match all four
  JSON receipts.
- **Matched baseline and metrics: PASS.** Target-only and each drafter arm
  have one warmup plus three timed repetitions, 625 completion tokens per
  repetition, accepted/proposed counts, target-content matches, timing spread,
  and peak VRAM. Means: target-only 17.3758 ± 0.0667 tok/s; F16 11.5306 ±
  0.0137; Q4_K_M 11.5745 ± 0.0104; Q8_0 11.5572 ± 0.0141. Acceptance is
  102/1,971 (F16), 103/1,967 (Q4_K_M), and 102/1,971 (Q8_0); target-content
  matches are 7/12 for every drafter arm and 12/12 for target-only.
- **Exactness boundary: PASS; result: failed diagnostic.** The receipts
  correctly keep target-content matching separate from strict token identity.
  No lossless, general exactness, quality, or speed claim is supported; all
  drafter arms are materially slower than target-only on this screen.
- **Confound/safety/cleanup: PASS.** Existing export format is the only
  changed variable; no re-quantization, held-out data, downloads, installs, or
  patches occurred. `cleanup.json`, final GPU state, final process state, and
  `terminal.json` show task-owned servers/monitors were stopped and the RTX
  3060 returned idle. The initial malformed Q8 path was corrected before any
  server/model process and did not affect result artifacts.

## Terminal disposition

**`completed-negative` for promotion.** The bounded approximate rerun completed
with valid receipts, but no drafter format improved end-to-end throughput over
the matched target-only baseline and strict exactness was not established.
Preserve the measurements as approximate, screen-scoped evidence; do not
promote Q8_0's tiny within-drafter difference to a serving improvement.

## Repair

The receipt directory `README.md` still says `pre-registered schema; no rerun
started` after completion. Update that status to `completed-negative` and link
`summary.json`/`terminal.json`; this is a documentation reconciliation only
and does not alter terminal facts.
