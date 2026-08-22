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
- Follow-up: a blanket `<0.1` raw-margin runner-up rule was rejected because
  correct `logic_schedule` has margin `0.0897636414`; a predeclared `0.08`
  candidate passed the six-prompt smoke and matched speed gate. Corrected Q4
  averaged `18.5307384154` vs target `16.4723525853` tok/s (`+12.4960039522%`)
  with all six hashes matching, 227 tokens/run, `103/118` acceptance, and one
  override/run. This remains a local same-six-prompt calibration result.
- Evidence:
  - `experiments/cards/EXP-20260822-020-qwen-singleton-correction.md`
  - `receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json`
  - `receipts/PQ-20260821-019-cache-on-n1-20260822/raw-remote`
