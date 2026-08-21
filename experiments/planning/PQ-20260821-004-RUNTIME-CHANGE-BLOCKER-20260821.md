---
id: PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821
date: 2026-08-21
status: blocked-card-creation
verdict: BLOCK
related: PQ-20260821-004-ADAPTIVE-INVENTORY-VERDICT-20260821.md
---

# Why a DFlash2 adaptive-scheduler card cannot yet be created

This is a documentation-only planner record. No runtime implementation,
source patch, build, model load, inference, evaluation, GPU action, download,
install, or held-out access occurred.

## Decision

**BLOCK card creation.** The requested one-variable runtime change—confidence-
gated draft length—cannot be precisely specified from the current scope without
inventing a confidence statistic, threshold, selector implementation, or
runtime semantics. The pinned DFlash2 source has fixed `n_max`/block execution;
its `p_min` and DSpark confidence mechanisms are different draft paths.

## Missing fields that prevent a valid card

- Score definition and source (which tensor/logit, position/cycle, prefix,
  calibration domain, numeric precision).
- Literal threshold or train-calibration procedure and immutable calibration
  artifact; no validation-derived tuning.
- Deterministic mapping from score to `n∈{1,2,3,4}`, including ties, EOS,
  empty/`n=1` behavior, and malformed/NaN handling.
- Implementation boundary and source/config/artifact hash proving that only
  scheduling changes; current pinned DFlash2 has no such selector.
- Explicit accounting for confidence computation and scheduler overhead.

## Minimum future-card contract (not an approval)

If a policy implementation is later supplied, a new runtime-change card must
freeze the existing v30 target/drafter/runtime/evaluator/prompt identities,
change only the selector, and assert these invariants: target verification,
cache/mask/positions, sampler, correction/rollback, block shape, and output
token accounting remain unchanged. Controls must include fixed Q8_0 `n=4`,
target-only, deterministic replay, per-prefix chosen-`n` logging, and a
policy-overhead measurement.

The card must reserve compact receipts under
`receipts/PQ-20260821-004-confidence-gated-20260821/` for environment/policy
manifest, target-only, fixed-`n=4`, adaptive per-prompt runs, summary, cleanup,
and terminal state. A bounded resource envelope would be one RTX 3060 slot,
one process, and 30–60 minutes, with hard stops on any identity/policy
ambiguity, baseline mismatch, invariant violation, output-accounting failure,
resource contention, held-out access, scope expansion, or cleanup failure.

This contract describes what a future card must contain; it does not authorize
runtime edits or a run. Until the score, threshold, selector implementation,
and hashes exist, PQ-004 remains blocked and no receipt path may be populated.
