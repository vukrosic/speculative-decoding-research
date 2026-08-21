# PLAN-20260821-001 — bounded verifier-fidelity probe

Status: `blocked-preflight` (approved scope aborted before comparison)  
Approval: `none active`; prior `CEO APPROVED (suspended after blocked preflight)` is preserved in the decision record; separate user approval is required outside the CEO boundary  
Created: 2026-08-21  
Owner: experiment planner  
Next handoff: experiment critic

Named experiment card: [`PLAN-20260821-001-qwen-target-schedule-localizer`](../experiments/cards/PLAN-20260821-001-qwen-target-schedule-localizer.md)

Per-experiment critique: [`PLAN-20260821-001-PRE-RUN`](../experiments/critique/PLAN-20260821-001-PRE-RUN.md); [`post-block`](../experiments/critique/PLAN-20260821-001-POST-BLOCK-20260821.md); [`re-entry`](../experiments/critique/PLAN-20260821-001-REENTRY-CRITIQUE-20260821.md); [`inventory critique`](../experiments/critique/PLAN-20260821-001-EVALUATOR-ARMB-INVENTORY-CRITIQUE-20260821.md)
Latest reconciliation critique: [`contract reconciliation`](../experiments/critique/PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md)

Critique process: before this proposal can become `ready-needs-approval`, the
planner must attach the named experiment card and its own per-experiment
critique record, then complete pre-run critique. See
[`governance/CRITIQUE-PROCESS.md`](../governance/CRITIQUE-PROCESS.md) and the
[program critique index](../governance/CRITIQUE-INDEX.md). This requirement
does not authorize execution.

CEO decision: [current CEO BLOCKED decision](../governance/CEO-DECISION-2026-08-21-VERIFIER-PROBE.md).
CEO recovery plan: [PLAN-001 recovery and re-entry plan](../governance/PLAN-20260821-001-RECOVERY-PLAN.md).

The host/session preflight receipt is now present and confirms a free RTX 3060.
The supplemental pass resolved tokenizer identity from embedded GGUF metadata,
and the read-only inventory captured historical runtime/source fields. The
remaining metadata deliverable is incomplete: the PLAN-001 state-contract
evaluator tuple and exact Arm B target-only positions/mask/cache layout are
unresolved, including the `[171,171]` versus `[170,170]` memory-after conflict.
The executor has completed read-only inventory only; no comparison or retry is
authorized.

The current single blocker and required fields are consolidated in the
[contract manifest](../governance/PLAN-20260821-001-CONTRACT-MANIFEST.md).
The latest read-only inventory is
[`evaluator-armb-layout-inventory-20260821.json`](../receipts/PLAN-20260821-001/evaluator-armb-layout-inventory-20260821.json);
its planner and literature verdicts remain `BLOCK`. The follow-up immutable
contract reconciliation is
[`evaluator-armb-contract-reconciliation-20260821.json`](../receipts/PLAN-20260821-001/evaluator-armb-contract-reconciliation-20260821.json),
SHA-256 `1d0dc945cc25b7dc8ac990b44cacfbfd0fe08ec023df2a2a66ce5b9fe8193d58`.
It enumerates every required evaluator and Arm-B field but leaves the missing
tuple/layout identities `UNKNOWN`; the `[171,171]` versus `[170,170]`
memory-after discrepancy remains unresolved. Comparison remains blocked.
Planner disposition: [`PLAN-20260821-001-CONTRACT-RECONCILIATION-VERDICT-20260821`](../experiments/planning/PLAN-20260821-001-CONTRACT-RECONCILIATION-VERDICT-20260821.md)
— retain `BLOCKED`; the smallest next step is one narrow source/receipt
extraction, with no runtime invocation or Arm A/B/D comparison. The final
bounded local-only disposition is
[`final-bounded-disposition-20260821.json`](../receipts/PLAN-20260821-001/final-bounded-disposition-20260821.json),
SHA-256 `5b8ae5a154dcd0b39653177dc6734b9e2cdb0e166f54c2902c68873f0549a586`;
it adds no evidence and keeps the same block.

The approved scope was target-only Arm A/B schedule comparison plus Arm D
cache/rollback control; six frozen prompts; one RTX 3060 slot; maximum one
hour; existing artifacts only; no Arm C speculative trace, training, runtime
patches, downloads, installs, publishing, spending, or held-out access. All
unknown identity fields are mandatory preflight captures; stop before
comparison if any are unavailable. It was not executed because the complete
evaluator/layout contract remains unavailable; host/GPU availability is no
longer the blocker.

## Repaired provisional question

Under one frozen Qwen target/runtime contract, does changing only target
execution from singleton calls to the deployment-shaped block schedule change
the next-token state for the same committed prefix? Published speculative
tracing and cache/rollback are separate diagnostics, not bundled causal
changes.

This is a design hypothesis, not a result. Do not bundle feature extraction,
runtime patches, quantization, drafter changes, correction semantics, or
training. The named card freezes the non-sealed six-prompt boundary, one-hour/
one-GPU budget, stop rules, and compact receipt paths.

## Required planner packet

- baseline: the exact target-only oracle and the published/custom drafter
  comparison that is being diagnosed;
- frozen target/drafter/runtime/checkpoint hashes, prompts, tokenizer, seed,
  evaluator, and proposal length;
- one intended change and a separate negative control for exactness;
- preflight shape, finite-gradient, evaluator, and process/device gates;
- separate acceptance, output quality, exactness, and end-to-end speed rows;
- sealed held-out policy, artifact budget, stop conditions, and receipt paths;
- explicit distinction between approximate and exact contracts.

## Critic checklist

The critic must reject the packet if it relies on loss as an acceptance proxy,
uses an unsealed set for selection, changes more than one causal variable,
omits a matched target-only baseline, or lacks a terminal receipt and cleanup
state. A repaired packet may become `ready-needs-approval`; it may not become
`approved` by an agent.

## Approval boundary

No retry, SSH, GPU work, training, generation, evaluation, download, install,
or use of sealed held-out data is authorized by this entry. A new CEO decision
amendment is required after the external host and metadata blocker is cleared;
actions outside the CEO boundary remain `SEPARATE USER APPROVAL REQUIRED`.
