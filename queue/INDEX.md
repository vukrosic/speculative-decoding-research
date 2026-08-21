# Research queue

This is the canonical queue index. Detailed entries are append-oriented and
must link their source-of-truth files. Queue state coordinates work; it never
grants execution authority.

Critique process: [`governance/CRITIQUE-PROCESS.md`](../governance/CRITIQUE-PROCESS.md)
and the program-level [`governance/CRITIQUE-INDEX.md`](../governance/CRITIQUE-INDEX.md).
Every experiment entry must link its own per-experiment critique record before
it can become `ready-needs-approval`; the record must contain pre-run critique,
post-run evidence review, and terminal disposition. GPU execution is one
approved experiment at a time.

## Status legend

`proposed` -> `literature-needed` -> `planned` -> `critique-needed` ->
`ready-needs-approval` -> `approved` -> `running` -> `evidence-review` ->
terminal status. See [`docs/ORCHESTRATION.md`](../docs/ORCHESTRATION.md) for
gate definitions and approval rules.

## Active entries

| ID | Role / question | Status | Approval | Owner / next handoff |
|---|---|---|---|---|
| [CRIT-20260821](../experiments/critique/CRITIQUE-20260821.md) | Adversarial review of seeded evidence and proposal queue | review-complete-documentation-only | NOT NEEDED for the review; no execution authorized | Critic -> orchestrator / evidence closure |
| [LIT-20260821-001](2026-08-21-LIT-001-qwen-verifier-fidelity.md) | What do primary sources and the pinned runtime establish about verifier fidelity, rejection, cache semantics, and shape dependence? | planned (canonical handoff complete) | NOT REQUESTED | Literature reviewer -> planner -> CEO |
| [PLAN-20260821-001](2026-08-21-PLAN-001-verifier-fidelity-probe.md) | Convert the literature result into one bounded, receipt-first verifier-fidelity probe. | CEO BLOCKED: evaluator/layout contract not pinned | No execution approval active | Planner -> critic -> CEO -> executor; [reconciled receipt](../receipts/PLAN-20260821-001/evaluator-armb-contract-reconciliation-20260821.json); [terminal disposition](../receipts/PLAN-20260821-001/final-bounded-disposition-20260821.json); [CEO action log](../governance/CEO-ACTION-LOG-2026-08-21.md); [contract manifest](../governance/PLAN-20260821-001-CONTRACT-MANIFEST.md) |
| [EXP-20260821-004-RERUN](2026-08-21-EXP-004-v30-rerun.md) | Recheck existing Qwen v30 F16/Q4/Q8 export-format trade-off under a frozen approximate screen. | completed-negative; bounded approximate rerun | CEO APPROVED (bounded; completed) | Planner reconciliation; [summary](../receipts/EXP-20260821-004-v30-rerun-20260821/summary.json); [terminal](../receipts/EXP-20260821-004-v30-rerun-20260821/terminal.json) |
| [PQ-20260821-002](2026-08-21-PQ-002-prefix-objective.md) | Test whether the frozen prefix-survival objective improves contiguous prefixes over v27. | BLOCKED-PREFLIGHT: objective implementation absent | CEO approval suspended before fitting; amendment required | Planner -> implementation manifest/card -> critic/literature -> CEO; [blocked terminal receipt](../receipts/PQ-20260821-002-prefix-objective-20260821/terminal.json); [CEO decision](../governance/CEO-DECISION-2026-08-21-PQ002.md) |
| [EXP-20260821-007](../experiments/cards/EXP-20260821-007-smollm-3layer-vs-1layer.md) | Can intermediate SmolLM depth retain acceptance more cheaply? | planned (per-experiment critique required) | NEEDS CEO APPROVAL | Planner -> critic -> CEO; [critique record](../governance/critique/EXP-20260821-007-CRITIQUE.md) |

## Existing planner queue

The detailed planner-owned proposals are preserved in
[`experiments/planning/EXPERIMENT-QUEUE.md`](../experiments/planning/EXPERIMENT-QUEUE.md).
That file currently contains five candidate plans (including a Qwen
verifier/shape localizer, an acceptance-calibrated objective, an intermediate
SmolLM depth test, an adaptive proposal-length screen, and paired state
consistency). They are proposals, not results or authorization. This
orchestration queue owns lifecycle state; the planner file owns detailed
protocol drafts. The literature review above is the gate for reconciling and
prioritizing those drafts before any one is sent to critique or the user.

## Queue rules

- Under the standing delegated policy, the CEO may mark a bounded entry
  `approved` only with a dated CEO decision naming scope, resources, controls,
  receipt path, and held-out boundary. Anything outside that policy requires
  separate user approval.
- Do not start execution from a queue summary; the approved experiment card is
  the run contract.
- Link terminal cards and receipts back here, then preserve the entry as an
  audit trail.
- If a queue item conflicts with `AGENTS.md`, user withdrawal, or a sealed-data
  rule, stop and mark the conflict rather than improvising.
