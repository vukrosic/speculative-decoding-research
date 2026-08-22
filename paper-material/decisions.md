# Methodological decisions

## D001 — regenerate current state contract, do not impersonate PLAN-001

- Status: `active`
- Decision: treat the lost historical PLAN-001 deployment bundle as terminally
  missing. Create a new current-runtime trace contract with fresh source,
  command, state, evaluator, and output identities.
- Reason: inferred historical fields would make the result uninterpretable.

## D002 — target the single deterministic divergence

- Status: `active`
- Decision: use `code_python_debug` as the cheap exactness rejection gate, then
  confirm on all six public validation prompts before any throughput claim.
- Reason: it is the only target/Q4 output mismatch in the PQ-019 workload and
  reproduces across all three timed repetitions.

## D003 — reject `n_rs` snapshot count/layout as sole fix

- Status: `falsified`
- Decision: do not promote a correction that changes only recurrent snapshot
  count/layout. The forced target-only `n_rs_seq=1` and Q4 `n_rs_seq=0` arms
  retained the target hash and divergent Q4 hash respectively.
- Reason: the bounded causal result rules out this single-variable explanation;
  investigate checkpoint contents, block-vs-singleton numerical state, or
  another verifier transition next.
