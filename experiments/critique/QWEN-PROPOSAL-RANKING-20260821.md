---
id: QWEN-PROPOSAL-RANKING-20260821
date: 2026-08-21
status: review-complete-no-runnable-proposal
scope: adversarial ranking of existing Qwen proposals after PQ-002 implementation defer
authorization: documentation-only; no new card, run, approval, or queue mutation
---

# Qwen proposal ranking after PQ-002 defer — 2026-08-21

## Verdict

**No Qwen proposal is currently execution-ready.** PQ-002 is correctly
deferred because no preserved implementation satisfies its objective tuple.
The highest-information safe next action is a read-only closure of PLAN-001's
evaluator and Arm-B layout contract; this is a dependency repair, not an
experiment. It can resolve the central state/shape uncertainty that otherwise
confounds both training proposals and prevents a trustworthy runtime screen.

## Conditional information ranking

| Rank | Proposal | Evidence class / current blocker | Disposition |
|---:|---|---|---|
| 1 | `PLAN-20260821-001` target schedule/state localizer | Diagnostic target-only singleton versus deployment-shaped block execution. Evaluator tuple and Arm-B layout remain unresolved; historical memory-after values conflict (`[171,171]` versus `[170,170]`). | **Retain as the sole next information target, documentation-only.** Build a canonical source-backed manifest from preserved files: evaluator/source/config hashes, prompt IDs/hash, strict token predicate, block width/positions, mask, cache extents/digests, and replay IDs. Keep unknowns explicit; no comparison is authorized. |
| 2 (conditional) | `PQ-20260821-002` prefix-survival objective | Training/acceptance hypothesis with a complete mathematical policy but no admissible implementation artifact; inventory receipt is terminal negative. | **Deferred, not retired.** Resume only after an objective-only artifact, file-set hash, exact command, synthetic finite-gradient receipt, critic review, and CEO amendment. It must reuse the repaired PLAN-001 evaluator contract rather than create a second acceptance uncertainty. |
| 3 (conditional) | `PQ-20260821-004` confidence-gated proposal length | Runtime/overhead hypothesis, but no DFlash2-compatible confidence score, threshold/calibration, deterministic selector, EOS/tie/NaN policy, or scheduler-overhead instrumentation exists. | **Defer/retire the current unexecutable proposal.** Reopen only when an immutable policy artifact and hash are supplied; do not invent a selector or treat `p_min`/DSpark as equivalent. |
| 4 (conditional) | `PQ-20260821-005` paired singleton/block-17 consistency | Training plus state-interface hypothesis downstream of v31. It risks confounding feature extraction, subset/corpus size, parent continuation, and a new consistency term; it has no independent contract until PLAN-001 is resolved. | **Deep defer; retire if PLAN-001 does not establish a reproducible shape/state discrepancy.** Any revival needs one frozen feature manifest, coefficient, parent hash, and a one-variable objective-only design. |

## Highest-information safe action

Perform only a read-only PLAN-001 contract reconciliation using preserved
runtime/config/receipt files. The output should be one immutable evaluator/layout
manifest (or an explicit terminal `unknown` record) covering:

- evaluator path, dependency/runtime identity, command/configuration, and hash;
- six prompt IDs, rendered-prompt/target-only oracle hashes, and replay IDs;
- strict token-ID comparison predicate and target top-1/logit summary;
- Arm-B block width, token count, absolute positions, sequence IDs, mask schema,
  cache extents/digests, and source/config evidence tying them to the pinned
  runtime; and
- reconciliation of the historical `[171,171]` versus `[170,170]` memory-after
  discrepancy.

If any field cannot be bound immutably, preserve it as `unknown` and stop. This
read-only action does not authorize building, patching, SSH, GPU execution,
inference, or receipt population. It is higher information than starting a
new objective, scheduler, or consistency experiment because all three depend
on the same evaluator/state boundary for interpretation.

## Portfolio retirement/defer rule

The completed v27/v28/v29/v30/v31 cards remain historical parent, negative
control, or approximate evidence; they are not fresh independent Qwen
proposals. Do not open another Qwen card that reuses their exposed validation
screen while changing the same state/objective/scheduler family. A proposal
may leave the deferred set only when its immutable implementation, metric
contract, lifecycle approval, exactness boundary, and cleanup/terminal receipt
fields are all present.

