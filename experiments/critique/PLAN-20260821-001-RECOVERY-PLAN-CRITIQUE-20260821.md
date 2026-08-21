---
id: PLAN-20260821-001-RECOVERY-PLAN-CRITIQUE-20260821
date: 2026-08-21
status: blocked-preflight
verdict: BLOCK-with-textual-repairs
scope: governance recovery plan against latest PLAN-001 receipts and diversity/lifecycle gates
authorization: documentation-only; governance file not edited
---

# PLAN-001 recovery-plan critique — 2026-08-21

## Verdict

**BLOCK remains; the recovery plan is directionally safe but not a re-entry
approval.** Its authoritative hashes match the latest reconciliation receipt
(`1d0dc945…`) and terminal no-new-evidence disposition (`5b8ae5a1…`), and it
correctly requires a fresh planner/critic/literature review before any CEO
consideration. The evaluator tuple, exact Arm-B mapping, and `[171,171]` versus
`[170,170]` discrepancy remain unresolved, so no comparison may start.

## Six-gate audit

| Gate | Status | Review / smallest textual repair |
|---|---|---|
| One causal axis | **PASS for the metadata task** | The next action is read-only source/introspection and declares no runtime or experiment change. Add `changed_variable: none` to make this invariant machine-visible. |
| Distinct mechanism | **PASS for recovery scope; annotate** | This is not a new experiment. Add `family_id: verifier-state-interface` and `mechanism: evaluator/Arm-B contract reconciliation` so it cannot be mistaken for PQ-002 objective, PQ-004 scheduler, or PQ-005 consistency work. |
| Metric contract | **PARTIAL/BLOCKED** | The plan lists the required tuple fields, but the recovery manifest should require per-field source path plus line/JSON-key reference, byte size, SHA-256, and explicit `UNKNOWN`; it must also require target-only oracle token/output hash and output-token accounting. |
| Evidence-class boundary | **PARTIAL** | No comparison is authorized, but add explicit `evidence_class: provenance/diagnostic only`; historical v20–v22 state/acceptance/speed values are reference context, never exactness, speed, or replication evidence. |
| Selection/multiplicity | **PARTIAL** | Held-out access is prohibited, but add `selection: none` and state that no prompt/checkpoint/threshold selection or validation claim is made by the metadata task; historical screens cannot be reused as independent replicates. |
| Lifecycle/provenance/safety | **PASS with receipt repair** | Links, approval boundary, no-GPU/no-build/no-held-out stops, and three-lane review are present. Require a named recovery-manifest/terminal receipt recording commands, source hashes, no-process/no-device action, cleanup/unchanged state, and final `UNKNOWN` fields before CEO review. |

## Required wording repair before re-entry consideration

The recovery plan should add one sentence to the admissible-action section:

> `changed_variable: none; family_id: verifier-state-interface; evidence_class:
> provenance/diagnostic only; selection: none. Every manifest row carries a
> source path and line/JSON-key reference, byte size, SHA-256, and either a
> mechanically bound value or explicit UNKNOWN. Historical values are not
> replicas and cannot close evaluator, exactness, speed, or Arm-B gates.`

This is a textual contract repair, not an execution request. Until the
field-by-field manifest closes every required evaluator/Arm-B value (or the
CEO explicitly accepts a terminal unknown), the plan's own re-entry gate stays
`BLOCKED-PREFLIGHT`; no Arm A/B/D run, runtime patch, GPU action, or approval is
authorized.

