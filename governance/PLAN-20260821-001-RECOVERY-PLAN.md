---
id: PLAN-20260821-001-RECOVERY-PLAN
date: 2026-08-21
status: blocked-preflight
owner: research CEO
changed_variable: none
family_id: verifier-state-interface
evidence_class: provenance/diagnostic
selection: none
terminal_receipt: receipts/PLAN-20260821-001/final-bounded-disposition-20260821.json
---

# PLAN-001 recovery and re-entry plan

This is an orchestration record, not an experiment approval. The target-only
Arm-A/schedule Arm-B/Arm-D verifier probe remains blocked before comparison.

## Evidence now authoritative

- Reconciled evaluator/Arm-B receipt:
  `receipts/PLAN-20260821-001/evaluator-armb-contract-reconciliation-20260821.json`
  SHA-256 `1d0dc945cc25b7dc8ac990b44cacfbfd0fe08ec023df2a2a66ce5b9fe8193d58`.
- Final local no-new-evidence disposition:
  `receipts/PLAN-20260821-001/final-bounded-disposition-20260821.json`
  SHA-256 `5b8ae5a154dcd0b39653177dc6734b9e2cdb0e166f54c2902c68873f0549a586`.
- Planner verdict:
  [`PLAN-20260821-001-CONTRACT-RECONCILIATION-VERDICT-20260821.md`](../experiments/planning/PLAN-20260821-001-CONTRACT-RECONCILIATION-VERDICT-20260821.md).
- Critic verdict:
  [`PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md`](../experiments/critique/PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md).
- Literature verdict:
  [`VERDICT-20260821-PLAN001-RECONCILIATION.md`](../literature/VERDICT-20260821-PLAN001-RECONCILIATION.md).

## Control-plane links

- Canonical queue entry: [`PLAN-20260821-001`](../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md).
- Named experiment card: [`PLAN-20260821-001-qwen-target-schedule-localizer`](../experiments/cards/PLAN-20260821-001-qwen-target-schedule-localizer.md).
- Program critique index: [`CRITIQUE-INDEX.md`](CRITIQUE-INDEX.md), including the latest contract-reconciliation critique.
- Planner disposition: [`PLAN-20260821-001-CONTRACT-RECONCILIATION-VERDICT-20260821`](../experiments/planning/PLAN-20260821-001-CONTRACT-RECONCILIATION-VERDICT-20260821.md).

## Exact unresolved gate

The evaluator tuple is not bound per replay: rendered prompt/replay ID,
committed/proposed/target IDs, first divergence, correction/commit decision,
sampler/RNG, target logits, state shape/dtype, serialized mask/positions,
cache/rollback state, evaluator dependency tuple, and output accounting remain
`UNKNOWN`. The exact deployment-shaped Arm-B width, positions, sequence IDs,
mask/cache hashes, anchor transition, and source/config tie also remain
`UNKNOWN`. The source description reports memory-after `[171,171]`, while the
parsed historical receipt reports `[170,170]`; this discrepancy is unresolved
and must not be inferred away.

## Only admissible next action

After a fresh written planner/critic/literature review, the CEO may authorize
one narrow source/introspection/evaluator-contract task over the cited
preserved v20–v22 evaluator files/logs and LIT-001 evidence. It must produce a
field-by-field immutable manifest with exact paths, line references, bytes,
hashes, and explicit `UNKNOWN` values. It may not invoke the runtime, build,
replay, infer, evaluate, train, patch, download, install, access held-out
data, or use the GPU.

For every field, the manifest must record a source path plus line number,
JSON key, byte count, and SHA-256, or the literal value `UNKNOWN` with a reason.
Historical values are evidence about prior fixtures, not replicates or proof
of the current deployment-shaped Arm-B schedule. The task has no selection,
optimization, or promotion metric; its only output is a provenance/diagnostic
contract record and a named terminal metadata receipt.

## Re-entry gate

Keep `BLOCKED-PREFLIGHT` unless every mandatory evaluator and Arm-B field is
mechanically evidenced, the memory-after discrepancy is resolved by direct
source/receipt evidence, the approved host/session identity is mechanically
captured (hostname/session, CPU, RAM, OS/kernel, RTX 3060 model/VRAM/free-slot,
and clean process/device state), and planner, critic, and literature each
return a fresh written pass. Only then may the CEO consider a new bounded
decision.
Any missing field, conflicting hash, unproven Arm-B equivalence, resource risk,
or cleanup uncertainty is a hard stop. The historical approval remains
suspended; no Arm A/B/D comparison is authorized by this plan.
