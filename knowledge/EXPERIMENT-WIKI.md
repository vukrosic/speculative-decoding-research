# Qwen speculative-decoding experiment wiki

Last updated: 2026-08-22  
Scope: Qwen3.8-27B DFlash2-style drafting on the authorized RTX 3060.

This page is the compact map of the lab history. It is not a replacement for
raw receipts: every row links to the experiment card, machine receipt, or
review that carries the authoritative details. Claims are deliberately split
into teacher-forced training, acceptance, exactness/content, and serving
throughput.

## Current decision

The research goal is still active: improve Qwen speculative decoding. There is
no new GPU run authorized at this boundary. The next high-information action is
to recover an exact source-backed PLAN-001/PQ-008 verifier/state bundle. The
latest read-only reconciliation recovered oracle/evaluator facts but did not
recover the exact deployment Arm-B serialization/source tie, complete
logger/replay/dependency identity, explicit split, or the `[171,171]` versus
`[170,170]` memory conflict.

- [Current state](../CURRENT-STATE.md)
- [Latest Qwen ledger](QWEN-RESEARCH-LEDGER-2026-08-22.md)
- [Next executable audit](../experiments/planning/PQ-20260822-NEXT-EXECUTABLE-AUDIT.md)
- [Local PLAN-001 reconciliation](../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json)
- [Scoped remote no-found probe](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-20260822.json)
- [Follow-up no-found probe](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-r2-20260822.json)
- [Content-level no-found probe](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-content-probe-r3-20260822.json)
- [r3 planner/critic/runtime/literature consensus](../receipts/PQ-20260821-019-cache-on-n1-20260822/r3-lane-review-receipt-20260822.json)
- [This wiki update receipt](../receipts/PQ-20260821-019-cache-on-n1-20260822/experiment-wiki-update-20260822.json)

## Results at a glance

| ID | Axis | Evidence | Disposition |
|---|---|---|---|
| PQ-002 | Prefix-survival objective | Best n=4 accepted/cycle `0.1996047`, below the `0.20198` incumbent gate | Negative; do not repeat unchanged |
| PQ-006 | Fixed draft length | Target-only mean `17.3497` tok/s; n=1 `16.0129`, n=2 `13.7929`, n=3 `12.3748`, n=4 `11.5310` | Negative for serving speed; n=2 had the highest observed acceptance, not a promotion |
| PQ-007 | +2,000 source-disjoint training windows | Validation CE `2.48420` vs parent `2.68951`; n=4 acceptance `0.176699` vs `0.20198` | Teacher-forced improvement, terminal-negative acceptance |
| EXP-011 / PQ-009 | Q4 vs Q8 at fixed n=1 | Q4 `16.0923`, Q8 `16.0878`, target-only `17.4025` tok/s; both `98/508` accepted | Precision near-tie; retired as a speed lever |
| PQ-019 | Repeated-prefix prompt cache | Target `16.0895→17.8801` (+11.13%); Q4 n=1 `18.1639→21.7631` (+19.82%); cache-on `1,014` cached prompt tokens/rep | Positive local cache/prompt-processing effect only |
| EXP-020 | Margin-gated singleton correction (active diagnostic) | Corrected Q4 `18.5307384154` vs target `16.4723525853` tok/s (+12.49600%); 227 tokens/run; all six public hashes match | Local tuple result; calibrated, not general losslessness/speed |
| PQ-008 | Verifier/state localization | Exact deployment bundle not found; several contract fields remain UNKNOWN/CONFLICT | Terminal recovery blocker; no Arm A/B/D run |
| PQ-012 | Runtime phase decomposition | Aggregate counters exist; per-phase draft/verify/cache/scheduler timers and exactness binding do not | Measurement-gap negative |
| PQ-013 | Prompt-level gating/mixed mode | No source-backed dispatcher and no unbiased calibration/held-out policy split | Terminalized planning-only hypothesis |

### Interpreting the table

The cache result is the only recent positive throughput observation, but it is
about repeated prompt reuse. It does not show that speculation is faster. All
tested Qwen speculative arms remain below target-only on the registered
serving screens, and the exact token-ID/content contract is not complete for
the frozen wrapper.

## Experiment records

### PQ-002 — prefix-survival objective

The objective improved some training metrics but did not clear the strict
acceptance gate. The best recorded n=4 result was `0.1996047` accepted/cycle,
below the `0.20198` incumbent. Preserve the negative result; do not scale the
same objective or data without a new causal variable.

- [Planning/critique history](../experiments/critique/PQ-20260821-002-POSTRUN-NEGATIVE-AND-FIXED-N-SWEEP-CRITIQUE-20260821.md)
- [Acceptance receipts](../receipts/PQ-20260821-002-prefix-objective-20260821/acceptance-screen/)

### PQ-006 — fixed-n runtime screen

This was the cleanest direct serving comparison. Increasing n reduced wall
throughput on this RTX 3060. n=1 was the fastest draft arm but still slower
than target-only; n=2 had higher acceptance but did not pay for its draft cost.

- [Experiment card](../experiments/cards/EXP-20260821-010-qwen-fixed-n-runtime.md)
- [Runtime receipts](../receipts/PQ-20260821-006-fixed-n-runtime-20260821/)

### PQ-007 — added data and fit

The augmented fit used 11,944 train rows (9,944 frozen + 2,000 new) and 508
validation rows. The one-epoch repair fit improved validation loss and token
accuracy, proving only a teacher-forced fit change. The exported checkpoint
then produced `91/2010 = 0.176699` accepted/cycle at n=4, below the parent
`0.20198`; target-content and strict exactness fields were unavailable.

- [Fit receipt](../receipts/PQ-20260821-007-data-scale-100k/pq007-fit-12452-v26repair.json)
- [Negative acceptance receipt](../receipts/PQ-20260821-007-data-scale-100k/pq007-n4-screen.json)
- [Final critique](../experiments/critique/PQ-20260821-007-N4-POSTRUN-NEGATIVE-CRITIQUE-20260821.md)

### EXP-011 / PQ-009 — drafter precision at n=1

Q4_K_M and Q8_0 were effectively tied (`+0.028%` Q4 versus Q8) and both
lagged target-only by roughly 7.5%. Acceptance was identical at `98/508`.
This retires precision as the next speed axis for this configuration.

- [Precision card](../experiments/cards/EXP-20260821-011-qwen-drafter-precision-n1.md)
- [Raw receipts and cleanup](../receipts/PQ-20260821-009-q4-q8-n1-precision-speed/)
- [Post-run critique](../experiments/critique/EXP-20260821-011-PQ009-POSTRUN-CRITIQUE-20260821.md)

### PQ-019 — repeated-prefix prompt cache

The selected route was target-only plus the exact v21 Q4 drafter at n=1. The
workload duplicated six public API-message rows byte-for-byte into a cold then
warm sequence. Cache-off reported `cache_n=0`; cache-on reported positive reuse
and reduced prompt work from 1,062 to 48 tokens per receipt. Q4 acceptance and
completion-token counts stayed unchanged.

This is a bounded local cache-cost diagnostic. Rendered/token-prefix hashes
and strict token-ID exactness remain UNKNOWN, so the result must not be
described as general speculative speed, quality, losslessness, or verifier
improvement.

- [Durable experiment card](../experiments/cards/EXP-20260822-019-qwen-prompt-cache-reuse.md)
- [Post-run analysis](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md)
- [Machine summary](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json)
- [Raw arm receipts](../receipts/PQ-20260821-019-cache-on-n1-20260822/raw-remote/)
- [Post-run critique](../experiments/critique/PQ-20260821-019-POSTRUN-CRITIQUE-20260822.md)

### EXP-020 — singleton correction diagnostic (active)

The current-runtime diagnostic was activated after the cache-off Q4 n=1
screen showed a narrow raw-throughput lead: `18.1638816661` tok/s versus
target-only `16.0895399687` tok/s (`+12.892486%`). Both arms produced 454
completion tokens and Q4 accepted `208/236` proposals. Only 5/6 unique prompt
output hashes agree (10/12 duplicated rows); `code_python_debug` is the sole
deterministic mismatch across three repetitions, with 64 tokens on each arm.

This is a useful lead, not a result to promote: strict token-ID equality and
correction-runtime promotion remain pending. The card explicitly forbids
inventing a speed or correctness result
before those gates close. The GPU lane can reopen only with the exact
source-backed runtime/evaluator/state contract (or separately authorized
source-backed regeneration), including Arm-B positions/sequence IDs,
mask/cache/anchor/rollback semantics, evaluator/logger/replay/dependency
identities, resolved device split, and the `[171,171]` versus `[170,170]`
memory conflict.

- [EXP-020 card](../experiments/cards/EXP-20260822-020-qwen-singleton-correction.md)
- [Trace contract](../receipts/EXP-20260822-020-qwen-singleton-correction/benchmark-contract-q4-n1-code-python-trace.json)
- [Paper-material claim boundary](../paper-material/claims.md)

The trace phase subsequently localized the first mismatch after an exact
42-token prefix: target token `90563` versus accepted Q4 draft token `471` at
output token 43. The accepted draft occurs in cycle 25; seven one-token
rejection/rollback cycles precede it. A bounded `n_rs` causal run then forced
target-only `n_rs_seq=1` and Q4 `n_rs_seq=0`: target-only retained hash
`0f76b6ae…` at `18.7416124147` diagnostic tok/s, while Q4 retained divergent
hash `1d5020bf…` at `16.3178374758` diagnostic tok/s. The snapshot
count/layout axis is therefore falsified as the sole cause. Both arms emitted
64 tokens, and these timings are diagnostic only.

- [Token-divergence analysis](../receipts/EXP-20260822-020-qwen-singleton-correction/token-divergence-analysis.md)
- [n_rs-axis receipt](../receipts/EXP-20260822-020-qwen-singleton-correction/n-rs-axis-r1/summary.json)

The six-prompt raw-margin inventory ruled out a naive `<0.1` runner-up rule:
`logic_schedule` already matches its target at margin `0.0897636414`, while the
divergent `code_python_debug` decision has margin `0.0684490204` and target
runner-up `90563` versus draft `471`. A predeclared `0.08` threshold produced
exactly one override in the smoke and recovered all six target output hashes.

The subsequent matched cache-off gate used one warmup and three timed runs per
arm. Target-only averaged `16.4723525853` tok/s (SD `0.0027415161`); corrected
Q4 averaged `18.5307384154` tok/s (SD `0.0352037718`), a `+12.4960039522%`
local difference. Every run emitted 227 tokens and matched all six target
output hashes; corrected acceptance was `103/118`, with one override per run.
This is exact-hash evidence for the frozen six-public-prompt tuple only, not a
general token-ID exactness, losslessness, or serving-speed guarantee.

- [Six-prompt margin inventory](../receipts/EXP-20260822-020-qwen-singleton-correction/sampler-margin-six-r1/findings.md)
- [Correctness smoke summary](../receipts/EXP-20260822-020-qwen-singleton-correction/low-margin-top2-smoke-r1/summary.json)
- [Corrected speed-gate summary](../receipts/EXP-20260822-020-qwen-singleton-correction/corrected-speed-gate-r1/summary.json)

The independent v23 screen froze the same `0.08` policy and used 12 separate
public validation prompts. Target-only reproduced 12/12 hashes and 625
tokens; corrected Q4 matched 6/12, with mismatches in coding, explanation,
instruction, and reasoning rows. No override events fired. Corrected Q4 was
`19.954249` tok/s versus target `17.659459` (`+12.994677%` diagnostic only),
but the failed projection gate makes this a negative generalization result.
The six-prompt calibrated `+12.496004%` result remains local and is not
promoted or generalized; no retuning or prompt exceptions are allowed.

- [Independent-v23 analysis](../experiments/analysis/PQ-20260822-020-INDEPENDENT-V23-SCREEN.md)
- [Independent-v23 raw summary](../receipts/EXP-20260822-020-qwen-singleton-correction/independent-v23-screen-r1/raw-remote/summary.json)

### PQ-008 — verifier/state recovery

The historical source reconciliation recovered target-only oracle hashes,
completion accounting, strict predicate/RNG settings, and partial Arm-B
metadata. It did not recover an exact PLAN-001 deployment bundle. The scoped
remote probe also found no candidate files under the experiments tree. This is
a real artifact boundary, not evidence that Qwen cannot be improved.

- [Recovery packet](../experiments/planning/PQ-20260821-008-METADATA-RECOVERY-PACKET-20260821.md)
- [Remaining-field disposition](../experiments/planning/PQ-20260821-008-REMAINING-FIELDS-DISPOSITION-20260821.md)
- [No-found lookup](../receipts/PLAN-20260821-001/pq008-final-artifact-lookup-20260821.json)
- [Latest reconciliation](../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json)

## Evidence and documentation protocol

Every meaningful action gets a durable record in the following order:

1. **Card or plan:** hypothesis, one changed variable, baseline, stop rules.
2. **Preflight receipt:** model/runtime/prompt/data hashes, host/GPU/process/
   storage state, and held-out boundary.
3. **Raw run receipt:** exact argv/environment, per-repetition metrics, logs,
   output hashes, and failure details.
4. **Cleanup receipt:** final GPU/process/storage state and task-owned cleanup.
5. **Review:** adversarial critique plus literature/evidence handoff.
6. **Ledger/wiki:** one dated summary that links every artifact and preserves
   the claim boundary.
7. **Trace:** append one JSON object to `state/inference-traces.jsonl` so the
   decision history is machine-searchable.

Do not overwrite a failed or superseded artifact. Add a dated amendment and
link the old receipt. Keep teacher-forced, acceptance, exactness/content, and
serving-speed evidence in separate fields. A positive cache observation is not
an acceptance result; a lower validation loss is not a serving result.

## Reopening the GPU lane

The next GPU run requires an externally supplied or separately authorized
source-backed bundle containing, at minimum:

- exact Arm-B positions, sequence IDs, mask/cache serialization, anchor and
  rollback semantics, and source/config tie;
- evaluator, logger, finalizer, replay, RNG, and dependency identities;
- resolved device split and the `[171,171]` versus `[170,170]` memory conflict;
- a frozen one-variable intervention, matched target-only control, exactness
  oracle, and complete cleanup/receipt contract.

Until those inputs exist, the correct action is documentation and bounded
artifact recovery—not another precision, n sweep, data expansion, gate, or
guessed runtime flag.

## Canonical navigation

- [Knowledge-base README](README.md)
- [Daily journal](../daily/2026-08-22.md)
- [Results index](../results/INDEX.md)
- [Failures index](../failures/INDEX.md)
- [Experiment queue](../experiments/queue/QWEN-PORTFOLIO-QUEUE-20260821.md)
- [Inference trace](../state/inference-traces.jsonl)

## EXP020 library-identity recovery boundary — 2026-08-22

The approved trace-only recovery stopped before model load: required
`libllama_common` was `d07ed8b4c22e…`, while the active runtime exposed
`65b8a862607e…`. Server and implementation hashes matched, but this mismatch
is a hard provenance gate. Rebuild only from the pinned source/runtime contract
with UI-off, no-model build; verify `d07ed8b4…`, run the matched target-only
phase diagnostic, then restore and verify `65b8a862…`. No source mutation or
held-out use occurred; GPU cleanup was clean. Receipts are the benchmark
contract and hard-stop JSON under `receipts/EXP-20260822-020-qwen-singleton-correction/`.

### Recovery rebuild result (final)

The task-owned rebuild produced `1bbaf7b5…`, not required `d07ed8b4…`; the
hash gate failed before model/GPU execution, so the phase trace remains
unavailable. Source was restored to `c1b1f6f0…`, current library to
`65b8a862…`, and server/implementation identities remained intact. No fit,
export, speed, acceptance, or held-out work started; GPU/process state was
idle. Preserve the EXP020 independent-v23 6/12 negative and PQ019 narrow
cache-positive result as the current evidence boundary.

## Current candidate review — same-library phase trace (2026-08-22)

Planner/runtime review found one conditional, measurement-only candidate:
[`runtime-qwen-exp020-current-library-phase-trace-20260822.md`](../experiments/planning/runtime-qwen-exp020-current-library-phase-trace-20260822.md).
It compares sequential target-only and Q4 n=1 phase intervals through restored
library `65b8a862…`, with margin override disabled and frozen inputs. CEO
approval is required and it has not run; it cannot claim speed, exactness, or
verifier improvement. No other executable source-backed intervention remains.

## EXP021 v22 split-flash build checkpoint — 2026-08-22

The malformed historical patch was semantically reconstructed only for a
candidate-only diff (`graph.diff` SHA `2c7d45d6…`, `server.diff` SHA
`94d41382…`; clean source hashes `751c7ce4…`/`43551af0…`). The first `/dev/shm`
build hit the `noexec`/UI-download hard stop at 8%; the UI-OFF/OFF retry still
left `LLAMA_BUILD_APP=ON`, hit missing embedded assets/permission denied at
38%, and ran no model or GPU inference. A source-backed preseed recipe and
frozen manifest are recorded in the EXP021 card. A fresh `/workspace` preseed
build is around 25%, with no network/model/GPU or numeric result yet.

### EXP021 preseed build success

The exact old UI tree preseed completed a build-only run: 140 files,
12,951,994 bytes, manifest SHA `e811817a…`; `llama-server` SHA `b17850bc…`,
Build ID `22ecf3ea…`, implementation/common/llama hashes
`605d798e…`/`19fdf005…`/`fdb0bc83…`. No network, model, server launch, GPU,
exactness, or timing run occurred. Exactness-first execution remains pending;
the two earlier UI hard stops remain historical evidence.

Literal configure/build provenance is now closed by `preseed-argv-receipt.md`:
exact UI preseed copy, CUDA-86 configure with both UI flags OFF, and named
`llama-server -j2` build all returned 0. UNKNOWN cwd/environment fields remain
explicitly UNKNOWN. This is build-only provenance; exactness remains pending.

### EXP021 exactness result — terminal negative

Target-only was stable across six prompts (227 tokens/run; 16.0559/16.0593/
16.0534 tok/s). Same-build Q4 split-OFF failed exactness on `code_python_debug`
(target `0f76b6ae…` vs Q4 `1d5020bf…`, both 64 tokens/`length`; 104/118
accepted). Split-ON was not launched. No candidate timing, acceptance, or
general speed claim is authorized; raw 28-file receipts and cleanup are kept.

Read-only reconciliation confirms shared contract/prompt/model/server tuple,
nmax=1, block 8, n_extract=5, cache off; only `code_python_debug` differs at
character 194 (`-1` backticks omitted), while five prompts match. Token index,
seed/sampler/client argv are UNKNOWN. Historical v22 747 versus current 531
prompt tokens proves rendering/runtime drift; its 6/6 is stale. Split-ON stays
unrun and terminal; no rerun is authorized.

Rendering reconciliation receipt `ef5ab675…` binds raw source `f911c7d3…`
(5,246 bytes, 12 records/6 IDs), contracts, seed/greedy settings, and models.
Current prompts total 531 tokens; historical v22 totals 747, exactly +36 each.
Rendered bytes, token IDs, tokenizer/template artifact, and historical argv are
UNKNOWN. Historical 6/6 is stale; no GPU/rerun/retuning.

Artifact lookup receipt `f4bf8b4b…` is terminal no-found: only one historical
rendered hash (`a83e3752…`, code_python_debug) exists. Six rendered bytes/token
IDs, tokenizer/model-template artifacts, historical argv, special-token policy,
and exact +36 mapping are absent. Runtime obtains the model chat template.
Reopen only with an external authoritative bundle; no GPU/rerun.

Post-EXP021 source/runtime audits conclude `NO-CANDIDATE`: the only admissible
next action is external rendering/Arm-B provenance recovery. No local source
axis, split-ON launch, GPU rerun, or guessed state/mask/rollback change remains.

## Post-EXP021 recovery ranking

Recovery is docs-only: external rendering/evaluator/Arm-B contract intake first;
optional current-library phase measurement second; causal GPU work deferred.
Source recheck is `NO-CANDIDATE`; PQ019 remains a narrow cache-serving result.

Current-state recovery explains +36 historical tokens via the xhigh reasoning
preamble in one preserved `code_python_debug` render. Inventory `17d01aad…`
finds 12 artifacts all for that prompt/hash `a83e3752…`; no six-row bundle,
token IDs, argv, or current rendered bytes exist. External bundle only; no GPU.

Current-client receipt `04481e84…` confirms raw-message POSTs without
`reasoning_effort`, rendered prompt, or token IDs; only `trace_one_prompt_v22.py`
calls `/apply-template` and requires a loaded model. Readiness `5c08e46…`
requires separate authorization for six-row capture; no endpoint/model/GPU.

Source-verified `/tokenize` preflight `8d0c8f0c…` confirms IDs can be recovered
after `/apply-template` on a loaded target. Amended packet `21f4bc87…`
authorizes one CPU-only six-row render+tokenize capture only: no generation,
GPU, drafter, or split-ON. Preserve hard-stop `0ae0c510…`.

## EXP021 capture-r2: six-row render/tokenize provenance closed (2026-08-22)

Capture-r2 passed as metadata-only evidence. Authoritative files are
`receipts/EXP-20260822-021-readonly-render-capture-20260822/capture-r2.json`
(SHA-256 `cdab75d710a9de052bb3b1a2c51f964032e6697115e7dd1611e7ffdc1cdc45d7`)
and `capture-r2-receipt.json` (SHA-256
`ccc5f3da5f80c51d2537e22fe2bcb381dbe38e55c53e45b3be75afd8b36d4870`).
The six ordered rows are `code_python_debug`, `code_rust_parser`,
`math_modular`, `logic_schedule`, `technical_explain`, and `structured_extract`.
Rendered bytes/tokens are respectively `752/169`, `589/122`, `592/115`,
`572/111`, `523/96`, and `640/134` (747 total). Each row records rendered
prompt and token-prefix hashes; tokenizer flags are uniformly
`add_special=false`, `parse_special=true`, `with_pieces=true`.

The capture used the original CPU tracer/server identity (`llama-server` SHA
`5c43b9437a362d5a3cd29725ae61b0edca24a7fb27a3b92c426f29c1a6dc03ac`, CUDA
disabled), not the EXP021 benchmark binary (`b17850bc…`) that produced the
older 531-token path. Do not mix these contracts. The full six-row capture
closes the +36-token historical drift as an observable rendering/tokenizer
fact, but does not repair or reinterpret the EXP021 split-OFF mismatch. It
made zero completion/generation/drafter/verifier/timing requests; server
termination, GPU idle, and cleanup were verified. No split-flash, acceptance,
speed, or general-losslessness claim is authorized.

## EXP021 final Stage-0 handoff (2026-08-22)

Handoff packet `96820b66…` and queue reconciliation `080f9042…` retain the
Stage-0 six-of-six CPU equivalence and define a strictly conditional GPU
sequence. CEO approval and a live read-only preflight are still pending. If
approved, run one process at a time: (1) target-only b178 oracle on six frozen
prompts, (2) same-build Q4 split-OFF control, then (3) split-ON only after
both controls are six-of-six exact. Freeze target/drafter/render manifest,
cache/context/seed/settings and change only the split-flash flag. Any target
instability, split-OFF mismatch, identity/argv drift, resource or cleanup
failure hard-stops the sequence. No GPU result, timing, acceptance, or
split-flash claim exists yet; timing is diagnostic only after exactness.

The repaired Stage-0 packet (`PQ-20260822-021-EXACTNESS-REOPEN-R2`, SHA
`1a9e3f78…`) and alignment receipt (`4a736a15…`) make the next boundary
explicit: r2 validates six rows/747 tokens only on the old `5c43…` tracer.
Before any target-only, split-OFF, or split-ON GPU arm, the `b178…` EXP021
candidate must reproduce all six rendered bytes, token IDs/pieces, counts,
argv/linkage, and source/build identities. This is a no-run gate; a Stage-0
mismatch terminalizes the packet. No split-flash result is implied.

## EXP021 Stage-0 b178 candidate equivalence passed (2026-08-22)

The repaired packet's Stage-0 CPU-only candidate check passed six-of-six.
Receipts are `stage0-b178-candidate.json` SHA
`8f74cf645ae0705cac55444de81f4d3cd75bf683f9ec914d576e3cb13d5580a5` and
`stage0-b178-receipt.json` SHA
`2e1d50b5b607bdfa2f77be42d57181a66d1bd57a01557d6e85975811ad63892a`.
The b178 candidate exactly matched the r2 reference manifest, target, ordered
rows, rendered bytes/SHA, token IDs/pieces/counts, and apply/tokenize payload
hashes for all six rows. Render hashes (in order) are
`a83e3752…`, `97aabb92…`, `a374606b…`, `27400339…`, `ab472707…`,
`cc5d2c6d…`; token counts are `169,122,115,111,96,134` (747 total).
Tokenizer flags remain `add_special=false`, `parse_special=true`,
`with_pieces=true`; resolved library hashes and full IDs are preserved in the
receipt. Six apply-template + six tokenize calls completed; completion,
generation, drafter, verifier, and timing calls were zero. Server termination,
no remaining server, GPU idle, and cleanup passed.

This is provenance equivalence only. The receipt explicitly stops before
target oracle, split-OFF, split-ON, timing, or GPU work; no split-flash or
serving result is implied.

## EXP021 CEO-authorized launch boundary (2026-08-22)

Final packet `9d8c5add…`, live read-only preflight `14ac6bf2…`, literature gate
`d448cb6e…`, and critic final authorize the bounded exactness sequence. The
explicit 747-token tracer path is frozen: `/apply-template` then `/completion`
through fresh b178 and resolved libraries; do not use the 531-token benchmark
client or mix contracts. Execution is now running sequentially: target-only
oracle, then same-build Q4 split-OFF, then split-ON only if both are six-of-six
exact. One GPU process at a time; any mismatch/token drift/identity or cleanup
failure stops later arms. No numeric result is available yet, and no timing,
acceptance, or split-flash claim is made before gates pass.

## EXP021 corrected-tracer exactness screen: terminal negative (2026-08-22)

The authorized corrected-tracer run completed target-only six-of-six stable,
then Q4 `n=1` split-OFF. Split-OFF diverged on `code_python_debug` and
`logic_schedule`; each target and Q4 output reached 64 tokens with `length`
termination. Raw, summary, stop, terminal, and cleanup receipts are preserved
under `receipts/EXP-20260822-021-qwen-v22-split-flash-n1/`.

Per the exactness-first gate, split-ON was not launched and no candidate
timing, acceptance, speed, or causal split-flash claim is valid. This is a
corrected-tracer evaluator/runtime negative for the tested tuple, not evidence
that split-flash itself caused either mismatch. Preserve the 747-token
contract and do not mix the 531-token benchmark path.

Final-run accounting refines the negative: target-only was stable 6/6 at 747
prompt tokens; Q4 split-OFF rendered hashes all matched, but only 4/6 outputs
were exact. First divergences were token 50 for `code_python_debug` (accepted
30/33) and token 37 for `logic_schedule` (accepted 27/35); both reached the
64-token limit. Split-ON and timing were not run; GPU/process cleanup was
clean. This is a split-OFF control failure, not a split-flash result.

### Superseding contract-violation correction

Planner terminal packet `9ea4c80a…`, queue `70d65736…`, and data receipt
`b3c1e8db…` supersede the apparent final-run result: copied raw requests are
531-token no-xhigh prompts (`133/86/79/75/60/98`), not the required 747-token
tracer. Preserve `0c98f7d` summary/terminal as stale contradictory history;
the apparent 6/6 and 4/6 are invalid exactness evidence. No rerun or split-ON.
Reopen only with a literal launch command enforcing the tracer, and bind all
747 rendered hashes/IDs through `/completion` before any new gate.

Raw-contract audit receipts `a1fcc5cc…` (JSON) / `2f2a5d67…` (note) confirm
every final-run JSON used benchmark/completion with pre-rendered 531-token
prompts; no `/apply-template`, `/tokenize`, or tracer evidence exists. Outputs
are valid only for the 531-token tuple, not 747 exactness. No rerun/GPU work.

Launch-contract audit `4f897f4039ed88f0a9cb2ea3020ed4ae5fae2fb14bb53b479b72429b28f65b92`
confirms executor argv/selection is UNKNOWN and raw route is 531/no-xhigh.
Recovery is fail-closed: six `/apply-template` + six Stage0-flagged
`/tokenize` calls must pass all hash/ID/count and total-747 assertions before
any `/completion`; wrong route hard-stops with zero generation. No wrapper was
written/executed or rerun performed. Split-ON/speed remain prohibited.

## Repaired wrapper and live v22 CPU identity gate (2026-08-22)

Wrapper implementation SHA `01f937e5…`, tests SHA `6828fb70…`, and planner
packet `ddf7e99a…` are receipt-backed. Live v22 CPU identity receipt
`c398d7f1…` binds capture `322ab37f…`, explicit contract v22 `a69610f9…`,
b178, and Stage0 six-of-six/747. Six apply-template + six tokenize calls
passed ordered-row, rendered-byte/hash, token-ID/piece/count, and payload-hash
assertions (169/122/115/111/96/134). Completion/generation/benchmark/GPU/
timing calls were zero; cleanup and GPU idle passed. CPU identity only;
completion/GPU arms remain separately gated.

## EXP021 target-only final oracle (2026-08-22)

Target-only is a valid v22 oracle. Summary SHA `d1a9ff6d…`, terminal note
`7b1ce0c1…`; contract `a69610f9…`, b178/target/tracer/manifest pinned. Four
repetitions across six rows passed all 747 Stage0 assertions; outputs were
6/6 byte-identical across repetitions. Finish was `technical_explain=eos`, all
others `limit`; `cache_n=0`. Diagnostic tok/s were 18.9016, 18.6411, 18.8415,
18.8491. Cleanup receipt `91d1a65f…` confirms clean GPU/process state. No
candidate arm ran; this validates the oracle only, not a speed promotion.
Split-OFF remains gated.

## EXP021 Q4 split-OFF hard-stop (2026-08-22)

Summary SHA `94170d0a…`, terminal `9b24d3dc…`: valid v22 747-token Stage0
contract, b178 + pinned Q4 drafter, split env explicitly unset. Warmup row
`code_python_debug` differed immediately: Q4 SHA `6400f118…` vs target oracle
`a382e0c0…`; 31/31 draft accepted, 64-token `limit`, 3007.86 ms. Hard-stop
prevented remaining rows, timing, and split-ON. GPU/process cleanup passed.
Classify as baseline/evaluator mismatch, not split-flash evidence or speed.
