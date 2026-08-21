---
id: PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-CRITIQUE-20260821
date: 2026-08-21
status: blocked-card-creation
verdict: BLOCK
---

**2026-08-21 runtime-change blocker review — BLOCK confirmed.** The planner is
correct: no bounded DFlash2 runtime-change card can be specified without
inventing the missing policy. The pinned branch has fixed `n_max`/block
execution; `p_min` and DSpark mechanisms are different draft paths, so they
cannot be silently substituted while claiming a scheduling-only change. The
future-card invariants (fixed v30 identities, unchanged target verification,
cache/mask/positions, sampler, correction/rollback, block shape, output
accounting, and overhead measurement) are sufficient as a design shell, but
they are not an executable policy. **Smallest external deliverable:** an
immutable DFlash2-compatible policy artifact (source/config or built
implementation) with hash that defines the score/source tensor and read point,
threshold/calibration provenance, deterministic `n` mapping including EOS/tie/
NaN behavior, and scheduler-overhead instrumentation while asserting those
invariants. Until that artifact and hash are supplied, retain PQ-004 blocked;
do not create a runtime card, populate receipts, patch/build, or run.
