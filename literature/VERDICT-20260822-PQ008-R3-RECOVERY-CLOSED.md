# Literature/evidence disposition — PQ-008 r3 recovery

**Date:** 2026-08-22  
**Evidence:** `receipts/PQ-20260821-019-cache-on-n1-20260822/remote-content-probe-r3-20260822.{md,json}`

## Verdict

The scoped artifact-recovery lane is **closed/terminal for the current
checkout**. A bounded broad scan (21,493 small text files) and a refined
source/config/planning scan found no new deployment candidate and zero matches
for the missing PLAN-001/Arm-B verifier, replay, mask, evaluator, cache-state,
rollback, or memory-conflict fields. This is a provenance/evidence result,
not a falsification of verifier-state hypotheses. Historical logs and runtime
files remain preserved but do not bind the missing contract.

The receipt also closes the possibility that an unnoticed remote job is the
cause of the gap: the RTX 3060 was idle (1 MiB, 0%, 56 C), with no task
processes and no model load, inference, training, holdout access, or mutation.

## Exact reopening input

Qwen GPU work can reopen only when one of these is recorded:

1. **An authoritative, hash-pinned deployment bundle** supplied externally,
   containing the source/config tie and exact Arm-B verifier/state contract:
   schedule and positions, sequence IDs and serialized-mask schema, tentative
   versus committed KV/cache before/after/rollback semantics, anchor/state
   fields, replay IDs, evaluator/logger/finalizer paths and dependency tuple,
   target/drafter/runtime/build/device identities, all rendered prompt/prefix
   hashes, and a resolution of the `[171,171]` versus `[170,170]` memory
   accounting conflict; or
2. **A separately authorized source-backed regeneration task** that produces
   that same complete bundle with reproducible hashes and receipts.

“More logs,” a guessed Arm-B mapping, or the completed PQ-019 cache-only
receipt is not sufficient. PQ-019 establishes only a local repeated-prefix
serving effect; it does not repair verifier provenance or establish general
speculative acceptance, exactness, or speed.

Until the bundle is present and the planner/critic records are updated, no
Arm-A/B/D runtime diagnostic or Qwen GPU acceptance/speed claim is admissible.

**Source-to-test boundary:** speculative-decoding literature motivates
verifier-state fidelity and cache accounting as causal observables, but cannot
substitute for the absent implementation-specific contract. Preserve this
negative recovery result and reopen only on the exact external input above.
