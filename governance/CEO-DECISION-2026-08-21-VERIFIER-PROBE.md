# CEO decision — verifier/state-localization probe

Date: 2026-08-21  
Queue item: [PLAN-20260821-001](../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md)  
Decision: **BLOCKED-PREFLIGHT — bounded approval aborted before comparison**  
Previous decision: **CEO APPROVED (bounded scope), preserved below**  
Executor handoff: **closed with blocked terminal disposition**

## Current closure decision — 2026-08-21

**CEO BLOCKED.** The planner, critic, and literature inputs are reconciled and
the bounded design is complete. The approved RTX 3060 host/session preflight
has now completed, but its receipt still has three unresolved fields:
tokenizer artifact/hash, PLAN-001 state-contract evaluator identity, and Arm B
target-only positions/mask/cache layout. The supplemental read-only pass has
resolved tokenizer identity from embedded GGUF metadata; the single remaining
contract gap is the complete evaluator tuple plus exact Arm B layout. No
comparison, retry, or scope expansion is authorized.

## Current amendment after read-only inventory — 2026-08-21

The executor's read-only inventory
[`evaluator-armb-layout-inventory-20260821.json`](../receipts/PLAN-20260821-001/evaluator-armb-layout-inventory-20260821.json)
(SHA-256 `bb1d4a6dd6bf3567454992d526219fdb2b393c1084f33ab6afaacd1bf98c623e`)
and the written planner, critic, and literature reviews are now reconciled.
Host/GPU/runtime/target/tokenizer provenance is closed for preflight, but the
single execution gate remains **BLOCKED**: no complete PLAN-001 evaluator
tuple binds committed-prefix, proposed/target/correction IDs, replay ID,
serialized mask/position/cache state, and evaluator dependency identity; the
exact deployment-shaped Arm-B mapping is not proven; and the preserved
singleton memory-after evidence conflicts (`[171,171]` versus `[170,170]`).
Historical block2/block7 values remain context only. This is an evidence/design
blocker, not a falsification. No Arm A/B/D comparison, retry, or scope
expansion is authorized.

Smallest recovery action assigned: produce one immutable read-only
source-backed manifest/receipt that either closes the complete evaluator tuple
and exact Arm-B shape/mask/cache mapping or records each field as `unknown`
with hashes and provenance. Then obtain fresh critic, planner, and literature
re-review before any CEO amendment. If the manifest cannot be closed without
model/evaluation execution, record that external blocker and retain this
proposal blocked; do not infer values.

## Approval policy applied

The CEO may approve only a bounded, documented experiment inside the existing
repository/GPU scope. It must be non-destructive, use no external publication,
spending, downloads, installs, or sealed-held-out data, and stop on missing
evidence or resource risk. Before approval, the literature, planner, and critic
lanes must each provide complete written input. All future execution remains
`NEEDS CEO APPROVAL` until that decision is recorded.

For avoidance of doubt, the CEO may approve only bounded, documented
experiments inside the existing repository/GPU scope after complete written
literature, planner, and critic inputs. Anything outside that boundary is
`SEPARATE USER APPROVAL REQUIRED`. Legacy conservative approval wording is
retained only as historical annotation and does not override this delegated
policy.

## Preflight receipt update — 2026-08-21

The remote receipt
[`remote-preflight-20260821.json`](../receipts/PLAN-20260821-001/remote-preflight-20260821.json)
proves the RTX 3060 slot is free and records the host, toolchain, runtime
commit/binary hash, prompt manifest, seed, historical evaluator hashes, and
historical block shape. It explicitly records the three unresolved fields
above. The supplemental receipt
[`remote-preflight-supplement-20260821.json`](../receipts/PLAN-20260821-001/remote-preflight-supplement-20260821.json)
resolves tokenizer identity via embedded GGUF metadata and records partial
historical evaluator/source and Arm-B-like layout evidence. It does not close
the complete PLAN-001 evaluator tuple or prove that the historical layout is
the exact deployment-shaped Arm-B schedule. A new CEO amendment is required
after the remaining receipt and lane reviews are reconciled.

## Historical written lane inputs — pre-repair snapshot

The following table is retained as the earlier pre-repair state. It is
superseded by the completed literature handoff, named planner card, critic
recheck/post-block records, and the current closure decision recorded above
and below. It does not represent the current gate state.

| Lane | Source | Status | CEO assessment |
|---|---|---|---|
| Literature | [LIT-20260821-001](../queue/2026-08-21-LIT-001-qwen-verifier-fidelity.md), [`literature/synthesis.md`](../literature/synthesis.md), [`papers/INDEX.md`](../papers/INDEX.md) | **Incomplete** | Source notes exist, but the canonical `papers/` handoff is explicitly incomplete. The required pinned implementation/version and claim-to-test note are not closed. |
| Planner | [PLAN-20260821-001](../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md), [`experiments/planning/EXPERIMENT-QUEUE.md`](../experiments/planning/EXPERIMENT-QUEUE.md) | **Provisional / blocked** | The question and controls are useful, but the plan says it must be narrowed after LIT-001; the published drafter hash and historical flags remain to be recovered, and no named experiment card is attached. |
| Critic | [`experiments/critique/CRITIQUE-20260821.md`](../experiments/critique/CRITIQUE-20260821.md), especially F-01/F-05/F-06 and R-01/R-05/R-08/R-10 | **Blocking findings** | Provenance/receipt closure, exactness accounting, baseline matching, and literature canonicalization are required before the probe is reproducible or ready. |

## Blocker

G1–G3 are not all passed. The literature lane has not completed the required
canonical note or explicit `papers/` linkage; the planner therefore cannot
freeze the single causal change and all immutable identities; and the critic's
known provenance and baseline defects remain open. Approving now would violate
the CEO policy requiring complete written input from all three lanes and would
risk an uninterpretable runtime result.

This is a process/evidence blocker, not a claim that the verifier/state
localization hypothesis is false. No prior card, receipt, or negative result is
overwritten.

## Required re-entry conditions

The CEO may reconsider only after the shared Markdown records show:

1. a completed literature handoff separating author claims, observed runtime
   behavior, exactness assumptions, unknowns, and claim-to-test mappings;
2. a named experiment card with one causal change, frozen target/drafter/
   runtime/prompt/evaluator identities, matched target-only oracle, negative
   controls, resource budget, non-sealed boundary, and stop rules;
3. recovered published drafter hash and historical flags, or an explicit
   `unknown` decision that narrows the probe so it does not depend on them;
4. a per-experiment pre-run critique record with a `ready-needs-approval`
   verdict and links from the card and queue; and
5. a complete receipt schema covering every command/configuration, version,
   milestone, error/failure, metric, interpretation, artifact hash/path,
   cleanup state, and knowledge update.

If any condition is missing, the CEO records `blocked` again and does not hand
the work to the executor. If the eventual scope exceeds the bounded policy,
it becomes `SEPARATE USER APPROVAL REQUIRED` rather than CEO-approvable.

## CEO approval amendment — 2026-08-21

### Written lane inputs reconciled

| Lane | Written input | CEO finding |
|---|---|---|
| Literature | [`HANDOFF-20260821-LIT-001`](../literature/HANDOFF-20260821-LIT-001.md) and [`PAPER-20260821-verifier-fidelity-dflash-qwen`](../papers/PAPER-20260821-verifier-fidelity-dflash-qwen.md) | **PASS.** Canonical source/claim-to-test handoff complete; unknown build metadata is explicitly preserved as a preflight condition. |
| Planner | [`PLAN-20260821-001-qwen-target-schedule-localizer`](../experiments/cards/PLAN-20260821-001-qwen-target-schedule-localizer.md) and updated [`RECOMMENDATION-20260821-VERIFIER-PROBE`](../experiments/planning/RECOMMENDATION-20260821-VERIFIER-PROBE.md) | **PASS.** Exactly one causal change: target-only singleton versus deployment-shaped block schedule; Arm D is a negative control; Arm C excluded. |
| Critic | [`PLAN-20260821-001-VERDICT-20260821-RECHECK`](../experiments/critique/PLAN-20260821-001-VERDICT-20260821-RECHECK.md) | **PASS.** Verdict `READY-NEEDS-APPROVAL`; scope, state contract, exactness boundaries, safety, receipt schema, and lifecycle links pass. |

### Approved execution scope

The CEO authorizes exactly one bounded diagnostic:

- Target-only Arm A singleton replay versus Arm B deployment-shaped block
  replay under llama.cpp DFlash lineage `5ecbe1ac`.
- Arm D cache/rollback negative control as specified in the card.
- Six frozen diagnostic prompts from EXP-20260820-001; no training or sealed
  held-out data; no selection or promotion claim.
- One RTX 3060 GPU slot, one process, maximum one hour, existing artifacts only.
- Mandatory preflight capture of every unknown runtime/build/compiler/CUDA/
  driver/backend/thread/device/tokenizer/evaluator/prompt/seed/flag/block-shape
  identity. Stop before comparison if any identity is unavailable or any
  target-only oracle/control fails.
- Compact receipts only under `receipts/PLAN-20260821-001/`; no binaries,
  weights, large traces, runtime patches, downloads, installs, publication,
  spending, or follow-up experiments.

This approval does not authorize Arm C, speculative acceptance measurement,
serving-speed claims, quality claims, general exactness/losslessness claims,
cache patches, training, or any scope expansion. Any such change requires a
new card, new critic review, and a new CEO decision; actions outside the
delegated boundary remain `SEPARATE USER APPROVAL REQUIRED`.

### Executor handoff condition

The executor may start only after acknowledging this exact scope, confirming
the GPU slot is free, and recording the preflight plan. If any mandatory
identity or resource condition fails, it must stop and return a written
`blocked`/`aborted` disposition with the partial receipt; it must not improvise
or broaden the run.

## Terminal disposition — 2026-08-21 09:25 UTC

**Observed:** The executor acknowledged the exact approved scope and performed
read-only preflight on local macOS arm64. `nvidia-smi` was unavailable, so the
RTX 3060 slot could not be confirmed. The pinned runtime/build/compiler/CUDA/
driver/backend/thread/device identities, tokenizer, evaluator, prompt
manifest, seed, flags, and block shape were unavailable. The executor stopped
before Arm A/B or Arm D comparison.

**Observed:** Compact blocked receipts were written under
[`receipts/PLAN-20260821-001/`](../receipts/PLAN-20260821-001/):
`environment.json`, `target-only-oracle.json`, `schedule-state-trace.json`,
`cache-rollback-negative-control.json`, and `terminal.json`. They record
`not-run`/`aborted`, no process or GPU work, no downloads/installs/patches/
training/held-out access, and cleanup of zero task-owned processes.

**CEO decision:** Classify the attempt as `aborted / blocked-preflight`, not a
result and not a negative experiment. Suspend the bounded approval; do not
retry or broaden the scope. The executor is idle and no GPU execution is
active.

## External blocker and smallest next action

The blocker is external execution-state/provenance availability: an approved
RTX 3060 host/session with `nvidia-smi` and the pinned llama.cpp build, plus the
preserved v20–v22 runtime/prompt/evaluator metadata, is not available in the
current executor environment. The smallest next action is to provide or
confirm that authorized host/session and preserved metadata, then repeat only
the read-only preflight. Do not infer missing identities from memory or run on
the local Mac. Any retry requires a new CEO decision amendment after the
preflight inputs are present.

## Historical heartbeat snapshot — 2026-08-21 09:01 UTC (superseded)

This snapshot is retained to preserve the earlier state. It predates the
completed literature handoff, repaired planner card, critic recheck, CEO
approval amendment, and 09:25 UTC blocked-preflight terminal disposition
recorded above. It is not the current decision and does not authorize or
block any action beyond the later disposition.

**Observed:** Since the prior decision, the literature lane added a
state-localization CEO note, knowledge update, and additional primary-source
notes. The planner added a narrowed target-only shape-replay recommendation,
but its approval state is explicitly `HOLD — not ready for CEO approval`. The
critic added [`PLAN-20260821-001-PRE-RUN.md`](../experiments/critique/PLAN-20260821-001-PRE-RUN.md),
whose verdict is `BLOCKED / REPAIR-NEEDED` with critical blockers B1–B5.

**Observed:** The literature queue remains `evidence-review` with canonical
handoff incomplete, and [`papers/INDEX.md`](../papers/INDEX.md) still contains
the reading queue rather than a canonical paper/implementation note. The
planner still requires a named experiment card, immutable runtime/build and
prompt identities, and a receipt path. The critic still requires a singular
causal arm, fresh target-only controls, complete provenance, and lifecycle
links.

**CEO decision:** Reaffirm **BLOCKED — not CEO-approved**. The three written
lane inputs are now present but not complete/ready: literature is incomplete,
planner is HOLD, and critic is repair-needed. No executor handoff, GPU work,
runtime change, download, install, or held-out access is authorized.

## Read-only contract reconciliation — 2026-08-21

The later executor reconciliation receipt
[`evaluator-armb-contract-reconciliation-20260821.json`](../receipts/PLAN-20260821-001/evaluator-armb-contract-reconciliation-20260821.json)
SHA-256 `1d0dc945cc25b7dc8ac990b44cacfbfd0fe08ec023df2a2a66ce5b9fe8193d58`
is now the current metadata record. It improves runtime/binary/target/prompt
provenance but leaves the evaluator tuple and exact Arm-B deployment mapping
unknown, including replay and divergence IDs, correction/commit, RNG/logits,
state shape/dtype, serialized mask/cache/rollback, dependency identity, exact
width/positions/sequence IDs, and anchor transition. It also preserves the
source-versus-parsed memory-after conflict `[171,171]` versus `[170,170]`.

Planner, critic, and literature re-review all remain **BLOCK**. The smallest
next action is one narrow source/receipt extraction over the cited v20–v22
evaluator files/logs and LIT-001 evidence, preserving explicit UNKNOWNs; no
runtime invocation, Arm A/B/D comparison, or approval amendment is authorized.
