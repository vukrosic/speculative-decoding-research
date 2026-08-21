# Program-level critique index

Updated: 2026-08-21  
Purpose: one cross-experiment view of recurring validity risks and the required
per-experiment critique lifecycle

This is the program-level index. It summarizes recurring issues; it does not
replace a per-experiment critique record. The existing evidence review is
[`experiments/critique/CRITIQUE-20260821.md`](../experiments/critique/CRITIQUE-20260821.md).
No experiment was run or approved while creating this index.

## Recurring issues

| Label | Recurring issue | Current consequence | Process response |
|---|---|---|---|
| `PROV` | Missing compact hashes, commands, runtime versions, or receipts | Cross-card comparisons remain partly `unknown` | Pre-run provenance checklist; post-run receipt reconciliation |
| `SEAL` | Exposed SmolLM test material and repeatedly reused Qwen screens | No broad or final held-out claim | Declare development screens; seal a fresh split before promotion |
| `CONF` | Capacity, initialization, corpus shape, or objective changes bundled | Causal interpretation is limited | One intended change; critic must return bundled cards |
| `METRIC` | Fit, acceptance, quality, exactness, and speed conflated | Acceptance cannot support a speed or exactness claim | Separate evidence rows and promotion metric |
| `RUNTIME` | Shape-dependent target states, masks, cache, rollback, quantization, scheduling | Qwen strict identity remains unresolved | Localize first divergence before more training |
| `BASELINE` | Incomplete target-only baselines and non-comparable denominators | Speed/acceptance rankings may be optimistic | Matched target-only run, fixed cycle accounting, repeated timing |
| `CAPACITY` | More layers improve acceptance but cost throughput; initialization confounds depth | Blind depth sweep is low information | Stop branch unless a new runtime/objective hypothesis makes it discriminating |
| `LITERATURE` | Author claims or compatibility bridges mistaken for local reproduction | “Lossless” and multiplier claims are not portable | Pin paper/code/version and map claim to a local test |
| `DIVERSITY` | Repeated or bundled experiments explore the same mechanism under different labels | Portfolio can consume GPU without reducing a distinct uncertainty | Tag every proposal by causal axis, falsifier, metric class, dependency, and expected information gain; critic must reject duplicate/confounded rungs |

## Per-experiment records

Every row points to its own additive critique record. `historical-backfill-required`
means the result is preserved but the original pre-run critique was not
reconstructed; it is not a deletion, invalidation, or authorization.

| Experiment | Card | Per-experiment critique | Queue / proposal | Status | Recurring labels |
|---|---|---|---|---|---|
| EXP-20260819-001 | [card](../experiments/cards/EXP-20260819-001-smollm-onpolicy20k.md) | [record](critique/EXP-20260819-001-CRITIQUE.md) | none | historical-backfill-required | PROV, SEAL, METRIC |
| EXP-20260819-002 | [card](../experiments/cards/EXP-20260819-002-smollm-capacity35m.md) | [record](critique/EXP-20260819-002-CRITIQUE.md) | none | historical-backfill-required | SEAL, CONF, CAPACITY |
| EXP-20260820-001 | [card](../experiments/cards/EXP-20260820-001-qwen-published-dflash-runtime.md) | [record](critique/EXP-20260820-001-CRITIQUE.md) | [queue](../queue/INDEX.md) | historical-backfill-required | RUNTIME, METRIC, BASELINE, PROV |
| EXP-20260821-001 | [card](../experiments/cards/EXP-20260821-001-qwen-v27-curve.md) | [record](critique/EXP-20260821-001-CRITIQUE.md) | [planner](../experiments/planning/EXPERIMENT-QUEUE.md) | historical-backfill-required | SEAL, METRIC, BASELINE |
| EXP-20260821-002 | [card](../experiments/cards/EXP-20260821-002-qwen-v28-small-drafter.md) | [record](critique/EXP-20260821-002-CRITIQUE.md) | [planner](../experiments/planning/EXPERIMENT-QUEUE.md) | historical-backfill-required | CONF, METRIC, BASELINE |
| EXP-20260821-003 | [card](../experiments/cards/EXP-20260821-003-qwen-v29-early4.md) | [record](critique/EXP-20260821-003-CRITIQUE.md) | [planner](../experiments/planning/EXPERIMENT-QUEUE.md) | historical-backfill-required | CONF, METRIC, SEAL |
| EXP-20260821-004 | [card](../experiments/cards/EXP-20260821-004-qwen-v30-quantization.md) | [pre-run record](../experiments/critique/QWEN-V30-RERUN-CRITIQUE-20260821.md); [rerun pre-run](../experiments/critique/QWEN-V30-RERUN-VERDICT-20260821.md); [rerun post-run](../experiments/critique/QWEN-V30-RERUN-POSTRUN-CRITIQUE-20260821.md) | [queue](../queue/2026-08-21-EXP-004-v30-rerun.md) | completed-negative | RUNTIME, METRIC, BASELINE |
| EXP-20260821-005 | [card](../experiments/cards/EXP-20260821-005-qwen-v31-block17-alignment.md) | [record](critique/EXP-20260821-005-CRITIQUE.md) | [planner](../experiments/planning/EXPERIMENT-QUEUE.md) | historical-backfill-required | CONF, RUNTIME, SEAL |
| EXP-20260821-006 | [card](../experiments/cards/EXP-20260821-006-smollm-1layer-vs-5layer.md) | [record](critique/EXP-20260821-006-CRITIQUE.md) | [queue](../queue/INDEX.md) | historical-backfill-required | CAPACITY, CONF, METRIC |
| EXP-20260821-007 | [card](../experiments/cards/EXP-20260821-007-smollm-3layer-vs-1layer.md) | [record](critique/EXP-20260821-007-CRITIQUE.md) | [queue](../queue/INDEX.md) | pre-run-required | CAPACITY, BASELINE, SEAL |
| EXP-20260821-008 | [card](../experiments/cards/EXP-20260821-008-smollm-2layer-vs-1layer-timing.md) | [record](critique/EXP-20260821-008-CRITIQUE.md) | none | historical-backfill-required | CAPACITY, BASELINE, PROV |

| PLAN-20260821-001 | [card](../experiments/cards/PLAN-20260821-001-qwen-target-schedule-localizer.md) | [pre-run critique](../experiments/critique/PLAN-20260821-001-PRE-RUN.md); [recheck](../experiments/critique/PLAN-20260821-001-VERDICT-20260821-RECHECK.md); [post-block](../experiments/critique/PLAN-20260821-001-POST-BLOCK-20260821.md); [re-entry](../experiments/critique/PLAN-20260821-001-REENTRY-CRITIQUE-20260821.md); [remote preflight](../experiments/critique/PLAN-20260821-001-REMOTE-PREFLIGHT-CRITIQUE-20260821.md); [supplement](../experiments/critique/PLAN-20260821-001-SUPPLEMENT-CRITIQUE-20260821.md); [manifest critique](../experiments/critique/PLAN-20260821-001-CONTRACT-MANIFEST-CRITIQUE-20260821.md); [inventory critique](../experiments/critique/PLAN-20260821-001-EVALUATOR-ARMB-INVENTORY-CRITIQUE-20260821.md); [contract reconciliation](../experiments/critique/PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md); [terminal receipt](../receipts/PLAN-20260821-001/terminal.json); [final disposition](../receipts/PLAN-20260821-001/final-bounded-disposition-20260821.json) | [queue](../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md) | CEO blocked: evaluator/layout contract not pinned; final disposition adds no evidence | PROV, BASELINE, RUNTIME, LIFECYCLE, METRIC |

Control-plane supersession note: the linked `VERDICT-20260821-RECHECK.md`
remains preserved historical evidence with `ready-needs-approval` frontmatter;
the later reconciliation, remote preflight, planner/critic/literature verdicts,
and `provenance-link-audit-20260821.json` supersede it for the current gate.
The current status is `BLOCKED-PREFLIGHT`; the historical recheck does not
authorize execution.

## Required linkage rule

Before a future experiment can become `ready-needs-approval`, its card and
queue entry must link the corresponding record above (or a newly amended
record), and the record must contain the pre-run verdict. After execution, the
same links must point to the post-run review and terminal disposition. A
program-level summary cannot waive a missing per-experiment record.

## Pending proposal gates

These are not executed experiments, but their readiness critiques remain
indexed so a future card cannot bypass the same program-level issues:

Portfolio-level diversity audit: [`PORTFOLIO-DIVERSITY-GATES-20260821.md`](../experiments/critique/PORTFOLIO-DIVERSITY-GATES-20260821.md).
Verdict: **BLOCKED for independent-portfolio claims** until each proposed
experiment passes its six gates (one causal axis, distinct mechanism and
falsifier, metric contract, evidence-class separation, selection/multiplicity,
and lifecycle/provenance/safety). This audit does not create, approve, or
reprioritize a run.

The follow-on cross-axis planning matrix is
[`QWEN-PORTFOLIO-COVERAGE-DECISION-MATRIX-20260821.md`](../experiments/planning/QWEN-PORTFOLIO-COVERAGE-DECISION-MATRIX-20260821.md).
It records when each existing proposal becomes discriminating, its stop and
retirement conditions, and one documentation action without changing queue
status or authorization. The adversarial confound/evidence-leakage audit is
[`PORTFOLIO-CONFOUND-EVIDENCE-LEAKAGE-20260821.md`](../experiments/critique/PORTFOLIO-CONFOUND-EVIDENCE-LEAKAGE-20260821.md);
its verdict is **BLOCKED for cross-proposal inference** and it keeps
PLAN-001's read-only contract manifest as the shared dependency. The
source-backed alternative-hypothesis note is
[`KNOWLEDGE-EXPLORATION-20260821-ALTERNATIVES.md`](../literature/KNOWLEDGE-EXPLORATION-20260821-ALTERNATIVES.md);
it is literature evidence only and authorizes no runtime, training, or serving
action.

Next-action ranking records: [planner](../experiments/planning/QWEN-NEXT-ACTION-RANKING-20260821.md),
[critic](../experiments/critique/QWEN-PROPOSAL-RANKING-20260821.md), and
[literature](../literature/RANK-20260821-QWEN-PROPOSALS.md). All three rank
PLAN-001 read-only evaluator/Arm-B contract reconciliation first; PQ-002 is
deferred for missing implementation, PQ-004 is deferred for missing DFlash2
selector policy, and PQ-005 remains downstream of reproducible state evidence.

| Proposal | Readiness / planner record | Critic record | Literature record | Current gate |
|---|---|---|---|---|
| PQ-20260821-004 confidence-gated proposal length | [readiness](../experiments/planning/PQ-20260821-004-READINESS-20260821.md); [policy inventory](../experiments/planning/PQ-20260821-004-POLICY-INVENTORY-20260821.md); [runtime blocker](../experiments/planning/PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821.md) | [final critique](../experiments/critique/PQ-20260821-004-FINAL-CRITIQUE-20260821.md); [runtime critique](../experiments/critique/PQ-20260821-004-RUNTIME-POLICY-CRITIQUE-20260821.md); [card blocker](../experiments/critique/PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-CRITIQUE-20260821.md) | [policy verdict](../literature/VERDICT-20260821-PQ004-POLICY.md); [runtime verdict](../literature/VERDICT-20260821-PQ004-RUNTIME-BLOCKER.md) | BLOCK: no source-backed DFlash2 adaptive policy/implementation |
| PQ-20260821-002 acceptance-calibrated objective | [readiness](../experiments/planning/PQ-20260821-002-READINESS-20260821.md); [objective manifest](../experiments/planning/PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md); [implementation preflight](../experiments/planning/PQ-20260821-002-IMPLEMENTATION-PREFLIGHT-VERDICT-20260821.md); [inventory disposition](../experiments/planning/PQ-20260821-002-IMPLEMENTATION-INVENTORY-DISPOSITION-20260821.md) | [final pre-run verdict](../experiments/critique/PQ-20260821-002-OBJECTIVE-FINAL-VERDICT-20260821.md); [implementation gate](../experiments/critique/PQ-20260821-002-IMPLEMENTATION-GATE-CRITIQUE-20260821.md); [inventory critique](../experiments/critique/PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-INVENTORY-CRITIQUE-20260821.md) | [final verdict](../literature/VERDICT-20260821-PQ002-OBJECTIVE-FINAL.md); [wrapper verdict](../literature/VERDICT-20260821-PQ002-EPHEMERAL-WRAPPER.md); [inventory verdict](../literature/VERDICT-20260821-PQ002-IMPLEMENTATION-INVENTORY.md) | DEFERRED/BLOCKED: no admissible objective implementation; separate implementation card and CEO amendment required |

## Current program verdict

The existing critic review supports bounded observations but identifies
provenance, seal, confound, metric, runtime, and baseline debt. No new
experiment is created by this reconciliation. Actions outside the delegated
boundary remain `SEPARATE USER APPROVAL REQUIRED`, and GPU execution remains
one CEO-approved experiment at a time. Historical records may retain older
conservative approval wording as evidence, but active queue/control-plane
records use `CEO DECISION REQUIRED` or a dated `CEO APPROVED` decision.

The verifier/state-localization proposal reached `READY-NEEDS-APPROVAL`, was
then suspended after the bounded remote preflight. The approved RTX 3060 host,
runtime/build metadata, target, and embedded tokenizer identity were captured;
the exact PLAN-001 evaluator tuple and deployment-shaped Arm-B
positions/mask/cache layout remain unresolved. Its status is therefore
`BLOCKED / evaluator-layout contract not pinned`; no retry or scope expansion
is authorized. The pre-run, recheck, preflight, supplemental, post-block, and
CEO disposition records remain linked in the [PLAN-20260821-001 row above](#per-experiment-records)
and the [CEO decision record](CEO-DECISION-2026-08-21-VERIFIER-PROBE.md).

The earlier `BLOCKED / REPAIR-NEEDED` heartbeat snapshot below is retained as
historical evidence and is superseded by the later written lane inputs,
approval amendment, and blocked-preflight terminal disposition.
