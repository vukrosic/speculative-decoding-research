---
id: PLAN-20260821-001-qwen-target-schedule-localizer
date: 2026-08-21
status: blocked-preflight
method: target-only schedule/state localization under pinned quantized runtime
exactness_contract: six-prompt strict-greedy diagnostic only; no general claim
heldout_touched: false
tags: [qwen, dflash2, quantization, runtime, schedule, diagnostic, planner]
critique: ../critique/PLAN-20260821-001-PRE-RUN.md
critique_recheck: ../critique/PLAN-20260821-001-VERDICT-20260821-RECHECK.md
latest_reconciliation_critique: ../critique/PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md
program_critique_index: ../../governance/CRITIQUE-INDEX.md
ceo_decision: ../../governance/CEO-DECISION-2026-08-21-VERIFIER-PROBE.md
recovery_plan: ../../governance/PLAN-20260821-001-RECOVERY-PLAN.md
---

# Does deployment-shaped target execution change the next-token state?

## Question and causal protocol

Under one pinned quantized Qwen target/runtime contract, does changing only the
target execution schedule from singleton calls to the deployment-shaped block
schedule change target state/logits for the same committed prefix? This card is
the repaired planner packet for `PLAN-20260821-001`. It is a diagnostic design,
not approval or an execution record.

Control-plane links: [per-experiment critique](../critique/PLAN-20260821-001-PRE-RUN.md),
[latest contract-reconciliation critique](../critique/PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md),
[program critique index](../../governance/CRITIQUE-INDEX.md), [canonical CEO
decision](../../governance/CEO-DECISION-2026-08-21-VERIFIER-PROBE.md), and
[recovery/re-entry plan](../../governance/PLAN-20260821-001-RECOVERY-PLAN.md).

The single causal change is **target execution schedule**:

- **Arm A — target-only singleton:** target-only greedy replay with one target
  call per committed position; no drafter and no verifier transaction.
- **Arm B — target-only deployment-shaped block:** target-only calls using the
  exact block shape, positions, mask, and cache layout emitted by the pinned
  runtime, with drafter and correction logic disabled. The block width and
  runtime flags are `unknown` until mechanically recovered from the pinned
  build manifest; they must not be guessed.

The following is a separate diagnostic control, not an additional causal arm:

- **Arm D — cache/rollback negative control:** a forced accept, rejection, and
  correction/rollback round trip; after each transaction compare the next
  target logits with a fresh singleton call from the same committed prefix.

The published speculative trace (formerly Arm C) is **excluded from the
approved/run scope**. It may be considered only in a new amendment after its
immutable drafter hash and all historical flags are recovered.

No training, feature extraction, runtime patch, model conversion, download,
install, or drafter modification is in scope.

## Authorization and scope

- Authorized action: local documentation and, only after separate approval,
  one bounded diagnostic run using existing artifacts.
- Explicit exclusions: SSH/remote actions, GPU execution before approval,
  training, generation outside the six prompts, held-out access, downloads,
  installs, runtime/source edits, quantization changes, and publishing.
- Approval state: `CEO APPROVED (bounded scope), suspended after blocked
  preflight`; no retry is authorized until a new CEO amendment records the
  external host and metadata unblock.
- Stop immediately on load failure, target-only oracle mismatch, negative-control
  failure, missing immutable runtime identity, or any attempted held-out access.
- Budget: one GPU slot, maximum one hour wall time, existing artifacts only;
  compact text/JSON receipts only (no binaries or large traces in Git).

## Frozen controls and identities

- Target: Unsloth `Qwen3.8-27B-UD-IQ1_S.gguf`, SHA-256
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Target quantization: IQ1_S (frozen; exact quantization metadata receipt:
  `unknown`).
- Drafter: not used by the bounded Arm A/B/ D run. A matching published
  Q4_K_M DFlash2 GGUF hash is therefore not a run prerequisite; any future
  speculative trace requires a new amendment with immutable hash and flags.
- Runtime lineage: isolated llama.cpp DFlash2 PR lineage `5ecbe1ac`.
- Pinned binary/source/compiler/CUDA/driver/backend/thread/device-split
  identities: mandatory preflight capture; currently `unknown`. Stop before
  comparison if any is unavailable; never guess.
- Tokenizer and tokenizer hash: mandatory preflight capture; currently
  `unknown`. Stop before comparison if unavailable.
- Prompts: six frozen representative diagnostic prompts from
  `EXP-20260820-001`; IDs/order and prompt-manifest hash are mandatory
  preflight capture, currently `unknown`. Stop before comparison if unavailable.
  Context limit: 4K.
- Decoding: strict greedy; seed and all runtime flags are mandatory preflight
  capture, currently `unknown`. Stop before comparison if unavailable.
- Evaluator: pinned strict token-ID comparison plus state-contract logger;
  evaluator commit/hash is mandatory preflight capture, currently `unknown`.
  Stop before comparison if unavailable.
- Hardware: RTX 3060 12 GB; host/CPU/RAM/OS details `unknown` and must be
  recorded before any approved run.

## Baseline and required preflight

Baseline is a fresh target-only replay under the same pinned binary/runtime,
compared with the preserved target-only oracle from
`EXP-20260820-001`. Run twice from clean processes and require identical token
IDs and output lengths on all six prompts before Arm B or Arm D. Existing
historical speculative numbers are context only and are not a result of this
card.

Preflight gates (all must pass):

- [ ] immutable target, binary, environment, tokenizer, prompt, evaluator, and
  flag identities recorded (stop-before-comparison if any are unavailable);
- [ ] target-only singleton replay twice matches preserved oracle;
- [ ] Arm B block shape/mask/positions/cache lengths mechanically inspected;
- [ ] Arm D accept/reject/correction rollback round trips pass the state
  comparison contract;
- [ ] no sealed/held-out data opened and process/device ownership is clean.

## State contract and metrics

At each first divergence record prompt ID, cycle/position, committed prefix,
proposed and target token IDs, target top-1/logit summary, state shape/dtype,
mask and position IDs, cache state before/after commit and rollback, correction
token, and deterministic replay ID. Compare Arm B's next-token state with a
fresh singleton target call from the same committed prefix.

Report separately:

| Evidence class | Metric | Arm A | Arm B | Arm D | Receipt |
|---|---|---|---|---|---|
| exactness diagnostic | token-ID identity / first divergence | | | | |
| state diagnostic | hidden/logit delta at fixed prefix | | | | |
| acceptance | accepted/proposed and accepted/cycle | n/a | n/a | n/a | |
| quality | output/content match (diagnostic only) | | | | |
| speed | timing (diagnostic only; no claim) | | | | |
| state control | cache/mask/position/rollback checks | | | | |

Timing is instrumentation only and cannot support a serving-speed claim.
Loss, quality, acceptance, and speed must not be inferred from one another.

## Stop rules and boundary

Stop on any preflight failure, non-deterministic singleton replay, missing
identity, cache/rollback mismatch, or process/device cleanup failure. Otherwise
stop after the six-prompt Arm A/B replay and Arm D controls; repeat only the
divergent prompt once for reproducibility.
Do not broaden prompts, proposal lengths, or runtime variants without a new
card. Held-out training/test data remains sealed and is not a selection set.

## Compact receipt paths

Planned receipt directory: `receipts/PLAN-20260821-001/` (external/runtime
artifacts may remain at their preserved paths). Required compact files:

- `target-only-oracle.json` — two clean replays, token IDs/lengths, hashes;
- `schedule-state-trace.json` — Arm A/B fixed-prefix comparisons and state
  contract;
- `cache-rollback-negative-control.json` — Arm D transaction outcomes;
- `environment.json` — binary/source/compiler/CUDA/driver/backend/device and
  flag identities;
- `terminal.json` — commands, timestamps, outputs/hashes, failures, cleanup,
  and final GPU/process state.

No receipt currently exists for this planned card; all unknowns remain
`unknown` until an approved run or preserved receipt supplies them.

## Decision boundary

This card can localize a schedule/state mismatch on six frozen prompts only.
It cannot establish general exactness, losslessness, quality preservation, or
serving speed. A result remains validation/diagnostic evidence unless every
relevant gate passes and a later card defines a broader contract.

## Observed

No Arm A, Arm B, or Arm D comparison has been run from this card. The linked
preflight and reconciliation receipts record the unresolved evaluator/layout
fields and preserve the `[171,171]` versus `[170,170]` memory-after conflict.

## Interpretation / hypotheses

The hypothesis is that deployment-shaped target execution or state transaction
semantics may cause the strict divergence. This remains untested; historical
block examples are context, not proof of the pinned Arm-B layout.

## Reproduction

Use the frozen identities, six-prompt boundary, and preflight gates above only
after a dated CEO decision reopens the card. The queue, recovery plan, and
linked receipts are the current source of truth; no command is authorized by
this card alone.

## Artifacts and receipts

The compact receipt directory is `receipts/PLAN-20260821-001/`. Current
reconciliation and terminal-disposition hashes are linked from the queue and
CEO decision. Unknown fields must remain unknown rather than being inferred.
