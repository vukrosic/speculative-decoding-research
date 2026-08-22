# Experiment: 2026-08-22-qwen-singleton-correction

## 2026-08-22T05:19:06+00:00 — stage_started

- Status: `observed`
- Summary: Activated a new current-runtime verifier trace after finding a narrow +12.892486% Q4 n=1 cache-off lead with one deterministic output mismatch among six prompts.
- Milestone: the trace shares an exact 42-token prefix, then diverges at
  output token 43 (`90563` target vs accepted Q4 draft `471` in cycle 25) after
  seven one-token rejection/rollback cycles. A bounded `n_rs` run retained the
  target hash for forced target-only `n_rs_seq=1` but retained the divergent Q4
  hash for forced Q4 `n_rs_seq=0`; snapshot count/layout is falsified as the
  sole cause. Both timings are diagnostic only.
- Evidence:
  - `experiments/cards/EXP-20260822-020-qwen-singleton-correction.md`
  - `receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json`
  - `receipts/PQ-20260821-019-cache-on-n1-20260822/raw-remote`
