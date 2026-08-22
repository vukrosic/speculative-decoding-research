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

- Status: `hypothesis`
- Claim: the remaining deterministic output difference arises at a rejected
  speculative boundary because block-shaped target verification is numerically
  different from singleton target decoding.
- Supporting evidence: only `code_python_debug` differs across target and Q4;
  the difference repeats across all three runs while 5/6 prompts agree.
- Limitation: no first-divergence token/state trace yet.
- Falsifier: unchanged-runtime trace plus singleton correction replay.

