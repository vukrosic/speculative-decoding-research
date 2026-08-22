# Claim ledger

## C001 — narrow Q4 speculative throughput lead

- Status: `observed-limited`
- Claim: on the exact PQ-019 six-prompt duplicated cache-off workload, Q4
  DFlash n=1 measured `18.1638816661` output tok/s versus target-only
  `16.0895399687`, a `12.892486%` increase.
- Supporting evidence:
  `receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json` and raw
  target/Q4 cache-off repetitions.
- Contradicting/limiting evidence: one of six unique prompts has a deterministic
  target/Q4 output-hash mismatch; strict token IDs were not recorded.
- Falsifier: matched rerun with token-ID oracle, same artifacts/runtime/workload,
  and balanced repeated timing.

## C002 — verifier/state fidelity is the current correctness bottleneck

- Status: `localized-hypothesis`
- Claim: the remaining deterministic output difference is caused by an
  accepted-draft decision after prior rollback activity, with block-shaped
  target verification not behaviorally matching clean singleton decoding.
- Supporting evidence: exact 42-token prefix; first divergence at output token
  43 (`90563` target vs accepted Q4 draft `471` in cycle 25); seven prior
  rejection/rollback cycles; the target token is not the correction token.
- Limitation: this localizes the decision but does not identify the precise
  state transition or prove block-shape numerics are the sole cause.
- Falsifier: a state/checkpoint intervention that restores the target token
  without changing other runtime behavior.

## C003 — recurrent snapshot count/layout is not the sole cause

- Status: `falsified-as-sole-cause`
- Claim: forcing target-only `n_rs_seq=1` and Q4 `n_rs_seq=0` should restore
  the target output if recurrent snapshot count/layout alone causes the drift.
- Evidence: target-only retained hash `0f76b6ae…` at `18.7416124147`
  diagnostic tok/s; Q4 retained divergent hash `1d5020bf…` at
  `16.3178374758`; both emitted 64 tokens.
- Limitation: one prompt and one repetition; timings are diagnostic only.

## C004 — margin-gated correction recovers the frozen six-prompt hashes

- Status: `observed-local-promising`
- Claim: a default-off `0.08` raw top-two margin override recovered all six
  target output hashes and retained a local throughput lead on the frozen
  public tuple.
- Evidence: one-shot smoke matched all six hashes with exactly one override;
  matched speed gate mean was `18.5307384154` tok/s corrected Q4 versus
  `16.4723525853` target-only (`+12.4960039522%`), 227 tokens/run, `103/118`
  acceptance and one override/run.
- Limitation: threshold was calibrated and evaluated on the same six public
  prompts; token IDs and independent held-out exactness are not established.

## C005 — blanket `<0.1` margin rule is unsafe

- Status: `falsified`
- Claim: override every accepted draft with raw margin below `0.1`.
- Evidence: already-correct `logic_schedule` has margin `0.0897636414`, while
  divergent `code_python_debug` has `0.0684490204`.
- Disposition: use no broad threshold rule; preserve the negative and require
  independent calibration before any generalization.

## C006 — independent v23 screen falsifies generalization

- Status: `falsified-generalization`
- Claim: the six-prompt calibrated `0.08` correction generalizes to separate
  public v23 validation prompts without retuning or exceptions.
- Evidence: target-only matched 12/12 hashes and 625 tokens; corrected Q4
  matched 6/12, with no override events. Diagnostic timing was `19.954249`
  versus `17.659459` tok/s (`+12.994677%`).
- Disposition: do not promote or retune; preserve the six-prompt result as a
  local calibrated observation only.
