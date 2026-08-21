# CEO decision — PQ-20260821-004 confidence-gated proposal length

Date: 2026-08-21  
Queue proposal: [`PQ-20260821-004`](../experiments/planning/EXPERIMENT-QUEUE.md)  
Readiness packet: [`PQ-20260821-004-READINESS-20260821.md`](../experiments/planning/PQ-20260821-004-READINESS-20260821.md)  
Decision: **BLOCKED — no execution approval**

## Lane inputs reconciled

| Lane | Record | Finding |
|---|---|---|
| Planner | readiness packet | **BLOCKED**: scope and v30 provenance are pinned, but policy/threshold/implementation identities are absent. |
| Critic | [`PQ-20260821-004-CONFIDENCE-GATE-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-004-CONFIDENCE-GATE-CRITIQUE-20260821.md) | **BLOCK**: no deterministic score, threshold, n-selection, overhead receipt, or current baseline linkage. |
| Literature | [`HANDOFF-20260821-PQ004.md`](../literature/HANDOFF-20260821-PQ004.md) | **Conditionally high-information**, but only with a frozen policy and explicit approximate-only boundaries. |

## CEO finding

The existing v30 run provides a valid current baseline: Q8_0 mean 11.557184
tok/s, 102/1971 accepted/proposed, 7/12 target-content matches, versus
target-only 17.375777 tok/s and 12/12 content. An adaptive proposal-length
screen could test verifier/overhead trade-offs without training or changing
export format, but the proposal is not executable as written. The exact
blocker is one missing immutable policy/implementation manifest containing:

1. confidence score definition, source tensor/logit, read position/cycle, and
   deterministic tie/EOS behavior;
2. one literal or train-calibrated threshold and deterministic mapping to
   `n∈{1,2,3,4}`, with calibration provenance if applicable; and
3. implementation path, commit, and hash proving that only scheduling changes
   while target verification, cache/mask/positions, sampler, and correction
   semantics remain fixed.

No threshold may be selected from the 12-prompt validation screen. If the
policy requires a runtime change, it needs a separate card and a new CEO
decision; it is not silently included here.

## Smallest recovery action

Planner owns the policy manifest; literature and critic must re-review it.
Until all three lanes return written PASS/conditional-pass and the CEO records
a new approval, no adaptive run, GPU command, runtime patch, download,
installation, training, held-out access, or scope expansion is authorized.
The reserved receipt path is
`receipts/PQ-20260821-004-confidence-gated-20260821/`; it must not be populated
by an unapproved run. A later read-only source inventory may live there as an
evidence receipt, but no policy, arm, summary, cleanup, or terminal execution
receipt may be written before approval.

The v30 completed-negative result remains preserved and should not be repeated
as a substitute for this missing policy gate. Actions outside the delegated
CEO boundary remain `SEPARATE USER APPROVAL REQUIRED`.

## Final policy-inventory review — 2026-08-21

Planner's [`PQ-20260821-004-POLICY-INVENTORY-20260821.md`](../experiments/planning/PQ-20260821-004-POLICY-INVENTORY-20260821.md)
found only fixed `n=4` runtime behavior (`n_max=4`, `n_min=0`, `p_min=0`,
block size 17, `n_extract=1`, `sample_from_anchor=false`). It found no
confidence score/source, threshold or calibration, adaptive `n` selector,
EOS/tie/n=1 policy, implementation path/hash, or scheduler-overhead counters.
Critic's [`PQ-20260821-004-FINAL-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-004-FINAL-CRITIQUE-20260821.md)
and literature's [`VERDICT-20260821-PQ004-POLICY.md`](../literature/VERDICT-20260821-PQ004-POLICY.md)
both return **BLOCK**. The fixed v30 baseline remains valid approximate
evidence; it cannot be promoted into adaptive evidence.

CEO reaffirms **BLOCKED**. The single missing deliverable is an immutable
source-backed policy artifact (or a new runtime-change card if implementation
does not already exist) that pins the score, threshold/calibration,
deterministic selector behavior, implementation hash, overhead counters, and
unchanged cache/mask/position/sampler/correction semantics. No adaptive GPU
run is approved, and the reserved execution artifacts remain untouched (aside
from the separately labeled read-only source inventory). After that artifact
exists, planner, critic, and literature must re-review before a new CEO
decision.

## Runtime-change card audit — 2026-08-21

Planner's [`PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821.md`](../experiments/planning/PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821.md)
records that even a separate adaptive-scheduler card cannot yet be specified
without inventing unsupported score, threshold, selector, implementation, and
overhead semantics. The minimum future-card contract is preserved there, but
no card, patch, implementation, or execution is authorized. Critic and
literature review this blocker before any future policy proposal.

## Runtime-source inventory amendment — 2026-08-21

The executor's pinned-source inventory
[`runtime-confidence-adaptive-length-inventory-20260821.json`](../receipts/PQ-20260821-004-confidence-gated-20260821/runtime-confidence-adaptive-length-inventory-20260821.json)
(SHA-256 `6ae1c6f74d0bc270f4f741dabea7c6adb8baad208fa0a9f31f9a19d5a1655726`)
and the follow-up planner, critic, and literature verdicts are reconciled.
The DFlash2 branch uses a fixed configured `n_max`/block loop. `p_min` is for
other standard/Eagle/non-DSpark paths; DSpark's confidence head is a separate
draft method; ngram/adaptive-p statistics do not alter DFlash2 `n_max`.

CEO therefore keeps PQ-004 **BLOCKED**. The exact external blocker is that no
immutable DFlash2-compatible confidence score, threshold, deterministic
selector, implementation hash, or scheduler-overhead contract exists in the
pinned source/artifacts. Adopting DSpark or adding DFlash2 scheduling would be
a new runtime-change proposal, not a silent repair. The smallest next planning
action is a separate runtime-change card with one causal change and fresh
critic/literature/CEO review; no adaptive GPU run or reserved receipt is
authorized by this decision.

Fresh blocker review is complete: critic's
[`PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-CRITIQUE-20260821.md)
returns **BLOCK**, and literature's
[`VERDICT-20260821-PQ004-RUNTIME-BLOCKER.md`](../literature/VERDICT-20260821-PQ004-RUNTIME-BLOCKER.md)
confirms that fixed `n_max`, non-DFlash2 `p_min`, DSpark confidence, n-gram
stats, and adaptive-p cannot be promoted into a DFlash2 selector. The exact
external deliverable remains a source-backed policy-spec manifest or built
implementation hash; until supplied, PQ-004 stays blocked and no runtime
change or GPU execution is authorized.
