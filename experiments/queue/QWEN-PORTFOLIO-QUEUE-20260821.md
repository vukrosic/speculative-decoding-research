---
id: QWEN-PORTFOLIO-QUEUE-20260821
date: 2026-08-21
status: queue-only
source: ../planning/QWEN-PORTFOLIO-PLANNER-PACKET-20260821.md
---

# Qwen portfolio queue index (additive)

This file is a compact handoff to the planner/critic/literature/executor
lanes. It preserves the existing queue and adds no approval or run.

| Order | Existing item | Readiness | Next gate | Evidence class |
|---:|---|---|---|---|
| 1 | `PLAN-20260821-001` verifier/state localizer | TERMINAL-BLOCKED — BUNDLE NOT FOUND | Reopen only with the exact deployment bundle or a separately authorized regeneration; preserve UNKNOWN/CONFLICT fields | Runtime diagnostic; exactness/state localization |
| 2 | `PQ-20260821-002` prefix-survival objective | COMPLETED-NEGATIVE | Standalone smoke and full fit completed, but best n=4 acceptance `0.199605` was below `0.201980`; preserve the implementation/fit/negative screen and do not repeat blindly | Training objective; acceptance negative |
| 3 | `PQ-20260821-004` adaptive proposal length | BLOCKED | Supply source-backed confidence statistic, selector policy, threshold, tie/EOS/NaN rules, and overhead instrumentation | Runtime scheduling; end-to-end speed |
| 4 | `PQ-20260821-005` paired state consistency | DEFERRED | Recover paired v31 manifests, coefficient, and source-disjoint data/fit gate | Training/interface; acceptance and speed |
| 5 | `PQ-20260821-006` fixed Q8_0 draft length | COMPLETED-NEGATIVE | n=1/2/3/4 and target-only were measured under the frozen 12-prompt contract; n=1 was fastest draft arm (~16.01 tok/s) but target-only remained faster (~17.35 tok/s), while n=2 had the highest accepted/cycle (0.20958) | Runtime scheduling; acceptance/overhead/speed |
| 6 | `PQ-20260821-007` staged Qwen on-policy data scale | TERMINAL-NEGATIVE | Augmentation fit + n=4 screen failed strict acceptance promotion (0.176699 vs 0.20198 baseline); preserve metrics and stop blind data scaling | Data coverage; acceptance negative |
| 7 | `PQ-20260821-008` verifier/state localization | TERMINAL-BLOCKED — BUNDLE NOT FOUND | Final scoped lookup receipt `f470e615...` found no exact PLAN-001 deployment bundle; five rendered hashes, replay/logger/dependency identities, exact Arm-B serialization/device split, and `[171,171]` vs `[170,170]` remain UNKNOWN/CONFLICT | Verifier/state provenance blocker |
| 7 | `PQ-20260821-008` verifier/state localization | RECOVERY EXTERNAL TO PLANNER | Reopen only when missing exact artifacts are supplied or a separately authorized regeneration task exists. No further search/runtime/GPU in this packet | Contract closure before runtime diagnosis |
| 8 | `PQ-20260821-009` Q4_K_M vs Q8_0 precision at fixed n=1 | COMPLETED-NEGATIVE | Merged into EXP-011; Q4/Q8 were near-tied at n=1 and both below target-only; preserve result and do not repeat blindly | Runtime precision; negative speed/quality trade-off |
| 9 | `EXP-20260821-011` Q4_K_M vs Q8_0 precision at fixed n=1 | TERMINAL-NEGATIVE / PRECISION-AXIS-RETIRED | Three repetitions per target-only/Q4/Q8 arm completed: Q4 16.092300 tok/s, Q8 16.087803 tok/s, identical 98/508 acceptance; both below target-only 17.402501 tok/s. Preserve receipts and do not repeat this precision screen; see result reconciliation note | Runtime precision; n=1 speed frontier (negative) |
| 10 | `PQ-20260821-012` runtime-overhead decomposition at fixed Q8 n=1 | READ-ONLY MEASUREMENT-GAP / NO RUN | Existing EXP011 counters were analyzed locally; per-component draft/target/cache/scheduler timing and exactness/argv fields are absent, so no causal overhead claim or new GPU run is justified | Runtime overhead; measurement-gap negative |
| 11 | `PQ-20260821-013` prompt/category-gated mixed mode | TERMINAL-BLOCKED | EXP011 category variation is hypothesis evidence only. Missing source-backed per-request mixed-mode launcher and source-disjoint calibration/held-out manifest; no overfit policy can be selected from the 12 prompts | Scheduling policy; acceptance/speed/exactness |
| 12 | `PQ-20260821-014` next Qwen candidate audit | TERMINAL-MEASUREMENT-GAP | PQ-002 is terminal-negative; PQ-004/005/008/012/013 lack required source-backed identities or artifacts. No executable acceptance/speed candidate remains; preserve negatives and await exact recovery input | Program-level queue disposition |
| 13 | `PQ-20260821-015` post-PQ014 recovery options A/B | TERMINAL-NO-GPU-CANDIDATE | A is CPU-only descriptive counterfactual (no held-out policy claim); B lacks source-backed cache flag/launcher and repeated-prefix manifest. Choose neither for GPU; see comparison packet | Recovery/measurement boundaries |
| 14 | `PQ-20260821-019` prompt-cache-on runtime at fixed Q4 n=1 | TERMINAL-COMPLETED — NARROW CACHE RESULT | Target-only 16.089540→17.880100 (+11.13%); Q4 18.163882→21.763139 (+19.82%); positive cache_n, unchanged Q4 208/236 acceptance. Rendered/token-prefix hashes and exactness UNKNOWN; see post-run reconciliation | Prompt-cache behavior; local throughput diagnostic |
| 14 | `PQ-20260821-016` exact artifact-recovery intake | WAITING-EXTERNAL-INPUT | Supply one authoritative PLAN-001 bundle, source-backed mixed-mode selector, or repeated-prefix cache bundle; no guessed substitute or run | Program recovery boundary |
| 15 | `PQ-20260822` post-PQ019 executable-candidate audit | TERMINAL-NO-NEW-GPU-CANDIDATE | Read-only output/evaluator reconciliation completed; exact PLAN-001 Arm-B serialization/source tie, logger/replay/dependency tuple, explicit split, and memory conflict remain unresolved. Reopen only with one exact source-backed artifact | Program-level measurement boundary |

**Best next information action:** preserve PQ-019 as a completed narrow cache
diagnostic and return to verifier/state localization or a source-backed runtime
counter recovery. Do not run another cache sweep from the same workload. The
observed cache effect is not a speculative acceptance or general speed result.
PQ-002, PQ-007, PQ-008, PQ-012, PQ-013, PQ-014, and PQ-015 remain preserved as
negative/blocked evidence rather than promotion candidates.

The completed remaining-field manifest did not close those gates. The final
scoped lookup is a no-found terminal blocker (receipt `f470e615...`), so the
smallest next action is external: supply the exact missing deployment bundle
or create a separately authorized regeneration task. Generic v22 fixtures
must not be substituted.

EXP011's terminal result is recorded in
[`EXP-20260821-011-RESULT-RECONCILIATION-NEXT-20260821`](../planning/EXP-20260821-011-RESULT-RECONCILIATION-NEXT-20260821.md).
The fixed-`n=1` precision axis is retired as the next primary hypothesis:
Q4_K_M and Q8_0 had identical observed acceptance and near-tied throughput,
and neither beat target-only. Target-content and exactness remain UNKNOWN.

The next independent runtime proposal was
[`PQ-20260821-012-RUNTIME-OVERHEAD-DECOMPOSITION-N1-20260821`](../planning/PQ-20260821-012-RUNTIME-OVERHEAD-DECOMPOSITION-N1-20260821.md).
Its target-only versus frozen Q8 n=1 counters are now preserved as a
read-only measurement-gap result in
`receipts/PQ-20260821-012-runtime-overhead-decomposition-n1-20260821/`.
The required per-component counters and exactness/argv fields are absent; no
runtime patch, inferred overhead, or new GPU run is admissible.

Each item remains one-causal-change only. Acceptance, target-content, exactness,
and end-to-end throughput must be recorded as separate metrics; approximate
timing cannot be promoted to a speed claim when strict identity or the target
contract is unresolved.

PQ-002 acceptance is terminal-negative at the n=4 gate: best step 1600
reached `0.19960 accepted/cycle`, below the registered `0.20198` baseline.
The next bounded runtime action is the Q8_0 fixed-`n` screen in
[`PQ-20260821-006-FIXED-N-RUNTIME-SCREEN-20260821`](../planning/PQ-20260821-006-FIXED-N-RUNTIME-SCREEN-20260821.md).

The next training/data hypothesis is staged on-policy expansion in
[`PQ-20260821-007-QWEN-DATA-SCALE-ONPOLICY-20260821`](../planning/PQ-20260821-007-QWEN-DATA-SCALE-ONPOLICY-20260821.md): 100k windows first, then
500k only after a strict n=4 acceptance gate. It freezes the model, objective,
runtime, evaluator, validation, and sealed holdout; no extraction or training
is authorized by the queue entry.

Because only ~2.2 GB remains on the remote filesystem, the immediate bounded
subtask is the 2,000-window streaming correctness pilot in
[`PQ-20260821-007-STREAMING-STAGEA-PILOT-20260821`](../planning/PQ-20260821-007-STREAMING-STAGEA-PILOT-20260821.md).
It is blocked until a hash-pinned streaming launcher proves one-pass optimizer
continuity against a complete-2,000 control; no delete-after-read or guessed
command is allowed.

The completed response/window receipts also support a distinct materialized
2,000-window candidate in [`PQ-20260821-007-MATERIALIZED-2000-WINDOW-PILOT-20260821`](../planning/PQ-20260821-007-MATERIALIZED-2000-WINDOW-PILOT-20260821.md).
It remains planner-only: the expected ~0.7-GB feature shard must coexist with
the current ~2.322-GB free volume, and the frozen extractor's reserve check
and merged-manifest interface are hard gates. The streaming blocker and its
negative storage evidence remain preserved.

The smallest documented recovery for the extractor guard is the one-variable
environment amendment in [`PQ-20260821-007-EXTRACTOR-GUARD-RECOVERY-20260821`](../planning/PQ-20260821-007-EXTRACTOR-GUARD-RECOVERY-20260821.md):
strict `V23_MIN_FREE_BYTES`, default 8 GiB, with no schema/model/argv change,
default/1-GiB no-model smokes, and sequential groups 000–003 under an external
1-GiB pre/post stop. It is a conditional implementation packet, not a run.

Because the original compile/link argv is unavailable, the additive-build
framing and observed NEEDED-order decision are recorded in
[`PQ-20260821-007-ADDITIVE-EXTRACTOR-BUILD-PACKET-20260821`](../planning/PQ-20260821-007-ADDITIVE-EXTRACTOR-BUILD-PACKET-20260821.md).
CEO consideration is limited to the task-owned build and no-model smokes;
group extraction remains a separate post-smoke decision.

The C++17 compile blocker and the narrowly scoped C++20-only decision are
recorded in [`PQ-20260821-007-ADDITIVE-BUILD-CPP20-DECISION-20260821`](../planning/PQ-20260821-007-ADDITIVE-BUILD-CPP20-DECISION-20260821.md).

The subsequent extraction-only boundary for groups 000–003 is captured in
[`PQ-20260821-007-EXTRACTION-ONLY-CPP20-DECISION-20260821`](../planning/PQ-20260821-007-EXTRACTION-ONLY-CPP20-DECISION-20260821.md).
Final C++20 build/ABI/guard receipts now exist and critic PASS is recorded;
the historical packet's handoff state is preserved; subsequent extraction
receipts completed the groups, while fit/export/deletion remain separately
scoped.

The workspace storage shortfall and neutral tmpfs alternative are documented
in [`PQ-20260821-007-EXTRACTION-SHM-RESOURCE-AMENDMENT-20260821`](../planning/PQ-20260821-007-EXTRACTION-SHM-RESOURCE-AMENDMENT-20260821.md).
It requires a live `/dev/shm` capacity/ownership check and preserves all
feature semantics and extraction-only limits.

Per-group extraction receipts now reconcile in
[`PQ-20260821-007-EXTRACTION-RECONCILIATION-20260821`](../planning/PQ-20260821-007-EXTRACTION-RECONCILIATION-20260821.md): 790/616/549/45 windows all
validated under `/dev/shm`, with no workspace copy or training. A conflicting
workspace hard-stop receipt is preserved; the next decision is a separate
training-readiness review or terminal stop, not automatic fitting.

The authoritative training-readiness disposition is blocked pending the
combined-view/label-alignment preflight in
[`PQ-20260821-007-TRAINING-READINESS-AUTHORITATIVE-20260821`](../planning/PQ-20260821-007-TRAINING-READINESS-AUTHORITATIVE-20260821.md).
No symlinks, label manifest, or fit were launched by that packet.

That preflight has now recorded a duplicate `v23-quality-window-00087`; the
queue is hard-stopped pending the read-only collision audit in
[`PQ-20260821-007-COLLISION-AUDIT-20260821`](../planning/PQ-20260821-007-COLLISION-AUDIT-20260821.md).
No label rewrite or fit is allowed until the collision is classified.

The collision was re-keyed in a derived label artifact, and the corrected
count contract is recorded in
[`PQ-20260821-007-COUNT-CONTRACT-RECONCILIATION-20260821`](../planning/PQ-20260821-007-COUNT-CONTRACT-RECONCILIATION-20260821.md): 12,452 total = 11,944
train + 508 validation. The prior 11,944-total expression remains preserved as
a negative receipt; no fit is launched from the count correction.

The corrected fit has now completed teacher-forced validation only; see
[`PQ-20260821-007-FIT-RECONCILIATION-ACCEPTANCE-DECISION-20260821`](../planning/PQ-20260821-007-FIT-RECONCILIATION-ACCEPTANCE-DECISION-20260821.md).
Checkpoint SHA and loss/accuracy metrics are recorded, while acceptance is the
next separate gate. The later acceptance receipt records an export SHA, which
is preserved as observed evidence; serving remains unlaunched.

The acceptance gate is now terminal-negative and reconciled in
[`PQ-20260821-007-TERMINAL-NEGATIVE-NEXT-PORTFOLIO-20260821`](../planning/PQ-20260821-007-TERMINAL-NEGATIVE-NEXT-PORTFOLIO-20260821.md): 0.176699 accepted/cycle
versus 0.20198 baseline, with target-content/exactness UNKNOWN. PQ-006 is now
complete-negative; no further fixed-`n` sweep or blind data scaling is queued.

PQ-008 remains a preserved diagnostic design in
[`PQ-20260821-008-VERIFIER-STATE-LOCALIZATION-PACKET-20260821`](../planning/PQ-20260821-008-VERIFIER-STATE-LOCALIZATION-PACKET-20260821.md).
It must not run unless the evaluator/state contract is later bound
field-by-field from an authoritative artifact bundle;
the packet specifies singleton, deployment-shaped block, and rollback controls
with separate state, token, acceptance, exactness, and timing fields.

The first unblock attempt is now complete as a read-only preserved-metadata
reconciliation in
[`preserved-metadata-reconciliation-20260821.json`](../../receipts/PLAN-20260821-001/preserved-metadata-reconciliation-20260821.json),
SHA `7728d50a09c740f49fb294e65f4bb8a9b16a6346cd2a65f54ceedcfc1d038b0e`.
It confirms prompt IDs/order and partial environment facts but leaves the
complete tuple, exact Arm-B mapping, and memory-after conflict unresolved, so
the queue remains no-run for PQ-008.

The next docs-only recovery is the field-by-field source/receipt introspection
packet [`PQ-20260821-008-METADATA-RECOVERY-PACKET-20260821`](../planning/PQ-20260821-008-METADATA-RECOVERY-PACKET-20260821.md).
It writes one immutable JSON receipt, preserves UNKNOWN/CONFLICT states, and
does not authorize runtime or GPU work.

The resulting source-backed receipt (`e7b89caad1247ada29af43f62b7eba192970ac2e22ce7c2732d428c99491627e`) confirms historical fixtures but not exact PLAN-001 Arm-B equivalence. The final scoped lookup (`f470e615...`) found no deployment bundle, so queue status is terminal-blocked; reopening requires external artifact supply or a separately authorized regeneration task, with no Arm A/B/D runtime authorization.

PQ-013 is terminal-blocked: the current per-prompt receipts cannot support an
unbiased selector, and the existing client does not establish per-request
mixed-mode dispatch. Reopen only after both source-backed artifacts and hashes
are supplied; do not fit a threshold on EXP011's 12 prompts.

The additive queue audit
[`PQ-20260821-014-NO-EXECUTABLE-QWEN-CANDIDATE-20260821`](../planning/PQ-20260821-014-NO-EXECUTABLE-QWEN-CANDIDATE-20260821.md)
records a terminal measurement gap: no source-backed executable
acceptance/speed hypothesis remains without inventing a selector, launcher,
deployment bundle, or new data/precision sweep.

The A/B recovery comparison in
[`PQ-20260821-015-RECOVERY-OPTIONS-20260821`](../planning/PQ-20260821-015-RECOVERY-OPTIONS-20260821.md)
chooses neither for GPU execution. Option A is CPU-only descriptive analysis;
Option B remains closed pending source-backed cache artifacts.

PQ-019 superseded that earlier cache blocker: v21 runtime/client inspection
supplied the flag semantics and request-level `cache_prompt` control, and the
registered repeated-prefix workload then completed once. Its bounded packet is
[`PQ-20260821-019-CACHE-ON-N1-RUNTIME-PACKET-20260822`](../planning/PQ-20260821-019-CACHE-ON-N1-RUNTIME-PACKET-20260822.md).
The final result is documented in the [experiment card](../cards/EXP-20260822-019-qwen-prompt-cache-reuse.md)
and [post-run analysis](../../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md):
positive local prompt-cache effect, unchanged Q4 acceptance, and no general
speculative-decoding speed claim.

The current recovery intake is
[`PQ-20260821-016-ARTIFACT-RECOVERY-INTAKE-20260821`](../planning/PQ-20260821-016-ARTIFACT-RECOVERY-INTAKE-20260821.md),
which lists the exact authoritative inputs needed to reopen one of these
families. No GPU/run approval is implied by the intake.

PQ-019 contract route is now Q4-bound: v21 source hash `4be899...` already
matches Q4 metadata (`18a380...`). Target/Q4 cache-off use it directly; only
the Q4 cache-on contract is derived by `prompt_cache false→true`. No Q8
contract derivation is in scope.

The smallest source-backed repeated workload is now specified in
[`PQ-20260821-019-REPEATED-PREFIX-MANIFEST-20260822`](../planning/PQ-20260821-019-REPEATED-PREFIX-MANIFEST-20260822.md): concatenate the canonical six-prompt v20 public manifest to 12 ordered rows, require duplicate-ID sequence preservation, and expect cache-on hits only on the second pass. The earlier 12→24 v23 derivation is superseded. A single RTX 3060 run is admissible for CEO consideration only after read-only schema/hash and resource preflight; no run is launched by this manifest.

The assigned post-run recovery is now also complete as a read-only pass:
[`pq008-local-output-evaluator-reconciliation-20260822.json`](../../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json)
(SHA `945548c5…`). It closes oracle/evaluator totals and historical Arm-B
metadata but leaves the exact deployment serialization/source tie, complete
logger/replay/dependency identity, explicit split, and memory conflict
unresolved. Therefore the queue remains `TERMINAL-NO-NEW-GPU-CANDIDATE`; the
next gate is external artifact supply or separately authorized regeneration,
not another Qwen screen.

## Post-EXP020 planner reconciliation — 2026-08-22

The independent-v23 screen for EXP-20260822-020 is terminal-negative for the
low-margin correction policy: the six-prompt calibrated speed result (+12.50%)
did not generalize (6/12 v23 output hashes matched). PQ-019 remains a narrow
positive cache observation with unchanged acceptance, not a general speed
promotion. These results retire further threshold, precision, depth, blind
data-scale, and cache repeats as next actions.

The additive planner decision is
[`PQ-20260822-POST-EXP020-NEXT-ACTION-20260822`](../planning/PQ-20260822-POST-EXP020-NEXT-ACTION-20260822.md): obtain the missing authoritative
Arm-B contract bundle read-only first. Until all source/build/evaluator/state
identities are bound, the queue remains
`TERMINAL-NO-ADMISSIBLE-NEW-GPU-ACTION`; no GPU run is queued. A conditional
PQ-008 state-localization diagnostic is the only ranked GPU follow-up after
that recovery gate passes.

## Explicit EXP020/PQ019 queue reconciliation — 2026-08-22

The independent-v23 receipt makes the EXP020 boundary explicit: target-only
matched all 12/12 output hashes (625 tokens), while frozen corrected Q4 matched
6/12, produced no override events, and measured 19.954249 versus 17.659459
diagnostic tok/s (+12.994677%). This is a terminal negative for policy
generalization; the six-prompt calibrated +12.496004% result remains local and
does not authorize retuning, prompt exceptions, or another threshold run. See
the [analysis](../analysis/PQ-20260822-020-INDEPENDENT-V23-SCREEN.md) and
[raw summary](../../receipts/EXP-20260822-020-qwen-singleton-correction/independent-v23-screen-r1/raw-remote/summary.json),
SHA `bb65c097f20f36f063f46ca3f3730a229f4a954decc43705b05b9d0b8dbd97c8`.

PQ019 remains a separate narrow cache-positive result: target-only improved
16.089540→17.880100 tok/s (+11.13%) and Q4 n=1 improved
18.163882→21.763139 (+19.82%) with unchanged 208/236 acceptance. Its rendered
and token-prefix hashes remain UNKNOWN, so it is not a general speculative
decoding speed or exactness promotion; see the [card](../cards/EXP-20260822-019-qwen-prompt-cache-reuse.md)
and [post-run receipt](../../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md).

Next action remains exact source-backed PLAN-001/PQ008 verifier/state/evaluator
artifact recovery (or separately authorized regeneration). No blind cache
repeat, threshold retune, prompt exception, or new GPU run is queued.

Runtime lane has since supplied a distinct source-backed measurement candidate:
[`runtime-qwen-exp020-phase-decomposition-recovery-20260822`](../planning/runtime-qwen-exp020-phase-decomposition-recovery-20260822.md).
It replays one matched target-only public prompt through the existing EXP020
instrumented binary/source and compares draft, verification, rollback, memory,
and scheduler intervals with the preserved Q4 trace. Planner disposition is
`PASS-NEEDS-CEO-APPROVAL`, but its target-only comparator is currently blocked
by a library identity mismatch (`65b8a862` current versus `d07ed8b4` in the Q4
trace). The smallest repair is the task-owned rebuild amendment in the packet:
stage preserved `sampling.cpp` (`66b7975d`), rebuild with recorded UI-off flags,
verify `d07ed8b4`, run no model during build, capture the target trace, then
restore and verify `65b8a862`. One GPU process, no semantic/runtime change,
strict source/build/library/output/event/resource/cleanup gates, and no speed
or exactness promotion claim. Until CEO approval and all identity gates pass,
the queue remains blocked; all improvement experiments remain blocked pending
the Arm-B contract recovery.

## EXP020 library-identity recovery receipt — 2026-08-22

The approved target-only phase diagnostic hard-stopped before model load:
expected `libllama_common` `d07ed8b4c22e…` versus observed current
`65b8a862607e…`; server and implementation hashes matched. This is a
provenance/build gate, not a numeric result. Continue only with the pinned
UI-off no-model rebuild, exact byte verification, trace-only target control,
and restore/verification of the current library. No retuning, held-out use,
code change, or new speed claim is queued. See the benchmark contract and
hard-stop receipts under `receipts/EXP-20260822-020-qwen-singleton-correction/`.

Final recovery outcome: rebuilt `libllama_common` `1bbaf7b5…` failed the
required `d07ed8b4…` identity gate before model/GPU load. Source `c1b1f6f0…`
and current library `65b8a862…` were restored and verified; server/impl hashes
stayed intact, no processes remained, and no phase trace is available. Keep
the EXP020 independent-v23 6/12 negative and PQ019 cache-positive result as
bounded evidence; no new run or general claim is queued.

## Candidate review disposition — same-library phase trace

Planner PASS leaves one CEO-approval-gated measurement candidate:
`experiments/planning/runtime-qwen-exp020-current-library-phase-trace-20260822.md`.
It compares target-only and Q4 n=1 phase/state intervals through restored
library `65b8a862…`, with margin override disabled and frozen inputs. It has not
run and cannot promote speed, exactness, or verifier correctness. All other
source-level improvement candidates remain blocked.

## EXP021 v22 build checkpoint

Observed hard stops: malformed historical patch reconstructed as candidate-only
diff; first `/dev/shm` build stopped at 8% on UI download/noexec; UI-OFF/OFF
retry stopped at 38% because `LLAMA_BUILD_APP=ON` still invoked missing UI
assets. The source-backed preseed recipe/frozen six-prompt manifest is pending;
fresh `/workspace` preseed build is around 25%. No model/GPU inference,
exactness, timing, or promotion result exists.
The exact-d07 phase trace recovery is terminal-blocked, but a same-library
measurement variant is now source-backed: use the current instrumented server
and `65b8a862...` for both target-only and Q4 n=1, with `PQ020_LOW_MARGIN_TOP2`
unset. The packet
[`runtime-qwen-exp020-current-library-phase-trace-20260822`](../planning/runtime-qwen-exp020-current-library-phase-trace-20260822.md)
is `PASS-NEEDS-CEO-APPROVAL`, one process per arm, no semantic change, strict
hash/output/event/resource/cleanup gates, and measurement-only interpretation.
It may identify the bottleneck but cannot promote speed or exactness.

Mask/source audit adds one independent candidate:
[`PQ-20260822-V22-SPLIT-FLASH-N1-EXACTNESS-SCREEN`](../planning/PQ-20260822-V22-SPLIT-FLASH-N1-EXACTNESS-SCREEN.md).
The preserved v22 singleton-shaped split-flash branch is source-backed and has
bit-identical block2 logits plus a narrow six-prompt exact receipt. Planner
disposition is `PASS-NEEDS-CEO-APPROVAL` for target-only, split-flash-off, and
split-flash-on sequential n=1 arms under frozen v21 Q4 identities. Exactness
is the gate; timing is conditional and diagnostic only. No run is queued or
launched, and n=2–7/general claims remain out of scope.

The EXP-021 build-only recovery is admissible under CEO direction: the first
build stopped on a forbidden UI download because the cache used
`LLAMA_BUILD_UI=OFF`/`LLAMA_USE_PREBUILT_UI=ON`. The exact source-backed
no-network amendment is both flags OFF with `CMAKE_CUDA_ARCHITECTURES=86`,
building only `llama-server` and launching no model/server. Source inspection
now rejects the prior APP=OFF idea: server CMake still links llama-ui. The
admissible retry is a fresh `/workspace` build with the old UI distribution
preseeded (140 files, 12,951,994 bytes, manifest SHA `e811817a...`), both UI
flags OFF, and `LLAMA_BUILD_SERVER=ON` (no APP flag). This is separate
from the later n=1 exactness run; any network attempt, source/binary drift,
configure/build failure, or process/GPU activity hard-stops and preserves the
receipt.

EXP021 preseed build-only gate now passes: fresh server binary SHA
`b17850bc...`, Build ID `22ecf3ea...`, matching candidate source hashes and
preseed manifest `e811817a...`; no model/server/inference or GPU process ran.
The n=1 exactness run is now `PASS-FOR-CEO/EXECUTOR-HANDOFF` for three
sequential arms (target-only, split-flash OFF, split-flash ON) using the fresh
binary and resolved libraries, subject to immediate read-only RUNPATH and
frozen-hash preflight. The `download.cpp` grep hit is only a compiled source
filename; no actual network command occurred. A target-only hash/token
mismatch blocks remaining arms; timing is conditional and diagnostic.

The preseed build-only gate has now passed: server `b17850bc…`, Build ID
`22ecf3ea…`, implementation/common/llama hashes
`605d798e…`/`19fdf005…`/`fdb0bc83…`, exact UI manifest `e811817a…` (140 files,
12,951,994 bytes). No network, model, GPU, or inference ran. Keep the queue
exactness-first pending; the prior UI hard stops remain preserved.

Literal preseed argv is receipt-backed (`preseed-argv-receipt.md`): exact UI
copy, CUDA-86/UI-OFF configure, and named `llama-server -j2` build returned 0.
This closes build provenance only; exactness-first execution remains queued.

EXP021 is terminal at a baseline-contract mismatch: target-only was stable,
but split-flash-OFF diverged on `code_python_debug` (`0f76b6ae...` target vs
`1d5020bf...` Q4, both 64 tokens; first decoded-text mismatch at character
194), so split-flash-ON was not run. Five other prompt hashes matched. The
historical v22 six-of-six receipt rendered 747 prompt tokens versus 531 now,
showing chat-template/rendering/runtime drift despite equal manifest/contract
hashes. No speed or acceptance result is valid. Smallest reopen is a read-only
rendering/runtime reconciliation binding literal argv, rendered bytes/token
IDs, tokenizer/template identity, and the token-count discrepancy; no split-ON
rerun, retuning, or n widening before repair.

Receipt closure: target-only six-prompt control was 227 tokens/run at
16.0559/16.0593/16.0534 tok/s; Q4 split-OFF was 104/118 accepted and failed
`code_python_debug` exactness (`0f76b6ae…` target vs `1d5020bf…` Q4). Split-ON
was not launched. No candidate timing, acceptance, or general speed claim is
admissible; preserve the 28-file raw receipt set and cleanup state.

Read-only reconciliation binds shared tuple/cache/nmax/block/extract fields;
only `code_python_debug` differs at character 194 and five prompts match.
Historical 747 versus current 531 prompt tokens makes v22 6/6 stale; token
index and seed/sampler/argv are UNKNOWN. Split-ON remains unrun/terminal; no
rerun or retuning is queued.

The docs-only rendering recovery packet is
[`PQ-20260822-021-RENDERING-CONTRACT-RECOVERY`](../planning/PQ-20260822-021-RENDERING-CONTRACT-RECOVERY.md).
It requires literal argv, chat-template/tokenizer identity, rendered prompt
bytes/token IDs and counts, seed/sampler, API payloads, and token-level first
divergence before EXP021 can reopen. No model, GPU, split-ON rerun, or retuning
is authorized while the baseline contract mismatch remains terminal.

Rendering reconciliation receipt `ef5ab675...` confirms a constant +36-token
historical offset per prompt (747 vs 531) with raw messages stable but rendered
bytes/token IDs/tokenizer/template/old argv absent. EXP021 is therefore
terminal-blocked. Reopen only with an authoritative rendered-prompt,
tokenizer/template, and literal-argv bundle explaining or superseding the
offset, then a fresh exact target oracle; no GPU/rerun/split-ON/retuning before
that gate.

Final artifact lookup is terminal no-found (`f4bf8b4b…`): only one historical
rendered hash `a83e3752…`; six rendered/token-ID artifacts, tokenizer/template,
old argv, special-token policy, and exact +36 mapping are absent. Reopen only
with an external authoritative bundle; no GPU/rerun/retuning is queued.

Final scoped lookup receipt `f4bf8b4b...` found no authoritative rendering
bundle (only one historical rendered hash). EXP021 is terminal no-found;
reopen requires external bundle supply or separately authorized regeneration.
No further local search, GPU run, split-ON launch, or rerun is queued.

Post-EXP021 ranking is recorded in
[`PQ-20260822-POST-EXP021-RECOVERY-RANKING`](../planning/PQ-20260822-POST-EXP021-RECOVERY-RANKING.md):
docs-only external rendering-contract recovery is first; a current-library
phase trace is measurement-only and optional; causal split-flash GPU work is
deferred until a fresh exact target oracle and reviewed one-variable packet
exist. Current disposition is `DOCS-ONLY-RECOVERY-FIRST`; no causal run is
queued.

Post-EXP021 source/runtime audit (`d68ffc7c…`/`c9068850…`) confirms no
independent candidate. Queue remains terminal; reopen only via external exact
rendering/Arm-B artifact intake, with no guessed state changes or rerun.

Recovery ranking is docs-only: external rendering/evaluator/Arm-B bundle is
the smallest next action; current-library phase measurement is optional
diagnostic; causal GPU candidates remain deferred. Source recheck is
`NO-CANDIDATE`; preserve EXP021 terminal and PQ019 cache-positive boundaries.
