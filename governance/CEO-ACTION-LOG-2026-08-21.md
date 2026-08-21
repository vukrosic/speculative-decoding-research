# CEO action log — verifier-probe closure

Date: 2026-08-21  
Owner: research CEO/orchestrator  
Scope: documentation and bounded-experiment governance only

## Standing instruction recorded

The CEO mandate is permanent: accelerate and improve speculative decoding,
continue indefinitely, identify and advance the next useful in-scope action,
coordinate all lanes, and preserve complete written records. The CEO may stop
only on user withdrawal or a genuine external/system blocker, which must carry
an exact missing deliverable, assigned recovery action, and re-entry gate.
GPU execution remains single-threaded and all safety/approval boundaries stay
in force; indefinite operation does not authorize destructive actions,
spending, publication, downloads/installs, or sealed-holdout access.

## Current action

The CEO actively requested fresh written closure inputs from the literature,
planner, critic, and executor lanes. The requests were limited to the existing
PLAN-20260821-001 packet; no code, SSH, GPU, download, install, publication,
or held-out access was authorized.

## Lane responses reconciled

| Lane | Written response | CEO finding |
|---|---|---|
| Literature | Canonical DFlash/DFlash2 handoff covering lineage, author claims versus observations, rejection/correction, KV/state transactions, shape/mask/quantization assumptions, exactness contracts, and lineage `5ecbe1ac`. | **PASS for literature completeness.** The earlier request for a planner link is satisfied by the named card and queue entry. |
| Planner | One causal change: target-only singleton versus deployment-shaped block schedule; Arm D cache/rollback negative control; Arm C excluded; frozen target hash, IQ1_S, six prompts, strict greedy/4K context, one RTX 3060 slot, one-hour cap, existing artifacts, stop rules. | **PASS for design; BLOCK for preflight.** |
| Critic | Latest post-block record says design gates pass and exactness is unmeasured because no comparison began. | **BLOCK with one provenance/resource gate.** |
| Executor | Terminal handoff confirms no process/GPU action. | **BLOCK until the approved-host preflight receipt exists.** |

## CEO decision

**BLOCKED — one exact deliverable is missing:** an approved RTX 3060
host/session plus one compact, read-only preflight identity receipt proving GPU
availability and capturing runtime/build/compiler/CUDA/driver/backend/thread/
device, tokenizer, evaluator, six-prompt manifest, seed, flags, and deployment
block shape.

Assigned action: **experiment executor** must obtain or be given that
authorized host/session and produce the receipt. The smallest next step is
read-only preflight only; it must stop again if any field is unavailable. No
comparison, inference, retry, or scope expansion is authorized by this log.

## Approval precedence

The current delegated policy is unambiguous: the CEO may approve only bounded,
documented experiments within the existing repository/GPU scope after complete
written lane inputs. Anything outside that boundary is
`SEPARATE USER APPROVAL REQUIRED`. Legacy conservative approval wording is
preserved as historical records and does not override this policy; the current
probe is not approved because its preflight deliverable is missing.

## Record links

- [CEO decision](CEO-DECISION-2026-08-21-VERIFIER-PROBE.md)
- [Planner queue item](../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md)
- [Program critique index](CRITIQUE-INDEX.md)
- [Post-block critique](../experiments/critique/PLAN-20260821-001-POST-BLOCK-20260821.md)

## Next concrete action — re-entry checklist

The CEO prepared [REENTRY-CHECKLIST-PLAN-20260821-001.md](REENTRY-CHECKLIST-PLAN-20260821-001.md)
and assigned planner, critic, and literature lanes to validate it in parallel.
The executor remains assigned the smallest unblock task: obtain the approved
host/session and produce the mandatory read-only identity receipt. This is
documentation and coordination only; no experiment authorization changes.

## Checklist validation result

The literature lane **PASS**ed the checklist's claim-to-test and exactness
boundaries. The planner lane **PASS**ed the design fields but kept re-entry
**BLOCKED** on the host receipt. The critic lane found one omission—approved
host CPU/RAM/OS/kernel identity—and that field has been added above. The
executor remains barred from comparison; the approved-host receipt is now
complete, but its supplemental tokenizer/evaluator/layout fields remain open.

## Urgent executor assignment — read-only remote preflight

The CEO assigned the existing executor task to use the recorded remote
connection `ssh -p 35738 root@125.240.239.50 -L 8080:localhost:8080` and the
existing project `/workspace/smollm-eagle3-prototype`. The assignment is
strictly limited to host/CPU/RAM/OS/kernel/GPU/device/process and mandatory
runtime/evaluator/prompt identity capture, written to
`receipts/PLAN-20260821-001/`. It explicitly forbids the verifier run,
inference, evaluation, training, downloads, installs, patches, held-out access,
or scope expansion. If the connection or any identity field fails, the
executor must record that exact blocker and recovery action rather than
attempting the experiment.

Status at assignment: **preflight pending; no experiment authorized**. The
executor acknowledged the exact SSH/project context and completed the first
read-only preflight. Next action: executor returns the supplemental metadata
receipt or a precise field-level blocker; the CEO then reconciles it and
decides whether a new bounded approval amendment is possible.

## Preflight result and next unblock actions

The executor completed the remote read-only preflight successfully. The RTX
3060 is free (1 MiB / 12,288 MiB, 0% utilization, no compute processes), and
host CPU/RAM/OS/kernel, CUDA/driver/toolchain, runtime commit and binary hash,
backend/build flags, thread/device placement, prompt manifest/hash/IDs, seed,
historical evaluator hashes, and historical block shape were recorded in
[`remote-preflight-20260821.json`](../receipts/PLAN-20260821-001/remote-preflight-20260821.json).

The receipt leaves three precise metadata gaps: tokenizer artifact/hash,
PLAN-001 state-contract evaluator identity, and Arm B target-only
positions/mask/cache layout. The CEO assigned a second read-only metadata pass
to the executor and parallel reviews to planner, critic, and literature. The
pass must inspect existing files only; it must not invoke model code or infer
missing fields. Until the supplemental receipt closes or explicitly narrows
these gaps, the verifier experiment remains **CEO BLOCKED** and no GPU
comparison is authorized.

The remote-preflight critique confirms host/GPU/runtime/build/target/prompt/
resource gates pass; tokenizer and evaluator mapping may be closed read-only,
while Arm B layout still requires a source-backed manifest or an explicit
block. See [`remote preflight critique`](../experiments/critique/PLAN-20260821-001-REMOTE-PREFLIGHT-CRITIQUE-20260821.md).

## Contract-manifest action

The CEO created [PLAN-20260821-001-CONTRACT-MANIFEST.md](PLAN-20260821-001-CONTRACT-MANIFEST.md)
to pin the closed identities, preserve partial historical components as
context, and state the exact evaluator tuple and Arm-B layout fields still
unknown. This is the next documentation gate; it does not authorize a run.

The supplemental receipt is JSON-valid with SHA-256
`4b8d28607ca7db2777bce88470b282e244e299dc97ac7dc3003a8d571c1a9b2f`. The
latest lane consensus is **BLOCK** on the single end-to-end contract gap;
tokenizer identity is closed, while the evaluator tuple and exact Arm-B
layout remain unknown.

## Active next action — manifest equivalence review

The CEO assigned planner, critic, and literature lanes to review the contract
manifest in parallel. Their bounded deliverable is a field-by-field,
source-backed equivalence matrix using only preserved v22 source/receipts;
unknown fields must remain `unknown`, and no lane may infer Arm-B equivalence
or execute code. The CEO will reconcile those written responses into the next
decision amendment or the smallest further recovery task.

Review result: **BLOCK**. Planner and literature confirm historical v22
source/receipts preserve useful field accounting but cannot prove exact
PLAN-001 Arm-B equivalence. Critic found the manifest needed explicit
cycle/position, logits, state shape/dtype, per-record mask/position,
evaluator-command/dependency, and diagnostic-only exactness fields; those
repairs are now applied. Unknowns remain unknown and no execution is
authorized.

## Next Qwen improvement candidate

The lane audit found no immediately runnable Qwen improvement under complete
pinned identities. The strongest candidate is the existing v30 quantization
comparison because it changes only drafter export format and preserves a small
approximate Q8_0 signal. The CEO prepared
[QWEN-V30-QUANTIZATION-MANIFEST-20260821.md](QWEN-V30-QUANTIZATION-MANIFEST-20260821.md)
to inventory that evidence and its missing immutable rerun tuple. This keeps
the GPU objective moving without authorizing execution or promoting the prior
approximate result to an exact/speculative speed claim.

The executor is now assigned a read-only v30 provenance inventory on the
approved remote host: parent/candidate hashes, prompt manifest, evaluator and
dependency hashes, historical command/flags, target-only baseline, and
cleanup/device receipt. This is the smallest action toward a real Qwen GPU
improvement run; it is not execution authorization.

Executor checkpoint: remote SSH is reachable and idle; the v30 directory,
v27 parent, and 12-prompt contract have been found. Hashes, wrappers/flags,
evaluator/logger, baseline, and device receipts are now captured in the
terminal inventory receipt. No connection blocker or experiment action has
occurred.

PQ-002 notation repair: the manifest now defines `ell=FP32 log_softmax(z)`;
`L_ce` uses `ell`, `r=max(ell_true, log_epsilon)`, and the prose consistently
names log probabilities. The obsolete `log p`/`log ε` references are removed.
Critic and literature are performing the final gate review; no training or
validation occurred.

PQ-002 final math review: critic added
[`PQ-20260821-002-OBJECTIVE-FINAL-RECHECK-20260821.md`](../experiments/critique/PQ-20260821-002-OBJECTIVE-FINAL-RECHECK-20260821.md)
and returned **BLOCK** until `ell`, `log_epsilon`, and log-probability notation
were made consistent; planner applied that repair. Literature's
[`VERDICT-20260821-PQ002-OBJECTIVE-FINAL.md`](../literature/VERDICT-20260821-PQ002-OBJECTIVE-FINAL.md)
now returns **PASS for CEO consideration**, and critic's
[`PQ-20260821-002-OBJECTIVE-FINAL-VERDICT-20260821.md`](../experiments/critique/PQ-20260821-002-OBJECTIVE-FINAL-VERDICT-20260821.md)
returns **READY-NEEDS-APPROVAL**. The readiness packet itself still needs
planner reconciliation from stale BLOCK wording before CEO approval can be
considered; no training or validation occurred.

The inventory is now terminal and the named receipt schema has been created at
`receipts/EXP-20260821-004-v30-rerun-20260821/README.md`. Critic re-review is
requested for the final pre-run verdict; the schema remains documentation-only
until the CEO records a fresh approval.

## CEO approval — EXP-20260821-004-RERUN

Planner **PASS**, critic **READY-NEEDS-APPROVAL**, and literature **PASS with
caveat** were reconciled. The CEO approved exactly one bounded approximate
F16/Q4_K_M/Q8_0 rerun on one remote RTX 3060, one process, one hour maximum,
using existing artifacts, fixed 12 prompts/n=4/64-token greedy contract, one
warmup plus three timed repeats per arm, and a matched target-only baseline.
The handoff is governed by
[`CEO-DECISION-2026-08-21-QWEN-V30-RERUN.md`](CEO-DECISION-2026-08-21-QWEN-V30-RERUN.md).
Exactness remains diagnostic/failed; no Arm-B localization, lossless/general
speed claim, training, downloads, installs, patches, held-out access, or scope
expansion is authorized.

Executor acknowledgement received: the exact v30 scope, hashes, contract,
budget, hard stops, and receipt path were read and accepted. The remote
executor is now in the approved preflight/execution phase; the CEO is
monitoring the single GPU slot. No result is claimed until terminal receipts
arrive.

Preflight passed at 2026-08-21T11:51:56Z. The RTX 3060 is free, all approved
hashes and contract fields match, no competing compute process exists, and
disk headroom (3.6 GB free) was recorded as a resource risk but not a hard
stop. `environment.json` is written; the executor is proceeding sequentially
through the approved arms.

Execution milestone: the first launch attempt hit a shell path typo in the
Q8 artifact (`gamma8- ls002`), producing `command not found` before any
server/model/GPU process started. The executor recorded this as a
pre-execution launch error, corrected the path, and is retrying only the
already-approved sequence. No scope or approval change occurred.

Execution milestone: the matched target-only baseline completed successfully
(12 prompts, three timed repetitions plus warmup) with no output-accounting,
resource, or scope hard stop. The executor advanced to the frozen F16 arm;
per-arm receipts and cleanup remain pending, so no comparative result is yet
claimed.

Execution milestone: the frozen F16 arm completed with its warmup and three
timed repetitions, and the executor advanced to Q4_K_M. No hard stop or scope
change was reported; comparative interpretation awaits the complete receipt
set and terminal cleanup record.

Execution milestone: Q4_K_M completed with warmup and three timed
repetitions; the executor advanced to Q8_0. No output-accounting, resource, or
scope hard stop was reported. The run remains within the CEO-approved single
process boundary.

Execution milestone: Q8_0 completed with warmup and three timed repetitions;
the four arm JSON receipts (target-only baseline, F16, Q4_K_M, Q8_0) are now
present locally. The executor is assembling the pre-registered summary and
cleanup/terminal receipts; no new run is authorized.

Terminal milestone: EXP-20260821-004-RERUN completed within scope. Summary and
terminal receipts report target-only 17.375777 tok/s; F16 11.530593; Q4_K_M
11.574492; Q8_0 11.557184, each with 625 completion tokens per timed repeat.
All speculative forms matched target content on only 7/12 prompts per repeat;
F16/Q4/Q8 acceptance was 102/1971, 103/1967, and 102/1971 respectively.
Peak VRAM was 8085/8015/8033 MiB versus 6365 MiB target-only. These are
approximate diagnostic observations only: exactness is failed, and no
lossless, general quality, or general speed claim is supported. The initial
Q8 shell typo is preserved as a pre-execution error. Cleanup passed; final
RTX 3060 state is 1 MiB used, 0% utilization, no task process. Summary SHA:
`9cbed376175ecec5b76b77bc45c0cc53f3df3aca1af40ff87e22b467141765e4`;
terminal SHA after preserving `launch-error.log`:
`3e458c1476fd3a7376dbac270999926294a3cf43b67496350e3191b3de69db27`.
Post-run planner, critic, and literature reviews are assigned before terminal
disposition is finalized in the queue and CEO decision records.

Terminal reconciliation: executor reported `completed-negative`; cleanup
passed and the final GPU/process state is clean. Critic review
[`QWEN-V30-RERUN-POSTRUN-CRITIQUE-20260821.md`](../experiments/critique/QWEN-V30-RERUN-POSTRUN-CRITIQUE-20260821.md)
verified hashes, repetitions, output accounting, exactness boundary, and
terminal receipts. Planner marked the queue item completed-negative and
identified repair/retention of the blocked PLAN-001 evaluator/layout contract
as the next highest-information action. Literature added
[`HANDOFF-20260821-V30-RESULT.md`](../literature/HANDOFF-20260821-V30-RESULT.md)
mapping the result to QSpec and llama.cpp while preserving approximate-only
claims. Cleanup SHA is
`16082ca64a4ac0c1a3fd423471f15fcd7bbbc80dc0eb04386eeb8df0274be188`; the
updated terminal receipt preserves the launch-error log. No follow-up GPU run
is approved; the next action is a docs-only PLAN-001 contract repair/review.

Recovery assignment: the executor is now tasked with a read-only inventory of
preserved runtime/source/artifacts for the single PLAN-001 blocker: a complete
state-contract evaluator tuple plus exact target-only Arm-B
positions/mask/cache/anchor layout. It must hash every source/receipt, record
explicit evidence and unknowns without inference, and perform no model,
inference, evaluation, GPU, download, install, or patch action. Literature and
planner lanes are preparing admissibility/checklist reviews in parallel; critic
will re-review the resulting manifest before any CEO decision.

Executor recovery checkpoint: the read-only inventory terminalized at
[`evaluator-armb-layout-inventory-20260821.json`](../receipts/PLAN-20260821-001/evaluator-armb-layout-inventory-20260821.json),
SHA-256 `bb1d4a6dd6bf3567454992d526219fdb2b393c1084f33ab6afaacd1bf98c623e`.
It captures preserved runtime metadata (`n_max=7`, `block_size=8`, mask
`248070`, `n_extract=5`, `sample_from_anchor=true`, selector top-k 16, target
layers [6,20,34,48,62]) and historical block2/block7 evidence, but no complete
committed-prefix/proposed/target/correction/cache/mask/replay tuple. Exact
Arm-B mapping, serialized mask/cache schema, and a singleton memory-after
discrepancy ([171,171] versus [170,170]) remain unknown. No model, inference,
evaluation, or GPU action occurred; critic, planner, and literature review are
now required before a CEO gate decision.

Manifest-repair inputs received: planner supplied the full immutable checklist
(target/runtime/toolchain, frozen prompts/oracle, one evaluator/logger tuple,
Arm-A singleton, Arm-B width/positions/seq IDs/mask/cache/anchor mapping,
Arm-D rollback control, artifact hashes, and hard stops). Literature wrote
[`PLAN-20260821-001-MINIMAL-MANIFEST.md`](../literature/PLAN-20260821-001-MINIMAL-MANIFEST.md),
separating source requirements from concrete PLAN values and preserving
unknowns. The executor inventory is now terminal; planner, critic, and
literature all return **BLOCK** after review. The exact missing deliverable is
one immutable source-backed evaluator/layout manifest (or explicit unknowns
with hashes) binding the complete evaluator tuple and exact Arm-B
shape/mask/cache mapping. The `[171,171]` versus `[170,170]` memory-after
conflict remains unresolved. CEO keeps PLAN-001 blocked; no comparison, retry,
or new GPU execution is approved. Fresh lane review is required after any
future manifest amendment.
Written reviews: [planner verdict](../experiments/planning/PLAN-20260821-001-EVALUATOR-ARMB-INVENTORY-VERDICT-20260821.md),
[critic verdict](../experiments/critique/PLAN-20260821-001-EVALUATOR-ARMB-INVENTORY-CRITIQUE-20260821.md),
and [literature verdict](../literature/VERDICT-20260821-EVALUATOR-ARMB-INVENTORY.md).

Next-action assignment: because v30 is a completed-negative export-format
screen and PLAN-001 remains evidence-blocked, the CEO asked the three lanes to
audit the existing PQ-20260821-004 confidence-gated proposal-length screen.
Planner will produce its bounded packet or exact blocker list; critic will
review causal scope, adaptive-policy registration, baselines, exactness, and
receipts; literature will map the hypothesis to source evidence. This is a
documentation/readiness action only—no new hypothesis, GPU run, or approval is
implied.

PQ-004 readiness reconciliation: planner created
[`PQ-20260821-004-READINESS-20260821.md`](../experiments/planning/PQ-20260821-004-READINESS-20260821.md);
critic returned
[`PQ-20260821-004-CONFIDENCE-GATE-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-004-CONFIDENCE-GATE-CRITIQUE-20260821.md)
with **BLOCK**; literature returned
[`HANDOFF-20260821-PQ004.md`](../literature/HANDOFF-20260821-PQ004.md)
with a conditional high-information verdict. CEO decision
[`CEO-DECISION-2026-08-21-PQ004.md`](CEO-DECISION-2026-08-21-PQ004.md) is
**BLOCKED** on one immutable confidence score/threshold/implementation
manifest. No adaptive run is approved; planner owns the smallest repair and
the lanes must re-review it.

PQ-004 recovery assigned: planner will inventory preserved runtime/source
artifacts for an existing deterministic confidence score, threshold, and
`n∈{1,2,3,4}` selector implementation. It must either write an immutable
hashed policy manifest or record those fields unavailable; no constants may be
invented and no code/GPU action is allowed. Critic and literature will review
any manifest before the CEO considers approval.

Documentation verification checkpoint: touched governance/queue/literature/
planning/critique links pass; the PLAN inventory and v30 summary, cleanup, and
terminal JSON files parse successfully; `git diff --check` passes. Verified
hashes remain inventory `bb1d4a6d…`, v30 summary `9cbed376…`, cleanup
`16082ca6…`, terminal `3e458c14…`, and preserved launch error `c0523b5c…`.

PQ-004 final review: planner's policy inventory, critic's
[`PQ-20260821-004-FINAL-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-004-FINAL-CRITIQUE-20260821.md),
and literature's [`VERDICT-20260821-PQ004-POLICY.md`](../literature/VERDICT-20260821-PQ004-POLICY.md)
all leave the adaptive screen **BLOCKED**. Fixed v30 `n=4` evidence is valid,
but no confidence score/source, threshold/calibration, deterministic selector,
implementation hash, or scheduler-overhead accounting exists. CEO reaffirms
the single missing deliverable as an immutable policy artifact or a new
runtime-change card, followed by fresh lane review. No adaptive GPU run is
approved and the reserved receipt path remains untouched.

PQ-004 policy inventory checkpoint: planner wrote
[`PQ-20260821-004-POLICY-INVENTORY-20260821.md`](../experiments/planning/PQ-20260821-004-POLICY-INVENTORY-20260821.md)
and linked it from the readiness packet. Preserved runtime artifacts expose
only fixed `n=4` (`n_max=4`, `n_min=0`, `p_min=0`, block size 17,
`n_extract=1`, `sample_from_anchor=false`); no confidence statistic,
threshold/calibration, adaptive selector, EOS/tie/n=1 policy, implementation
hash, or scheduler-overhead accounting exists. The proposal remains BLOCKED;
critic and literature must now re-review this exact inventory. No constants,
runtime changes, or receipts were invented.

Additional recovery assignment: executor will perform one read-only inspection
of the pinned remote llama.cpp/DFlash source tree for an existing confidence-
or statistic-based adaptive draft-length selector. It must record exact paths,
commits, and hashes or explicit absence, without build/run/GPU/patch/download/
install actions and without populating the reserved experiment receipt path.

PQ-004 source-inspection checkpoint: executor wrote
[`runtime-confidence-adaptive-length-inventory-20260821.json`](../receipts/PQ-20260821-004-confidence-gated-20260821/runtime-confidence-adaptive-length-inventory-20260821.json),
SHA-256 `6ae1c6f74d0bc270f4f741dabea7c6adb8baad208fa0a9f31f9a19d5a1655726`.
Pinned DFlash2 uses fixed configured `n_max`/block size; no confidence- or
acceptance-statistic adaptive scheduler exists. `p_min` early-stop belongs to
other draft paths, DSpark has a separate confidence head, and ngram acceptance
stats do not change `n_max`. No build, run, patch, or GPU action occurred;
fresh planner, critic, and literature verdicts are required.

PQ-004 runtime-source verdicts are now complete: planner's
[`PQ-20260821-004-ADAPTIVE-INVENTORY-VERDICT-20260821.md`](../experiments/planning/PQ-20260821-004-ADAPTIVE-INVENTORY-VERDICT-20260821.md),
critic's [`PQ-20260821-004-RUNTIME-POLICY-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-004-RUNTIME-POLICY-CRITIQUE-20260821.md),
and literature's [`VERDICT-20260821-PQ004-RUNTIME-INVENTORY.md`](../literature/VERDICT-20260821-PQ004-RUNTIME-INVENTORY.md)
all return **BLOCK**. The pinned DFlash2 source has no adaptive selector;
other-path `p_min` and DSpark confidence are not admissible substitutions.
CEO records the precise external blocker: any DFlash2 adaptive scheduler is a
new runtime-change proposal requiring its own card and fresh lane review. No
adaptive run or runtime patch is approved.

Next planning action assigned: planner will determine whether a separate
bounded DFlash2 adaptive-scheduler runtime-change card can be specified from
current evidence. If it can, the card must freeze one causal change, policy,
invariants, controls, receipts, budget, and hard stops; if it cannot, planner
will record the exact reason. This remains documentation-only and does not
authorize implementation, patching, or GPU execution.

Planner's next-card audit is terminal in
[`PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821.md`](../experiments/planning/PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821.md): **BLOCK**. A new
DFlash2 adaptive-scheduler card cannot be specified without inventing the
score source, threshold/calibration, deterministic selector behavior,
implementation boundary/hash, and overhead contract. The note preserves the
minimum future-card contract (one selector change, frozen v30 identities,
cache/mask/position/sampler/correction invariants, controls, receipts,
one-GPU/30–60-minute budget, hard stops) but authorizes nothing. Critic and
literature are reviewing this blocker now.

Runtime-change blocker review is now complete: critic's
[`PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-CRITIQUE-20260821.md)
confirms **BLOCK**, and literature's
[`VERDICT-20260821-PQ004-RUNTIME-BLOCKER.md`](../literature/VERDICT-20260821-PQ004-RUNTIME-BLOCKER.md)
confirms that refusing to infer a DFlash2 selector is source-correct. The
smallest source-backed deliverable is a policy-spec manifest defining score,
threshold provenance, deterministic mapping/edge cases, implementation hash,
overhead, and unchanged target/cache/mask/position/sampler/correction/output
invariants. Until that artifact exists, no runtime card, patch, build, run, or
receipt is authorized.

Receipt-boundary correction: the PQ-004 directory now contains one explicitly
read-only source-inventory JSON. It contains no policy manifest, arm result,
summary, cleanup, or terminal execution receipt; the execution receipt path
remains closed pending approval.

Next Qwen candidate assignment: because PQ-004 cannot be specified without a
new runtime policy artifact, the CEO asked all three lanes to audit the
existing PQ-20260821-002 acceptance-calibrated objective proposal. Planner will
freeze or flag missing training/checkpoint/data/evaluator identities and current
baselines; critic will audit one-variable objective scope, leakage, exactness,
and receipts; literature will map the prefix-survival hypothesis to source
evidence. This is readiness work only and authorizes no training or GPU run.

Final verification checkpoint: all touched Markdown links across governance,
queue, planning, critique, and literature pass; all current JSON receipts parse;
`git diff --check` passes. The source-inspection receipt hash is
`6ae1c6f74d0bc270f4f741dabea7c6adb8baad208fa0a9f31f9a19d5a1655726`.

Program critique index updated with a pending-proposal row for PQ-004 linking
its planner, critic, and literature records. Link and whitespace verification
passes after this update; no execution authorization changed.

PQ-002 reconciliation: planner created
[`PQ-20260821-002-READINESS-20260821.md`](../experiments/planning/PQ-20260821-002-READINESS-20260821.md);
critic returned
[`PQ-20260821-002-READINESS-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-002-READINESS-CRITIQUE-20260821.md)
with **BLOCK**; literature returned
[`VERDICT-20260821-PQ002.md`](../literature/VERDICT-20260821-PQ002.md),
calling it bounded but lower information than PLAN-001 localization. CEO
decision [`CEO-DECISION-2026-08-21-PQ002.md`](CEO-DECISION-2026-08-21-PQ002.md)
records exact lineage, manifest, formula, selection, baseline, and cleanup
blockers. No training or GPU execution is approved; read-only provenance
recovery is the next action.

PQ-002 provenance checkpoint: executor wrote
[`v27-v23b-v23f-provenance-inventory-20260821.json`](../receipts/PQ-20260821-002-prefix-objective-20260821/v27-v23b-v23f-provenance-inventory-20260821.json),
SHA-256 `750d77097c08f65f71d765e85424a8fb517791c9ed49156e4c4095107bd10480`.
It captures v27 lineage/checkpoints, v23b/v23f manifests, trainer/config/
optimizer/seed, evaluator, and baseline hashes. Caveats remain explicit:
v23f optimizer/sampler state is not serialized and no aggregate feature-dir
hash exists; held-out files were not opened. No training, inference/eval, GPU,
download, install, or patch action occurred. Fresh lane review is required.

PQ-002 recovery assignment: executor will inspect preserved remote artifacts
read-only for the conflicting v27 lineage, v23b/v23f feature-label manifests,
training script/config/optimizer/seed, and baseline/evaluator receipts. It must
write exact hashes or explicit unknowns only; training, inference/evaluation,
GPU, download/install/patch, and held-out access are prohibited. Fresh planner,
critic, and literature review follow the inventory.

PQ-002 provenance review: planner's
[`PQ-20260821-002-PROVENANCE-VERDICT-20260821.md`](../experiments/planning/PQ-20260821-002-PROVENANCE-VERDICT-20260821.md)
substantially closes lineage/manifests/checkpoints/trainer/config/optimizer/
seed/evaluator/receipt provenance; critic's
[`PQ-20260821-002-PROVENANCE-RECHECK-20260821.md`](../experiments/critique/PQ-20260821-002-PROVENANCE-RECHECK-20260821.md)
still returns **BLOCK**; literature's
[`VERDICT-20260821-PQ002-PROVENANCE.md`](../literature/VERDICT-20260821-PQ002-PROVENANCE.md)
calls it provenance-complete but secondary to PLAN-001. Remaining hard gates
are the executable prefix-survival formula, checkpoint/multiplicity policy,
stale alternate lineage explanation, and training cleanup/terminal schema. No
training or GPU action occurred.

PQ-002 formula repair: planner created the complete proposed
[`PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md`](../experiments/planning/PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md).
It freezes logits/softmax, α=.02 label smoothing, valid/EOS masks, normalized
`w_t=m_t/t`, FP32 CE and prefix log-prob with ε=1e-8, λ=1.0, batch reduction,
BF16/FP32 gradients, no detach, selected lineage, deterministic checkpoints
800/1600/2400/3200/4000, tie/multiplicity, metrics, controls, stop rules, and
receipt path. It is explicitly proposed—not observed or approved—and preserves
feature aggregate/source-commit caveats. Critic and literature review are now
required.

PQ-002 objective review: literature returned
[`VERDICT-20260821-PQ002-OBJECTIVE-MANIFEST.md`](../literature/VERDICT-20260821-PQ002-OBJECTIVE-MANIFEST.md)
**PASS for CEO consideration, not approval**, separating source-consistent
controls from hypothesis-only `1/t`, λ=1, ε, and prefix-proxy choices. Critic's
[`PQ-20260821-002-OBJECTIVE-MANIFEST-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-002-OBJECTIVE-MANIFEST-CRITIQUE-20260821.md)
returns **BLOCK pending one math repair**: replace `exp(sum(log p))` then
`-log` with a stable direct cumulative-log-probability implementation and
finite checks. Planner is assigned that docs-only amendment; no training,
validation, or GPU action is authorized.

PQ-002 objective amendment: planner replaced the underflow-prone
`exp(sum(log p))` formulation with direct FP32 cumulative log-survival
`c_{i,k}=Σ m·r` and `L_prefix=(1/K)Σ m(-c)`, no exponentiation/products. It
froze FP32 log-softmax, cumulative sums, reductions, and finite checks for
logits, losses, and gradients; non-finite values are fit-gate failures. All
other scope, lineage, masks/EOS, selection, controls, and receipts remain
unchanged. Critic and literature re-review this amendment before any CEO
decision; no training occurred.

PQ-002 math text repair: planner removed the stale `p̂=max(p,ε)`/probability
path. The manifest now has one executable policy: FP32 `log_softmax`, direct
true-label log probability clamped only at `log_epsilon=log(1e-8)`, direct
cumulative log-survival, no probability tensor/exponentiation/product, BF16
model state, FP32 losses/reduction, and finite-gradient gates. Critic and
literature are performing final re-review; no training or GPU action occurred.

CEO approval checkpoint — 2026-08-21: planner readiness is
**READY-NEEDS-APPROVAL**, critic final verdict is **READY-NEEDS-APPROVAL**, and
literature final verdict is **PASS for CEO consideration**. I reconciled these
written inputs and approved exactly one bounded PQ-20260821-002 continuation:
one objective-only training epoch with step looks 800/1600/2400/3200/4000 and
validation at n=4/8/16 on the existing remote RTX 3060, one process, maximum
four GPU-hours. Target, parent/checkpoint, v23b/v23f manifests, trainer and
wrapper hashes, runtime/evaluator, seed, prompts, held-out boundary, controls,
stop rules, and receipt path are frozen in
[`CEO-DECISION-2026-08-21-PQ002.md`](CEO-DECISION-2026-08-21-PQ002.md). This
approval does not authorize exactness, quality, losslessness, general speed,
downloads, installs, patches, new trajectories, publication, spending, or
sealed-holdout access; scope changes require a new review and CEO decision.

Executor handoff — 2026-08-21: the existing remote executor was instructed to
read the CEO decision, queue card, objective manifest, and final lane verdicts,
then perform a read-only preflight before any fit. It may execute only the
approved one-process remote run, must capture every command/configuration,
identity, milestone, error, result, artifact hash/path, cleanup state, and
terminal GPU/process state under
`receipts/PQ-20260821-002-prefix-objective-20260821/`, and must stop on any
hash, objective, data, held-out, resource, evaluator, non-finite, gradient,
optimizer, or cleanup failure. GPU execution remains single-threaded; no
second run is authorized concurrently.

Implementation-identity blocker — 2026-08-21: executor read-only preflight
found that the pinned v23f/v27 trainer implements only the prior hard-label
position-weighted CE; it contains no FP32 cumulative-log prefix objective.
Fitting was not launched and the reserved run receipts remain empty. I asked
planner, critic, and literature for written scope decisions. Critic returned
[`PQ-20260821-002-IMPLEMENTATION-GATE-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-002-IMPLEMENTATION-GATE-CRITIQUE-20260821.md)
**BLOCK / CEO AMENDMENT REQUIRED**; literature returned
[`VERDICT-20260821-PQ002-EPHEMERAL-WRAPPER.md`](../literature/VERDICT-20260821-PQ002-EPHEMERAL-WRAPPER.md)
**conditionally admissible but blocked pending provenance and approval**.
The smallest repair is a new additive implementation manifest/card naming the
wrapper/patch path, exact bytes/hash, base trainer hash, interpreter and
dependencies, command/configuration, synthetic-logit and finite-gradient
gates, and proof that no model/data/optimizer/runtime/evaluator behavior
changes. No executor retry is authorized until planner and critic re-review
that amendment and the CEO records a fresh decision.

Portfolio-diversity directive — 2026-08-21: the CEO adopted a standing rule
to pursue diverse knowledge, not repeated parameter sweeps. Existing proposals
are organized by distinct causal axes: verifier/state fidelity, serving
economics, training objective, representation/state interface,
quantization/numerical path, drafter capacity, and evaluation/promotion.
Literature was asked to map one source-backed open question per axis; planner
was asked to add axis/information-gain/dependency tags to the existing queue
without inventing or approving a run; critic was asked to audit redundancy,
bundled confounds, and evidence-class duplication. These are documentation and
knowledge-exploration actions; they do not reopen the blocked PQ-002
implementation gate or authorize GPU execution.

PQ-002 blocked terminal reconciliation — 2026-08-21: executor wrote and
validated the read-only preflight receipts before stopping: `objective-manifest.json`
SHA `9e21e5410b075ecdcc21fe2a090a27aa4c5efa9ee7e2d031544d53387dd8686c`,
`environment.json` SHA
`6308794b86c6f570aca6cff0acc3151cf9a4c9b54212368daf8b1317b4a11212`,
`data-manifest.json` SHA
`6ce6ddbc460979bbc2669f26968d186254138c9b99cfbe1b9d64a0626008677d`,
`fit.json` SHA
`5d4a7f76394941ce0808781cb8106f2ccfbaa652177b092061e01d3ef80ce8c1`,
`validation.json` SHA
`bef6ed351947cb8f5393d257d47a6279b8afbb9378e6c8110d9d60b63f840988`,
`summary.json` SHA
`9781d557f3ef1f91d9b5e25cebb4447a4c54fce304c3e218097abde51f4b05b0`,
`cleanup.json` SHA
`a1706651c9b1a976cd4e99dbc4c75b07945efe8ba33ba6b716c4a1c09746db2a`, and
`terminal.json` SHA
`8d3c511f9db5c0ca070336d69db848f4c77bfdc924b2c53cb1bdc92bd1663948`.
Fit and validation are explicitly `not_started`; final GPU state is free and
no task process started. The only next execution authority is a fresh CEO
amendment after the implementation card and its critic/literature review pass.

Diversity checkpoint — 2026-08-21: literature delivered
[`PORTFOLIO-DIVERSITY-20260821.md`](../literature/PORTFOLIO-DIVERSITY-20260821.md),
mapping seven source-backed knowledge axes and one unanswered question per
axis. Planner annotated all five existing proposals by causal axis, expected
information gain, and dependency without creating or reprioritizing cards.
Critic delivered
[`PORTFOLIO-DIVERSITY-GATES-20260821.md`](../experiments/critique/PORTFOLIO-DIVERSITY-GATES-20260821.md),
which groups overlapping depth, objective, state-interface, serving, and
baseline families and requires six gates: one causal axis, distinct mechanism
and falsifier, metric contract, evidence-class separation,
selection/multiplicity, and lifecycle/provenance/safety. Portfolio diversity
is now a documented operating rule; no experiment or approval was added.

Implementation recovery assignment — 2026-08-21: executor was assigned one
read-only search of the approved remote project for an already-existing
implementation artifact of the frozen FP32 cumulative-log prefix objective
outside the inspected v23f/v27 trainer/wrapper tree. It must return exact
paths, bytes, SHA-256, source/tree, dependency/interpreter identity, or an
explicit no-artifact result. No code, build, model/GPU process, download,
install, patch, held-out access, or fitting is permitted. This is the smallest
recovery action before deciding whether a new implementation amendment is
unavoidable.

Implementation inventory result — 2026-08-21: executor completed the assigned
read-only search and found **no preserved implementation artifact** for the
full PQ-002 objective tuple. Receipt
[`objective-implementation-inventory-20260821.json`](../receipts/PQ-20260821-002-prefix-objective-20260821/objective-implementation-inventory-20260821.json)
has SHA-256
`c063fd2dd2738647748de1c74dd0c2c42773812e99ee0e39a23ea0cbeb715a38` and records
zero exact matches for `log_epsilon`, `L_prefix`, `prefix_loss`,
`cumulative-log`, or `prefix-survival`. The listed v31 KD/mixed-loss scripts
and pinned llama.cpp perplexity/sampler helpers are unrelated and cannot
substitute for the required FP32 direct cumulative-log, mask/EOS, finite-gate,
and `lambda=1` tuple. No GPU/model/build/run/held-out action occurred. PQ-002
remains `NEEDS-CEO-AMENDMENT`; planner, critic, and literature are assigned a
final disposition review before any new implementation proposal is considered.

No-artifact lane reconciliation — 2026-08-21: planner wrote
[`PQ-20260821-002-IMPLEMENTATION-INVENTORY-DISPOSITION-20260821.md`](../experiments/planning/PQ-20260821-002-IMPLEMENTATION-INVENTORY-DISPOSITION-20260821.md)
(SHA `727d5daf77c4f2853da3788b06747a618d063d8b14d5266e176f005cbd757121`),
verdict **DEFER**. Critic wrote
[`PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-INVENTORY-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-INVENTORY-CRITIQUE-20260821.md),
verdict **BLOCK**. Literature wrote
[`VERDICT-20260821-PQ002-IMPLEMENTATION-INVENTORY.md`](../literature/VERDICT-20260821-PQ002-IMPLEMENTATION-INVENTORY.md),
verdict **BLOCK fitting**. All three agree that no generic KD, CE,
perplexity, or sampler helper satisfies the full objective tuple. PQ-002 is
deferred pending a separately scoped implementation card, immutable artifact
and dependency hashes, synthetic smoke receipt, fresh critic review, and CEO
amendment; no wrapper substitution or fitting is admissible.

Next-portfolio ranking assignment — 2026-08-21: because PQ-002 is deferred
and PLAN-001 remains evaluator/layout-blocked, planner, critic, and literature
were asked to rank only the existing Qwen proposals for the next safe
documentation/read-only action. They must name one highest-information
unblock, its dependency and stop condition, and any redundant branch to defer;
no new experiment, code, GPU run, or approval is authorized by this assignment.

Next-action reconciliation — 2026-08-21: planner's
[`QWEN-NEXT-ACTION-RANKING-20260821.md`](../experiments/planning/QWEN-NEXT-ACTION-RANKING-20260821.md),
critic's [`QWEN-PROPOSAL-RANKING-20260821.md`](../experiments/critique/QWEN-PROPOSAL-RANKING-20260821.md),
and literature's [`RANK-20260821-QWEN-PROPOSALS.md`](../literature/RANK-20260821-QWEN-PROPOSALS.md)
agree: PLAN-001 verifier/state fidelity is the sole highest-information next
target; PQ-002 is deferred pending an implementation artifact and CEO
amendment; PQ-004 remains unexecutable without a DFlash2 selector policy; and
PQ-005 is downstream of reproducible shape/state evidence. The executor was
assigned a read-only PLAN-001 evaluator/Arm-B contract manifest using
preserved v20–v22/LIT-001 evidence. No Arm A/B/D run, inference, build, patch,
download, install, held-out access, or GPU process is authorized.

PLAN-001 reconciliation result — 2026-08-21: executor completed the assigned
read-only evaluator/Arm-B contract manifest. Receipt
[`evaluator-armb-contract-reconciliation-20260821.json`](../receipts/PLAN-20260821-001/evaluator-armb-contract-reconciliation-20260821.json)
SHA-256 `1d0dc945cc25b7dc8ac990b44cacfbfd0fe08ec023df2a2a66ce5b9fe8193d58`
lists every required field and preserves UNKNOWN for rendered/replay IDs,
committed/proposed/target/correction IDs, first divergence, sampler/RNG,
logit/state shape/dtype, serialized mask/cache, evaluator dependencies, exact
Arm-B width/positions/sequence IDs/state hashes, and anchor transition. It
explicitly preserves the source-versus-parsed memory-after discrepancy
`[171,171]` versus `[170,170]`. No execution or device action occurred; the
comparison gate remains blocked. Planner, critic, and literature are assigned
dated re-review before any queue or approval change.

PLAN-001 reconciliation review — 2026-08-21: literature wrote
[`VERDICT-20260821-PLAN001-RECONCILIATION.md`](../literature/VERDICT-20260821-PLAN001-RECONCILIATION.md),
verdict **BLOCK**; critic wrote
[`PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md`](../experiments/critique/PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821.md),
verdict **BLOCK**. Both confirm that the receipt is complete documentation
but does not bind the evaluator tuple, exact Arm-B layout/source tie,
serialized state, or the `[171,171]` versus `[170,170]` discrepancy. The
smallest next action is an approved source/introspection/evaluator-contract
task producing an immutable field-by-field manifest; no Arm A/B/D run or CEO
approval amendment is justified yet.

PLAN-001 recovery assignment — 2026-08-21: executor received the smallest
follow-up task: inspect only the cited preserved v20–v22 evaluator source/log
files and LIT-001 notes, extract mechanically evidenced tuple/layout fields
with file/line/hash references, and preserve explicit UNKNOWNs where evidence
is absent. It may not invoke, build, replay, infer, touch the GPU, or change
the `[171,171]` versus `[170,170]` discrepancy. A new CEO amendment remains
disallowed until this read-only extraction is reviewed.

Executor liveness correction — 2026-08-21: the open-ended extraction turn
produced no new receipt after repeated status checks, so the CEO interrupted
that idle turn and reissued a bounded task limited to the three cited source /
log files and LIT-001 note. The executor must return a compact JSON receipt or
explicit no-new-field result; no remote execution, GPU, build, inference, or
scope expansion is permitted.

Executor checkpoint correction — 2026-08-21: the reissued source/log turn
again produced no receipt, so the CEO interrupted it under the liveness rule
and reduced the task to local documentation only: write an explicit
no-new-evidence disposition referencing the last valid receipt
`1d0dc945cc25b7dc8ac990b44cacfbfd0fe08ec023df2a2a66ce5b9fe8193d58`, unchanged
UNKNOWN fields, the `[171,171]`/`[170,170]` discrepancy, and no-execution
state. No further remote search, GPU, inference, build, or comparison is
authorized in that handoff.

Recovery contract closure — 2026-08-21: the CEO created
[`PLAN-20260821-001-RECOVERY-PLAN.md`](PLAN-20260821-001-RECOVERY-PLAN.md),
which consolidates the authoritative receipts, exact unresolved evaluator and
Arm-B fields, the `[171,171]`/`[170,170]` discrepancy, the only admissible
read-only source/introspection task, and the re-entry gate. It grants no
runtime, GPU, inference, build, patch, held-out, or comparison authority.

Recovery-plan review assignment — 2026-08-21: literature will reconcile the
minimal-manifest note with the final no-new-evidence receipt; planner will
check queue/card linkage and re-entry gates; critic will adversarially review
the CEO recovery plan against provenance, diversity, and lifecycle rules. All
three are documentation-only and cannot promote PLAN-001 or authorize a run.

PLAN-001 bounded terminal disposition — 2026-08-21: executor wrote
[`final-bounded-disposition-20260821.json`](../receipts/PLAN-20260821-001/final-bounded-disposition-20260821.json)
SHA-256 `5b8ae5a154dcd0b39653177dc6734b9e2cdb0e166f54c2902c68873f0549a586`.
It is local documentation only, references the prior reconciliation receipt
`1d0dc945…`, preserves every evaluator/Arm-B UNKNOWN and the unresolved
`[171,171]` versus `[170,170]` discrepancy, and records no process/device/GPU
action. PLAN-001 remains blocked; the next safe action requires an explicitly
approved source/introspection/evaluator-contract amendment.

Recovery-plan gate repair — 2026-08-21: critic requested explicit machine-
visible fields; the CEO added `changed_variable: none`,
`family_id: verifier-state-interface`, `evidence_class: provenance/diagnostic`,
`selection: none`, a named terminal metadata receipt, and per-field source
path/line/JSON-key/bytes/SHA-256-or-UNKNOWN requirements. Historical values are
explicitly not treated as replicates. Planner's documentation review is PASS;
PLAN-001 remains `BLOCKED-PREFLIGHT`.

Approval-language audit and diversity continuation — 2026-08-21: the CEO
audited `queue/`, `experiments/planning/`, and governance for historical
legacy conservative approval wording versus current CEO-only bounded approval
wording. No historical decision was rewritten: queue proposals remain non-authorizing, while
the current delegated policy in `governance/ORCHESTRATION.md` and
`queue/INDEX.md` is authoritative for new decisions; actions outside the
bounded repository/GPU policy remain `SEPARATE USER APPROVAL REQUIRED`.
To keep the program active while PLAN-001 is blocked, the CEO assigned four
parallel documentation-only lanes: literature must derive distinct
source-backed alternative hypotheses and claim-to-test links; planning must
produce a cross-axis decision/retirement matrix; critique must adversarially
audit mechanism duplication and evidence leakage; and the executor must run a
local-only queue/card/receipt link and stale-state audit. None may create,
approve, launch, or mutate an experiment, use the GPU, connect remotely, or
change the current queue statuses. The next checkpoint is to reconcile their
written paths/hashes and record the smallest recovery action.

Diversity/knowledge checkpoint — 2026-08-21: literature delivered
[`KNOWLEDGE-EXPLORATION-20260821-ALTERNATIVES.md`](../literature/KNOWLEDGE-EXPLORATION-20260821-ALTERNATIVES.md), SHA-256
`8c4a1d36ff9d2034e3edbbdfa2ae20b09beb7defa85826ce2c8b4249da0f89fc`.
It records three distinct source-backed hypotheses—stale correction/rollback
state, launch/cache/scheduler overhead, and feature geometry/projection
mismatch—with observables, falsifiers, and required receipt identities. The
planner delivered
[`QWEN-PORTFOLIO-COVERAGE-DECISION-MATRIX-20260821.md`](../experiments/planning/QWEN-PORTFOLIO-COVERAGE-DECISION-MATRIX-20260821.md), SHA-256
`4fb43e918ffdaa2eb2d3e07e06bcf2b8bd7f5b1a7b9ab42b59ede234674b152a`,
covering discriminating evidence and stop/retire conditions for all five
existing proposals. The critic delivered
[`PORTFOLIO-CONFOUND-EVIDENCE-LEAKAGE-20260821.md`](../experiments/critique/PORTFOLIO-CONFOUND-EVIDENCE-LEAKAGE-20260821.md), SHA-256
`d7960f617a2dda54a060a5666625214ca2e28badbd1fbb072b8e6fbf03add98e`,
verdict **BLOCKED for cross-proposal inference** and preserving the
PLAN-001 read-only contract manifest as the shared dependency. These are
documentation/knowledge outputs only; queue statuses, approvals, and receipt
paths remain unchanged. The executor's local provenance/link audit remains
the final assigned checkpoint; no remote or GPU action is permitted.

Executor audit checkpoint — 2026-08-21: executor completed the assigned
local-only PLAN-001 provenance/link audit and wrote
[`provenance-link-audit-20260821.json`](../receipts/PLAN-20260821-001/provenance-link-audit-20260821.json),
SHA-256 `32a12d24959190b21f171c2730517c314848fc28572c55bbcf013fc567ecbb21`.
All 31 selected local links resolved with no broken paths. The receipt
preserves the stale historical `ready-needs-approval` critic recheck, the
superseded dated approval amendment, the distinct local-GPU-unknown versus
remote-free-GPU contexts, and matching reconciliation/final-disposition
hashes. The CEO added a control-plane supersession note to the critique index:
PLAN-001 remains `BLOCKED-PREFLIGHT`, and no remote, GPU, build, inference, or
experiment action occurred.

Current CEO decision after this checkpoint: retain all five existing proposal
statuses and approval boundaries; treat the new literature, planner, critic,
and executor artifacts as knowledge/provenance only. The next useful action
is a fresh source-backed PLAN-001 contract-manifest amendment only if an
authorized evidence source can bind the missing evaluator tuple, exact Arm-B
layout, and memory-after discrepancy. Until then, downstream objective,
scheduler, consistency, and capacity branches remain separate, conditional,
or deferred rather than being silently substituted for that uncertainty.

Approval vocabulary correction — 2026-08-21: per the user's explicit
instruction, the repository no longer uses the old approval label. Active
queue, planner, critique, and orchestration records now use `CEO DECISION
REQUIRED` for a non-authorizing proposal and `CEO APPROVED (bounded scope)`
only for a dated CEO decision. Historical records were reworded to describe
their legacy conservative approval state without changing their evidence,
outcomes, or scope. Actions outside the delegated bounded policy remain
`SEPARATE USER APPROVAL REQUIRED`.
