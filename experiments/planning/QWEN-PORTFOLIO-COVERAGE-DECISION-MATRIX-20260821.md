---
id: QWEN-PORTFOLIO-COVERAGE-DECISION-MATRIX-20260821
date: 2026-08-21
status: documentation-only
scope: existing-portfolio
---

# Portfolio coverage and decision matrix

This matrix gives the CEO a decision rule for the five existing proposals in
the planner queue. It does not create or reprioritize a proposal, change a
status, authorize a run, or promote a result. “Discriminating” means that the
specified evidence would separate the proposal’s causal question from its
named control under the frozen contract; it does not mean generalization.

## Decision matrix

| Proposal / axis | Becomes discriminating when… | Current blocker before that evidence | Stop condition | Retire condition under current evidence | Next documentation action |
|---|---|---|---|---|---|
| **PLAN-20260821-001** — target execution shape / verifier state | The target-only singleton oracle is stable, Arm-B’s exact deployment-shaped width/positions/sequence IDs/mask/cache/anchor mapping is mechanically bound, and Arm A/B plus Arm-D receipts show a reproducible first-divergence state/token difference (or no difference) under one evaluator tuple. | Evaluator/logger tuple, per-divergence IDs/decision, serialized mask/positions/cache/rollback state, exact Arm-B mapping, and `[171,171]` vs `[170,170]` evidence remain `UNKNOWN`; historical approval is suspended. | Stop before comparison on any unknown identity/tuple field, unresolved memory discrepancy, target-only mismatch, unproven Arm-B equivalence, resource/cleanup uncertainty, or held-out access. | Retire the proposed comparison as unexecutable if the cited v20–v22 evidence cannot bind the complete evaluator and Arm-B contract without inference; preserve the blocker as evidence. | One narrow source/receipt extraction and immutable contract-manifest amendment over the cited v20–v22 files/logs and LIT-001 handoff; no runtime invocation. |
| **PQ-20260821-002** — training objective / prefix survival | An approved implementation artifact passes the synthetic finite/nonzero-gradient gates, the one-objective-only source diff is proven, and the bounded fit/validation compares n=4/n=8/n=16 acceptance and prefix metrics against v27 with all controls intact. | No preserved candidate implements the complete FP32 direct cumulative-log tuple; wrapper/module path, hash, exact command/environment, and CEO amendment remain missing. | Stop before fit on missing implementation identity, source-diff violation, non-finite values, zero relevant gradients, optimizer/evaluator/held-out/cleanup failure; stop promotion if no checkpoint reaches the registered v27 n=4 baseline. | Retire the continuation as unexecutable if no separately scoped implementation artifact can be sourced and approved; if run completes with a negative result, retain it as a negative result rather than a promotion. | Complete the existing implementation card’s artifact identity fields and obtain critic review plus CEO amendment; do not search or substitute generic CE/KD/runtime helpers. |
| **PQ-20260821-003** — SmolLM intermediate depth / capacity | A frozen three-layer identity-initialized candidate and one-layer baseline pass finite/exact guards, then fixed-90 acceptance and repeated end-to-end timing show whether depth changes the acceptance/latency frontier under the same evaluator. | Existing target/data/evaluator/environment identities and explicit user approval must be confirmed; candidate parameter count and receipt contract are not yet a completed preflight. | Stop on construction, finite-gradient, exact-guard, evaluator, process, or cleanup failure; do not open sealed held-out evaluation unless the card’s exactness/throughput gate passes. | Retire the candidate if the required SmolLM manifests/evaluator cannot be recovered or if no exact guarded comparison can be formed; an acceptance gain without throughput remains a bounded negative/neutral result, not an automatic retirement. | Assemble a read-only provenance/preflight packet for the existing one-layer baseline, bridge source, target/data manifests, and fixed-90 prompt/evaluator contract; request user approval only after identities are complete. |
| **PQ-20260821-004** — Qwen adaptive proposal scheduling | A source-backed DFlash2 selector has a frozen confidence statistic, threshold/calibration, deterministic n∈{1,2,3,4} mapping, EOS/tie/n=1 rules, and overhead counters; one validation screen then compares acceptance/cycle and repeated timing to fixed n=4 under unchanged cache/correction semantics. | Inventory found no existing DFlash2 adaptive selector; `p_min`, DSpark, and adaptive-p mechanisms are not the pinned DFlash2 implementation. A separate runtime-change card is required. | Stop on missing policy/implementation identity, changed prompt ordering, cache/mask/correction violation, target-only failure, or inability to separate scheduler overhead. | Retire PQ-004 under current runtime if no source-backed selector can be supplied; do not silently convert it into a runtime patch or reuse an incompatible mechanism. | Keep PQ-004 blocked and, only if the CEO elects to pursue it, draft the separate runtime-change card with the selector tuple and invariants; otherwise record the existing blocker as terminal. |
| **PQ-20260821-005** — paired singleton/block-17 state consistency / objective-data interaction | Frozen v31 paired-state feature/state manifests, one consistency coefficient, and a source-disjoint fit show a reproducible change in state RMSE/prefix acceptance versus v27/v31 controls while exactness, evaluator, and cache contracts remain unchanged. | The v31 paired-state feature/state manifests and hashes, coefficient, and complete data/fit gate are not frozen; the proposed objective/data change risks confounding shape, data, and loss. | Stop before fit if manifests/hashes/alignment gates are unavailable; stop on non-finite loss, state-consistency failure, evaluator mismatch, or two consecutive prefix-acceptance regressions. | Retire the proposal if the v31 paired-state artifacts cannot be recovered or if one-variable isolation cannot be demonstrated; do not regenerate features to fill the gap. | Perform a read-only inventory of preserved v31 paired-state manifests, alignment receipts, and source hashes; leave each missing field `UNKNOWN` and do not draft a run command. |

## Portfolio decision order

1. **Contract validity first:** PLAN-001 is the only proposal whose next
   documentation action can validate the target/evaluator interface shared by
   the Qwen training and scheduling questions. Its gate remains closed.
2. **Objective implementation second:** PQ-002 has the most complete causal
   policy, but no implementation can be admitted without the separate card and
   CEO amendment.
3. **Runtime policy or state-consistency follow-ups:** PQ-004 and PQ-005 remain
   conditional on new, separately scoped identities; neither can inherit
   mechanisms or manifests from another axis.
4. **Capacity control:** PQ-003 is a distinct SmolLM axis and may be evaluated
   only under its own target/evaluator approval; it cannot be used as evidence
   for Qwen proposals.

These are decision dependencies, not new queue entries. Current queue statuses,
approval flags, receipt paths, negative controls, and sealed-held-out boundaries
remain unchanged.

