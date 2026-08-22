# Qwen research ledger — 2026-08-22

This dated ledger continues the repository's append-only lab notebook. It
records the cache-on recovery decision and preserves the no-run boundary after
the previous Qwen acceptance, data-scale, precision, verifier-contract, and
runtime-measurement negatives.

## PQ-019 prompt-cache semantics and readiness

The read-only PQ-015 preflight bound the existing runtime's
`--cache-prompt`/`--no-cache-prompt` boolean, the v21 client's `cache_prompt`
request field, and `timings.cache_n`. Its receipt is
[`pq015-cache-semantics-preflight-20260821.json`](../receipts/PQ-20260821-015-cache-reuse/pq015-cache-semantics-preflight-20260821.json),
SHA-256 `e61b6d6187dbbc46f9460d02f1c2b641d2f0886916af225fb659d103801ab48a`.
Preserved cache-off runs report zero cached prompt tokens. They do not contain
a positive cache-hit receipt or a repeated-prefix benchmark.

The planner then wrote the source-backed four-arm packet
[`PQ-019`](../experiments/planning/PQ-20260821-019-CACHE-ON-N1-RUNTIME-PACKET-20260822.md),
SHA-256 `4b9f9679966b99b3e4ee2114d55f24e69399fe5c7c1d3cf114c56027d0807f3e`.
The runtime inventory, critic, and literature review exposed the remaining
workload gate: the existing prompt manifest has a shared system prefix but no
registered prefix groups, request order, cold/warm/reset boundaries, or
expected cache-hit counts. Therefore PQ-019 is **conditionally blocked** and
has not been launched.

The reconciliation is preserved in
[`PQ-019 decision review`](../experiments/planning/PQ-20260821-019-CACHE-ON-N1-DECISION-REVIEW-20260822.md)
and its machine receipt
[`readiness.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/readiness.json)
(SHA-256 `49495bc473516e17e5d1d30730136db76732934c1e21a347dcb97d2e5fb647f7`).
The next safe artifact is a small public, source-backed repeated-prefix
manifest. It must bind prompt/rendered hashes, prefix hashes and lengths,
request order, cold/warm and reset boundaries, expected `cache_n`, and split
provenance. No positive cache hit may be assumed before that receipt exists.

If reopened, the four arms are target-only cache-off/on and Q8 n=1
cache-off/on, run sequentially with one warmup and three timed repetitions.
The comparison is within target-only and within Q8; `cache_n`, prompt timing,
completion tokens, wall/tok/s, acceptance, output hashes, and exactness/content
must remain separate. Even a positive result would be a local prompt-reuse
throughput observation, not proof of speculative acceptance, verifier
correctness, losslessness, or general serving speed.

## Current evidence boundary

The strongest Qwen evidence remains negative or measurement-only: target-only
is faster than every tested Q8 draft arm; Q4/Q8 n=1 are tied and slower;
PQ-002 and PQ-007 improved teacher-forced metrics without improving strict
acceptance; PQ-008's exact deployment bundle was not found; PQ-012 lacks phase
counters; and PQ-013 lacks a mixed-mode dispatcher and unbiased policy split.
No exact Qwen speculative-decoding speedup is established.

## Documentation and next action

No GPU, SSH mutation, model load, inference, held-out access, download,
install, or flag toggle occurred for PQ-019. The dated decision, packet,
command inventory, critique, literature handoff, and machine readiness receipt
are the durable record. The next falsifiable question is whether an explicitly
registered repeated-prefix workload yields positive cache reuse and lower
prompt or end-to-end wall time without changing output identity.

## PQ-019 contract/workload reconciliation (2026-08-22, additive)

The first PQ-019 draft mixed a Q4-bound v21 contract with a Q8 drafter and a
v23 prompt manifest. That provenance error is preserved as historical evidence
and is not used for execution. The selected route is now target-only plus the
exact v21 Q4 drafter (`18a380…`), at fixed n=1, with the canonical v20 six-row
source (`77a9…`) duplicated byte-for-byte into a 12-row cold/warm manifest
(`f911c7d3…`).

The v21 source contract is byte/hash pinned (`4be899…`, 1,741 bytes). Because
it declares `draft_tokens_max=7` while the selected server boundary is n=1,
the run uses two explicit local byte-level derivatives: n1 cache-off
(`d14ee941…`) changes only `draft_tokens_max 7→1`, and n1 cache-on
(`50c3a875…`) changes only `prompt_cache false→true`. The full machine diff is
`cab5e1ea…`; the canonical contract/workload receipt is
`f81744db…` with note `a39fe9dc…`.

This closes the local identity/workload gate but not the live gate. A fresh
remote hash/resource preflight and read-only rendered/prefix-hash check are
still required. Until those pass, no server, model, GPU, or cache flag is run.

## PQ-019 exact-artifact live preflight (2026-08-22, read-only)

A fresh SSH probe superseded the stale v30-Q4 receipt. It verified the exact
v21 Q4 file bound by the source contract: 1,143,006,752 bytes,
`18a380ef…0594`. The target/server/client/contract/workload identities match;
the RTX 3060 is idle at 1 MiB/0%, workspace free space is 2,144,796,672 bytes,
and no task server/client process exists. Receipt:
[`q4-v21-exact-artifact-live-preflight.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/q4-v21-exact-artifact-live-preflight.json),
SHA `6ea483b8…`.

Five of six rendered/token-prefix hashes remain UNKNOWN because the static v20
prompt file does not contain model-template/tokenizer output. This is now the
only known pre-execution gate in this lane; no server/model/GPU workload was
started.

## PQ-019 terminal result (2026-08-22)

The minimum cache diagnostic then ran once, sequentially, on the authorized
RTX 3060. Target-only moved from `16.0895` to `17.8801` tok/s with cache on
(`+11.13%`); Q4 DFlash n=1 moved from `18.1639` to `21.7631` tok/s
(`+19.82%`). Cache-off had zero cached tokens; cache-on had `1,014` cached
prompt tokens per timed repetition and reduced prompt-token work from `1,062`
to `48`. Q4 acceptance/proposed stayed `208/236` in both modes and each timed
rep produced 454 completion tokens. Within each model arm, output/message
content hashes match across cache modes.

The complete analysis is [`postrun-analysis.md`](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md)
and machine receipt [`postrun-analysis.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json).
Raw JSON/logs, order hashes, environment, cleanup, and terminal receipts are
preserved in the same directory. Final GPU state was 1 MiB/0%, no task process.

Disposition: **positive local repeated-prefix cache/prompt-processing effect**,
not a speculative-decoding speedup claim. Rendered/token-prefix hashes and
strict token-ID exactness remain UNKNOWN; no acceptance, quality, losslessness,
verifier, or general serving claim is allowed. The next research priority
returns to the unresolved verifier/state contract, not more blind cache sweeps.

## EXP-020 singleton-correction diagnostic (2026-08-22)

The current-runtime Qwen card [`EXP-20260822-020-qwen-singleton-correction`](../experiments/cards/EXP-20260822-020-qwen-singleton-correction.md)
is active after a narrow cache-off observation: Q4 DFlash n=1 measured
`18.1638816661` output tok/s versus target-only `16.0895399687`, a
`+12.892486%` difference on the frozen workload. Both arms emitted 454
completion tokens; Q4 accepted `208/236` proposals. Output hashes agree for
5/6 unique prompts (10/12 duplicated rows), while `code_python_debug` is the
sole deterministic mismatch in all three repetitions and both arms emit 64
tokens.

This is a promising but non-promotable raw lead. EXP-020's trace/singleton
correction result is pending; no running trace result is inferred here. Exact
token IDs, rejected-boundary localization, and a fresh matched throughput
screen remain promotion gates. The next admissible GPU action requires the
exact source-backed Arm-B/evaluator/state bundle or separately authorized
source-backed regeneration, with positions/sequence IDs, serialized
mask/cache/anchor/rollback semantics, evaluator/logger/replay/dependency
identities, resolved split, and the `[171,171]`/`[170,170]` conflict recorded.

## EXP-020 margin-gated correction and speed gate (2026-08-22)

The six-public-prompt raw-margin inventory found why a naive runner-up rule is
unsafe. `logic_schedule` already matched its target with accepted margin
`0.0897636414`, while divergent `code_python_debug` had margin `0.0684490204`
and target runner-up `90563` versus accepted draft `471`. A threshold of
`0.08` was frozen once from this inventory; it is not retuned or claimed as a
general calibration.

The one-shot low-margin smoke passed all six target output hashes with exactly
one override. The matched cache-off gate then passed one warmup and three
timed repetitions per arm, 227 completion tokens per run. Target-only mean
was `16.4723525853` tok/s (SD `0.0027415161`); corrected Q4 n=1 mean was
`18.5307384154` tok/s (SD `0.0352037718`), a `+12.4960039522%` local
difference. Corrected acceptance was `103/118`, one override per run, and all
warmup/timed runs matched all six target output hashes. Cleanup passed.

Disposition: promising local exact-hash result for this exact target/drafter/
runtime/workload tuple. It is not general losslessness, token-ID exactness,
or serving-speed evidence; threshold calibration and evaluation used the same
six public prompts. The earlier default Q4 lead (`+12.892486%` on 5/6 hashes)
remains preserved separately.

## EXP-020 independent-v23 generalization screen (2026-08-22)

The same frozen `PQ020_LOW_MARGIN_TOP2=0.08` policy was screened on 12
separate public v23 validation prompts without retuning or prompt-specific
exceptions. Target-only reproduced all 12/12 hashes and 625 completion
tokens. Corrected Q4 matched only 6/12 projections; mismatches were
`v23-coding-00126`, `v23-explanation-00005`, `v23-explanation-00095`,
`v23-instruction-00160`, `v23-instruction-00316`, and
`v23-reasoning-00170`. No override events fired.

Corrected Q4 measured `19.954249` versus target `17.659459` tok/s
(`+12.994677%` diagnostic only), with 625 tokens on each arm. The failed
projection gate makes this a negative generalization result, not a promotion
or general speed claim. The six-prompt calibrated `+12.496004%` result remains
separate local evidence. No retuning or exceptions are allowed.

Summary SHA-256: `bb65c097f20f36f063f46ca3f3730a229f4a954decc43705b05b9d0b8dbd97c8`.
Analysis: [`PQ-20260822-020-INDEPENDENT-V23-SCREEN.md`](../experiments/analysis/PQ-20260822-020-INDEPENDENT-V23-SCREEN.md).

## EXP-020 trace localization and `n_rs` causal result (2026-08-22)

The instrumented target/Q4 traces share an exact 42-token prefix. The first
divergence is output token 43: target token `90563` versus Q4 accepted draft
token `471` in verifier cycle 25. Seven one-token rejection/rollback cycles
precede this accepted-draft decision. Q4's cycle correction token was `16`,
so the target token is not explained by the correction row. This localizes the
failure to an accepted-draft decision after prior rollback activity; it does
not by itself prove which state transition causes it.

The bounded one-prompt `n_rs` axis forced target-only `n_rs_seq=1` and Q4 n=1
`n_rs_seq=0` with frozen artifacts. Target-only retained hash `0f76b6ae…` at
`18.7416124147` diagnostic tok/s; Q4 retained divergent hash `1d5020bf…` at
`16.3178374758` diagnostic tok/s. Both emitted 64 tokens. Thus recurrent
snapshot count/layout, including matching the target-only layout, is falsified
as the sole cause. These timings are diagnostic and not a serving promotion.

Receipts: [`token-divergence-analysis.md`](../receipts/EXP-20260822-020-qwen-singleton-correction/token-divergence-analysis.md),
[`n-rs summary`](../receipts/EXP-20260822-020-qwen-singleton-correction/n-rs-axis-r1/summary.json).

## Post-PQ019 executable audit and recovery (2026-08-22)

The planner, critic, literature, and runtime lanes independently re-audited the
portfolio after PQ-019. They converge that no new source-backed Qwen GPU
improvement is admissible now: cache, precision, fixed-n, data-scale, objective,
mixed-mode, and aggregate-counter branches are terminal, negative, or missing
their required runtime artifacts. The planner audit is
[`PQ-20260822-NEXT-EXECUTABLE-AUDIT.md`](../experiments/planning/PQ-20260822-NEXT-EXECUTABLE-AUDIT.md),
SHA `76c5a99b…`; the critic and runtime audits are preserved beside it.

The smallest recovery action was a local-only PLAN-001 output/evaluator
reconciliation. It recovered all six target-only oracle assistant/content/
reasoning hashes, 321 completion tokens, 333 target decode calls, 17,743.828857
ms, evaluator/client/finalizer hashes, strict predicate/RNG settings, and
historical Arm-B fields. It did **not** recover the exact PLAN-001 Arm-B
serialization/source tie, complete logger/replay/dependency tuple, explicit
split, or the `[171,171]` versus `[170,170]` memory conflict. Receipt:
[`pq008-local-output-evaluator-reconciliation-20260822.json`](../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json),
SHA `945548c5…`; note SHA `76b8a4ae…`. PLAN-001 remains blocked; no GPU or
model work was launched.

A fresh read-only remote check at `2026-08-21T23:01:47Z` confirms host
`9719ca4634c7`, RTX 3060 at 1 MiB/0%/54 C, no task processes, and
2,144,088,064 workspace-free bytes. Receipt:
[`live-state-check-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/live-state-check-20260822.json),
SHA `7b1dd3cb…`. The next GPU run remains conditional on one exact
source-backed deployment/selector/paired-state/runtime artifact; repeating a
terminal branch would not advance the stated objective.

## Scoped remote artifact probe (2026-08-22)

A narrow read-only SSH probe inspected the remote experiments tree to depth five
for `plan001`, `arm-b`, `replay`, `logger`, and `evaluator` filenames. It found
no candidate paths. The RTX 3060 remained at 1 MiB/0% with no task process.
Receipt: [`remote-artifact-probe-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-20260822.json),
SHA `f0b244bc…`. This confirms the external artifact boundary without broadening
the search or mutating the remote checkout.

## Recovery probe r2 (2026-08-22)

A second narrow read-only SSH check extended the filename search to depth seven
and included verifier names. It found no PLAN-001, Arm-B, replay, logger,
evaluator, or verifier candidate paths. Host `9719ca4634c7` reported RTX 3060
memory `1 MiB`, utilization `0%`, temperature `55 C`, and no task process (the
inspection shell was excluded). Receipt:
[`remote-artifact-probe-r2-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-r2-20260822.json),
SHA `6bffd9b3…`; note SHA `2c586f53…`.

Disposition: the external contract blocker remains confirmed. This probe adds
no scientific result and does not authorize a GPU run; reopening still requires
an exact source-backed deployment/evaluator/state artifact.

## Lane review after recovery r3 (2026-08-22)

Planner, critic, runtime, and literature lanes independently reviewed the
content-level no-found result. Their machine-bound consensus is recorded in
[`r3-lane-review-receipt-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/r3-lane-review-receipt-20260822.json).
No new one-variable Qwen acceptance/speed axis is admissible without the exact
Arm-B/evaluator/state bundle. PQ-019 remains a local cache diagnostic only;
the next action is external artifact supply or separately authorized
source-backed regeneration.

## Recovery content probe r3 (2026-08-22)

The remote checkout was searched by content across experiment, script, config,
runtime, and tool roots. The broad pass found only historical logs, build
files, and existing runtime sources. A narrowed pass excluding logs, builds,
and receipts found zero source/config/planning matches for PLAN-001, Arm-B,
replay, serialized mask/cache, evaluator, rollback, or memory-conflict fields.
Receipt:
[`remote-content-probe-r3-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-content-probe-r3-20260822.json),
SHA `63768b01…`; note SHA `ff272da9…`.

Disposition: content-level recovery is exhausted for the scoped checkout. No
GPU run is authorized without external artifact supply or a separately
authorized source-backed regeneration task.

## EXP020 library identity recovery — hard stop

The approved target-only instrumented trace did not load a model or start
inference. Expected `libllama_common` was `d07ed8b4c22e…`; observed current
library was `65b8a862607e…`. Server and implementation hashes matched, cleanup
was clean, and no numeric trace result is claimed. The exact-source/hash gate
requires a UI-off no-model rebuild, byte verification, trace-only scope, and
restore/verification of the current library afterward. Receipts:
`receipts/EXP-20260822-020-qwen-singleton-correction/benchmark-contract-target-only-instrumented-trace.json`
and `target-instrumented-trace-hard-stop.json`.

### Final library-recovery outcome

The task-owned rebuild emitted `1bbaf7b5…`, failing the required `d07ed8b4…`
identity gate before model/GPU use. The source was restored to `c1b1f6f0…`
and active library to `65b8a862…`; server and implementation hashes stayed
intact, with no processes left. Therefore no target phase trace exists. This
preserves the independent-v23 6/12 negative and PQ019 narrow cache-positive
result without promoting either to a general claim.

## Candidate review disposition

Planner PASS identifies one CEO-approval-gated measurement: the current-library
EXP020 phase trace compares target-only and Q4 n=1 with frozen inputs, margin
override disabled, and phase counters. It is diagnostic only and has not run;
no other executable source-backed Qwen intervention remains.

## EXP021 v22 split-flash checkpoint

Candidate-only hashes and both build hard stops are preserved in the EXP021
card/receipts: malformed historical patch reconstructed; `/dev/shm` first
attempt stopped at 8% on UI download/noexec; UI-OFF/OFF retry stopped at 38%
with `LLAMA_BUILD_APP=ON` and missing embedded assets. The source-backed
preseed recipe/frozen manifest is pending execution; fresh `/workspace` build
is approximately 25%. No inference or numeric outcome is claimed.

### EXP021 build-only success

Preseeded old UI assets (140 files, 12,951,994 bytes, manifest
`e811817a…`) enabled a successful CUDA-86 server build: `b17850bc…`, Build ID
`22ecf3ea…`, impl/common/llama `605d798e…`/`19fdf005…`/`fdb0bc83…`.
No network, model, GPU, or inference ran; exactness-first screen remains
pending and prior build failures remain preserved.

`preseed-argv-receipt.md` records literal commands (including UNKNOWN cwd),
exact UI preseed, CUDA-86/UI-OFF configure, and named server `-j2` build
returning 0. Build provenance is closed; no inference result is claimed and
exactness remains pending.

### EXP021 terminal exactness stop

Six-prompt target-only control was stable at 227 tokens/run. Q4 split-OFF
failed on `code_python_debug` (target `0f76b6ae…`, Q4 `1d5020bf…`; both 64
tokens/`length`, 104/118 accepted), so split-ON was not run. This is a
terminal exactness negative for the screen, not a speed or acceptance result.

Mismatch receipt: target/Q4 share contract, prompt/model/server, nmax=1,
block=8, n_extract=5, cache off. Only code_python_debug differs at character
194; five prompts match. Historical 747 versus current 531 prompt tokens marks
render/runtime drift; token index and seed/sampler/argv remain UNKNOWN. Split-ON
stays terminal/unrun; no rerun.

Rendering packet `ef5ab675…` confirms stable raw source/contract/model settings
but exactly +36 historical tokens per prompt (747 vs 531). Rendered bytes,
token IDs, tokenizer/template artifact, and historical argv are UNKNOWN;
historical 6/6 is stale. No GPU/rerun/retuning.

Rendering-artifact lookup `f4bf8b4b…` is terminal no-found: one historical hash
`a83e3752…` only; six rendered/token-ID artifacts, tokenizer/template, argv,
special-token policy, and exact +36 mapping remain UNKNOWN. External bundle is
required to reopen; no rerun.

Post-EXP021 audit receipt `d68ffc7c…` is `NO-CANDIDATE`: all local source-level
improvement axes are retired or blocked. Only external rendering/Arm-B
provenance recovery can reopen work; no GPU/rerun/guessed state changes.

Recovery ranking remains docs-only: external rendering/evaluator/Arm-B bundle
first, optional current-library phase measurement second, causal GPU deferred.
Preserve EXP021 terminal and PQ019 narrow-positive boundaries.

Current-state recovery receipt `67a6b5b3…` attributes +36 historical tokens to
the xhigh reasoning preamble. Historical inventory `17d01aad…` contains 12
rendered artifacts, all code_python_debug/hash `a83e3752…`; no six-row/token-ID/
argv bundle. Current rendering stays UNKNOWN; no GPU/rerun.

Receipt `04481e84…` confirms raw-message client behavior; only the model-loading
tracer calls `/apply-template`. Readiness `5c08e46…` requires separate
authorization for CPU-only six-row capture; no endpoint/model/GPU call now.

Preflight `8d0c8f0c…` verifies `/tokenize`; amended packet `21f4bc87…`
authorizes only CPU six-row render+tokenize metadata capture. Generation/GPU/
split-ON remain excluded; hard-stop `0ae0c510…` is retained.

### EXP021 capture-r2 closure

The six-row `/apply-template`→`/tokenize` capture passed on CPU only. Full
capture SHA is `cdab75d710a9de052bb3b1a2c51f964032e6697115e7dd1611e7ffdc1cdc45d7`;
metadata receipt SHA is `ccc5f3da5f80c51d2537e22fe2bcb381dbe38e55c53e45b3be75afd8b36d4870`;
manifest SHA `77a9b570…`. Ordered IDs and rendered bytes/token counts:
`code_python_debug 752/169`, `code_rust_parser 589/122`, `math_modular
592/115`, `logic_schedule 572/111`, `technical_explain 523/96`,
`structured_extract 640/134` (747 total). All tokenizer calls used
`add_special=false`, `parse_special=true`, `with_pieces=true`; row render and
token-prefix hashes are preserved in the receipt.

This closes the +36-token historical drift as a captured rendering fact, not a
serving result. Identity is bounded: r2 used the original `5c43b943…` tracer /
CPU server, whereas EXP021's benchmark path is `b17850bc…` and 531 tokens;
these must not be mixed. Request counts were six apply-template, six tokenize,
zero completion/generation/drafter/verifier/timing; server cleanup and GPU idle
passed. The earlier EXP021 split-OFF negative is preserved; no split-flash,
acceptance, speed, or general claim.

Repaired exactness-first packet `1a9e3f78…` and alignment receipt `4a736a15…`
clarify that capture-r2 is an old-`5c43…` six-row/747-token reference only.
The EXP021 `b178…` candidate must pass Stage-0 equality for rendered bytes,
token IDs/pieces/counts, argv/linkage, and source/build identities before any
GPU arm. This remains no-run; no split-flash result is asserted.

Stage-0 b178 candidate equivalence passed six-of-six. Candidate receipt
`8f74cf64…`, metadata receipt `2e1d50b5…`, packet `1a9e3f78…`. All six rows
matched r2 manifest/target/order, rendered bytes/SHA, token IDs/pieces/counts,
and apply/tokenize payload hashes; rendered hashes in order are
`a83e3752…`, `97aabb92…`, `a374606b…`, `27400339…`, `ab472707…`,
`cc5d2c6d…`, with counts `169/122/115/111/96/134`. Flags are
`false/true/true` (`add_special/parse_special/with_pieces`). Six apply and six
tokenize calls, zero generation/timing; cleanup and GPU idle passed. This is
not a serving result: target oracle and both split arms remain blocked pending
final planner/critic/literature review.

Final handoff packet `96820b66…` and queue reconciliation `080f9042…` leave
EXP021 conditionally ready only. CEO approval/live preflight are pending. The
frozen sequence is target-only oracle, Q4 split-OFF control, then split-ON only
if both are six-of-six exact; one process at a time, no timing before gates.
No GPU outcome or split-flash claim is recorded.

CEO packet `9d8c5add…`, live preflight `14ac6bf2…`, literature `d448cb6e…`,
and critic final authorize execution on the explicit 747-token tracer path.
Target-only is running, then Q4 split-OFF, then split-ON only after six-of-six
exactness. The 531-token benchmark path is excluded. No numeric outcome or
timing/acceptance claim yet; one-process and hard-stop boundaries persist.

Terminal result: corrected tracer target-only six-of-six stable; Q4 `n=1`
split-OFF mismatched `code_python_debug` and `logic_schedule` at 64 tokens
with `length` termination. Split-ON/timing did not run. Preserve raw receipts
and the no-causal-claim boundary: this is evaluator/runtime negative for the
tested tuple, not a split-flash causal result.

Final-run detail: target-only 6/6 stable, 747 prompt tokens; Q4 split-OFF
rendered hashes matched but only 4/6 exact. First mismatches were token 50
(`code_python_debug`, accepted 30/33) and token 37 (`logic_schedule`, accepted
27/35), both capped at 64 tokens. Split-ON/timing were not run and cleanup was
clean. Record as control failure only, with no split-flash claim.

Planner terminal `9ea4c80a…`, queue `70d65736…`, and receipt `b3c1e8db…`
supersede the prior result: final raw prompts are 531 no-xhigh, not 747
tracer. Keep `0c98f7d` as stale contradictory history; apparent 6/6 and 4/6
are invalid exactness evidence. No rerun/split-ON. Reopen requires literal
launch/tracer enforcement plus all 747 hashes/IDs through `/completion`.

Raw-contract audit `a1fcc5cc…` / `2f2a5d67…`: all final JSONs are benchmark
completion with pre-rendered 531-token prompts; no apply-template, tokenize,
or tracer evidence. Valid only for the old tuple; no rerun/GPU.

Launch audit `4f897f40…`: executor argv mechanism UNKNOWN; raw route is
531/no-xhigh. Fail-closed design requires six apply-template + six tokenize
assertions (hash/ID/count/747 total) before completion. Documentation-only; no
wrapper or rerun, and split-ON/speed prohibited.

Wrapper SHA `01f937e5…`, tests `6828fb70…`, packet `ddf7e99a…`; live identity
receipt `c398d7f1…` and capture `322ab37f…` pass contract-v22 `a69610f9…`
against b178/Stage0 six-of-six/747. Six apply + six tokenize, zero completion/
GPU/timing; cleanup and idle verified. CPU identity only; no completion/GPU arm.

Target-only oracle passes: summary `d1a9ff6d…`, terminal `7b1ce0c1…`; v22
contract `a69610f9…`, b178/tracer/manifest pinned. Four reps × six rows passed
747 assertions with 6/6 byte-identical outputs; technical=eos, others=limit,
cache_n=0; diagnostic tok/s 18.9016/18.6411/18.8415/18.8491. Cleanup
`91d1a65f…` and idle passed. Oracle only; split-OFF remains gated.

Q4 split-OFF summary `94170d0a…` / terminal `9b24d3dc…` hard-stopped at
warmup code_python_debug: `6400f118…` vs oracle `a382e0c0…`, 31/31 accepted,
64-token limit, 3007.86 ms. Split env unset; no further rows/timing/split-ON.
Cleanup/idle passed. Record baseline/evaluator mismatch only.

Authoritative 747 receipt `50e7832c…` supersedes contaminated 531 `d119ff45…`.
First valid divergence is token 2 (760 target vs 248069 Q4), duplicate
`</think>`, 31/31 accepted, cache_n=0, 64/limit. Localization `3b66872b…` /
`0bc83dcc…` observes but does not causally identify; no patch/rerun/split-ON/
timing.

Literature terminal `cc007b73…` marks the 747 candidate branch terminalized,
not split-flash negative. No split-ON/timing. Reopen only with immutable
token/logit/decision/rollback/cache, argv/build/library, and model/drafter/
template/manifest/contract bundle, then fresh oracle + six-of-six split-OFF.
Keep 531 receipts separate.

Read-only mapping `9d16cbcf…` / `48920f0f…` records symbols/offsets and text
line bindings; DWARF absent (`addr2line ??`), split-off hunks unreachable,
duplicate marker/rollback UNKNOWN. No repair, rerun, or GPU; preserve terminal.

Mapping postreview planner `e10285cb…`/queue `a25db317…`, critic `40a8174b…`,
literature `d8cc9594…`: provenance partial PASS; causal repair BLOCKED/
terminal. No DWARF/debug map or transaction trace. Reopen only with exact
BuildID-matched debug/linker map and token/logit/commit/rollback evidence.

Search/reconciliation `b94030f…` with planner `f43d01f…`/queue `aad39d7…` and
literature `17195aba…`: b178 unstripped ELF found, no b178 DWARF/.map/core/
token trace. Historical `080fe7cf…` attn_pregate-3 is non-b178 hypothesis;
preserve identity boundary, no candidate/rerun/GPU.

Q_len/attention screen `58b7fe15…` / `d8aee23f…` returns NO-CANDIDATE. The
non-b178 attn_pregate hypothesis remains historical only. Missing reopen bundle:
Arm-B state/rollback, 747 rendering/token IDs, immutable draft/target logits,
acceptance and transaction trace. No patch/GPU; split-OFF terminal.

Final q_len reviews `fa22970b…`/`8e7b57d1…`, critic `2deb8fd9…`, literature
`b35356fd…`: NO-CANDIDATE. External recovery must bind Arm-B/rendering/
evaluator 747 contract or exact b178 token/logit/accept/rollback trace. No
GPU/build/rerun.

External intake `c48ab5f…`/`c177ef7…`, literature `8c1e9e3…` freezes exact
reopen artifacts: Arm-B/rendering/evaluator 747 or b178 BuildID,
rendered/tokenizer data, immutable token/logit/accept/rollback/cache trace,
literal argv/env/library hashes. No GPU/rerun; attn_pregate unbound.

Remote closeout `7022e301…`/`9a027bb5…`: RTX3060 1 MiB/0%, no processes,
1.5 GB free; stale PID markers only. Preserve no-run/external-intake boundary.
