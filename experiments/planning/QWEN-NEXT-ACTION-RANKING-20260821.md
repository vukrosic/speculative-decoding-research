---
id: QWEN-NEXT-ACTION-RANKING-20260821
date: 2026-08-21
status: documentation-only
scope: existing-proposals-only
---

# Qwen next-action ranking

This is a documentation-only portfolio ranking of the four existing Qwen
proposals. It does not create a card, change a status, authorize a run, or
promote any proposal. Ranking combines expected information gain with the
amount of preserved evidence that can close the next gate without execution.

## Ranking

| Rank | Proposal | Why this is the next useful lane | Current dependency / boundary |
|---:|---|---|---|
| 1 | PLAN-20260821-001 verifier/shape localizer | Highest information gain per documentation action: it can localize the strict mismatch and protect all later training decisions from an invalid evaluator contract. The remaining work is a finite contract/receipt mapping, not a new causal hypothesis. | Preserve LIT-20260821-001 and v20–v22 source/receipt evidence; evaluator tuple, Arm-B shape/mask/cache fields, tokenizer/runtime identities, and drafter identity remain required. Current status stays BLOCKED; no comparison is authorized. |
| 2 | PQ-20260821-002 prefix objective | The objective math, lineage, controls, and receipts are already specified, so it is the most mature training follow-up once an implementation exists. The inventory found no admissible candidate, making the next step governance/identity work rather than fitting. | Existing additive implementation card, critic review, and CEO amendment. Current status stays deferred/blocked before fit; no ephemeral wrapper or substitute candidate. |
| 3 | PQ-20260821-004 confidence-gated length | Runtime-only scheduling could answer a useful overhead question, but the pinned DFlash2 runtime has no confidence score, threshold, or selector. Pursuing it requires a separate runtime-change proposal, not a repair hidden inside PQ-004. | Source-backed DFlash2 policy/implementation, deterministic n-selection and overhead contract, separate critic/CEO decision. Current status stays BLOCKED; no runtime patch or screen. |
| 4 | PQ-20260821-005 paired state consistency | It addresses a plausible mechanism, but it is the least ready: paired v31 manifests/state contract and coefficient are not frozen, and the proposed objective/data change risks confounding. It should follow contract and implementation closure rather than precede them. | Preserved v31 paired-state feature/state manifests, one frozen coefficient, data/fit gate, and explicit user approval. Current status stays deferred queue-only; no feature regeneration or training. |

## One designated next action: PLAN-001 contract closure

**Action.** Perform one read-only reconciliation of preserved v20–v22 source and
receipts into an immutable PLAN-001 evaluator/Arm-B contract manifest. The
manifest must bind one evaluator/logger/finalizer tuple and explicitly record
or mark `UNKNOWN`: runtime/build/tokenizer/target/drafter hashes, prompt and
contract hashes, committed prefix and proposed/target IDs, correction and
accept/commit decision, block width/positions/sequence IDs, mask tensor/schema,
cache before/after schema and state hashes, anchor/`n_extract` transition,
deterministic replay ID, and the historical singleton memory-after discrepancy.
This is a documentation/read-only action only; it must not invoke the runtime.

**Dependency.** The canonical `LIT-20260821-001` handoff and the preserved
v20–v22 source/receipt set must be available for inspection. The mapping may
reuse only source-backed identities and receipts; it may not infer Arm-B
equivalence from generic source descriptions or historical block fixtures.

**Stop condition.** Stop and retain `PLAN-001` as BLOCKED if any required
identity or tuple field remains unknown, if the singleton memory-after conflict
cannot be resolved from preserved evidence, or if the manifest cannot prove
that Arm-B is the deployment-shaped schedule. Do not launch Arm A/B/D, open
held-out data, or broaden the scope to a runtime patch.

## Why not the others first?

- PQ-002 has no implementation artifact; another search has already established
  that preserved CE/KD/perplexity/sampler candidates are not substitutes.
- PQ-004 has no existing DFlash2 adaptive selector; `p_min`, DSpark, and
  adaptive-p mechanisms are not admissible substitutions.
- PQ-005 depends on unresolved paired-state manifests and introduces a more
  confounded, higher-cost objective/data change.

The ranking leaves all four proposals’ existing approval flags, receipt paths,
sealed-heldout boundaries, and negative-result controls unchanged.

