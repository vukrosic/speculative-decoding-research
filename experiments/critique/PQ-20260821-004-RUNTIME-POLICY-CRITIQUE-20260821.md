---
id: PQ-20260821-004-RUNTIME-POLICY-CRITIQUE-20260821
date: 2026-08-21
status: blocked
verdict: BLOCK
approval: NEEDS CEO APPROVAL
---

**2026-08-21 runtime-policy inventory verdict — BLOCK.** The source inventory
confirms that pinned DFlash2 uses configured fixed `n_max`/block size and does
not read `p_min` or any confidence statistic. The `p_min` early-stop branches
belong to standard/EAGLE/non-DFlash2 paths, while DSpark's sigmoid confidence
head is explicitly a `draft-dspark` mechanism; using either would change the
runtime/drafter method and violate PQ-004's single scheduling-policy variable,
not repair it. Model/runtime/evaluator/prompt provenance, fixed-v30 and
target-only approximate baselines, exactness boundary, no-heldout scope, and
resource/safety controls remain valid. **Exact blocker:** no immutable
DFlash2-compatible confidence score, threshold/calibration, `n` selector, or
implementation artifact exists; p_min/DSpark cannot be substituted without a
new runtime-change card and approval. The smallest safe action is to keep
PQ-004 blocked and record this incompatibility; any DFlash2 adaptive policy
must be proposed as a new card with its own source/config hash, unchanged
cache/mask/correction contract, overhead receipt, and fresh CEO decision.
