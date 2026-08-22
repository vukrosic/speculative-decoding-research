# Current state

Updated: 2026-08-22

## Latest superseding addendum — 2026-08-22

Some paragraphs below are preserved pre-run planning language. They describe
the state before PQ-019 was executed and should not be read as the latest
status. The registered PQ-019 repeated-prefix screen subsequently completed
once: target-only cache-on moved from `16.0895` to `17.8801` tok/s, Q4 n=1
cache-on moved from `18.1639` to `21.7631` tok/s, and cache-on reported
positive reuse (`1,014` cached prompt tokens per timed repetition). Q4
acceptance stayed `208/236`; rendered/token-prefix hashes and strict token-ID
exactness remain UNKNOWN. This is a local prompt-cache effect, not a general
speculative-decoding speedup.

The active post-PQ019 boundary is therefore: no repeat cache/precision/fixed-n
run, and no new GPU intervention until an exact source-backed PLAN-001/PQ-008
verifier/state bundle is supplied or separately authorized. The latest
read-only reconciliation and scoped remote no-found probe are linked from the
[experiment wiki](knowledge/EXPERIMENT-WIKI.md).

### EXP-020 singleton-correction diagnostic (2026-08-22)

The active source-backed current-runtime card is
[`EXP-20260822-020-qwen-singleton-correction`](experiments/cards/EXP-20260822-020-qwen-singleton-correction.md).
Its frozen cache-off baseline shows Q4 n=1 at `18.1638816661` output tok/s
versus target-only `16.0895399687` (`+12.892486%`), with 454 completion
tokens on both arms and `208/236` accepted/proposed. Output hashes agree for
5/6 unique prompts (10/12 duplicated rows); `code_python_debug` is the sole
deterministic mismatch across three repetitions, with 64 tokens on each arm.

This is a narrow promising lead, not a promoted result. EXP-020 is
`active-diagnostic`; the activation note intentionally contained no trace
result. The completed trace and bounded causal result are recorded below;
promotion
still requires exact token-ID equality, rejected-boundary localization, fresh
matched throughput, and complete cleanup. Reopening or extending the GPU lane
requires the exact source-backed Arm-B/evaluator/state bundle or a separately
authorized source-backed regeneration with positions/sequence IDs,
mask/cache/anchor/rollback semantics, evaluator/logger/replay/dependency
identity, resolved split, and the `[171,171]`/`[170,170]` conflict resolved.

The completed EXP-020 trace now localizes the first divergence: target-only and
Q4 share an exact 42-token prefix, then differ at output token 43 (`90563`
target versus accepted Q4 draft `471`). The accepted draft is in verifier
cycle 25, after seven one-token rejection/rollback cycles; it is not the
cycle correction token. The machine analysis and parser hashes are recorded
in `receipts/EXP-20260822-020-qwen-singleton-correction/`.

A bounded recurrent-state diagnostic then forced target-only `n_rs_seq=1` and
Q4 n=1 `n_rs_seq=0`. Target-only retained hash `0f76b6ae…` at `18.7416124147`
diagnostic tok/s; Q4 retained divergent hash `1d5020bf…` at `16.3178374758`
diagnostic tok/s. Both produced 64 tokens. Snapshot count/layout and matching
the target-only recurrent-state layout are therefore falsified as the sole
cause. This narrows the next hypothesis to checkpoint contents, block-vs-
singleton numerical state, or another verifier transition; no correction or
speed result is promoted.

The next EXP-020 candidate was calibrated from a full six-public-prompt
raw-margin inventory. A blanket `<0.1` runner-up rule is unsafe because the
already-correct `logic_schedule` decision has margin `0.0897636414`; the
divergent `code_python_debug` decision has margin `0.0684490204` with target
runner-up `90563` versus accepted draft `471`. A frozen default-off threshold
of `0.08` produced exactly one override in a six-prompt smoke, and all six
target output hashes matched.

The corrected matched cache-off speed gate then passed one warmup plus three
timed repetitions per arm. Target-only mean was `16.4723525853` tok/s (SD
`0.0027415161`); corrected Q4 n=1 mean was `18.5307384154` tok/s (SD
`0.0352037718`), `+12.4960039522%`. Each run emitted 227 tokens; corrected
acceptance was `103/118` with one override per run, and every warmup/timed run
matched all six target output hashes. This is a local exact-hash result for
the frozen tuple, not a general losslessness, token-ID, or speed guarantee.

An independent-v23 screen then froze the same `0.08` policy on 12 separate
public validation prompts with no retuning or prompt exceptions. Target-only
reproduced all 12/12 hashes and 625 tokens; corrected Q4 matched only 6/12:
`v23-coding-00126`, `v23-explanation-00005`, `v23-explanation-00095`,
`v23-instruction-00160`, `v23-instruction-00316`, and `v23-reasoning-00170`
diverged. No override events fired. Corrected Q4 measured `19.954249` versus
target `17.659459` tok/s (`+12.994677%` diagnostic only), but the failed
projection gate falsifies generalization. Preserve the six-prompt calibrated
lead as local evidence; do not promote, retune, or add exceptions.

## Best supported observations

- SmolLM: the 10.13M two-layer block-3 DFlash2-style bridge remains the exact
  acceptance incumbent at 7.1566% on the fixed 90-prompt slice, with 90/90
  exact outputs.
- SmolLM capacity: increasing draft depth to 35.40M parameters improved
  teacher-forced loss/accuracy but reduced fixed-slice acceptance to 6.8334%.
- Qwen published drafter: high approximate acceptance (52.58%) and +23.86%
  approximate throughput were observed, but strict greedy identity failed on
  4/6 prompts.
- Qwen custom drafter: v27 curve step 4000 at n=4 is the validation incumbent
  with 5.175% acceptance and 11.476 tok/s, but it is slower than target-only
  17.592 tok/s and is not exact.
- Qwen block-shape alignment: target features differ materially between
  singleton and block-17 execution. A bounded aligned continuation improved
  teacher-forced accuracy but not acceptance.
- Qwen drafter precision at fixed n=1: Q4_K_M and Q8_0 were effectively tied
  (16.0923 vs 16.0878 tok/s; 0.028% difference), both slower than target-only
  (17.4025 tok/s), with identical 98/508 acceptance in the frozen screen.
- Prompt-cache semantics are source-backed (`--cache-prompt`, client
  `cache_prompt`, and `timings.cache_n`), but no positive cache-hit workload
  has been run; the current prompt manifest lacks registered repeated-prefix
  groups, order, reset boundaries, and expected hit counts.

## Claims not supported

- No exact Qwen DFlash speedup is established.
- No evidence shows that lower loss alone improves acceptance.
- No evidence shows that larger or smaller draft capacity alone solves the
  current bottleneck.
- No sealed held-out claim exists for the custom Qwen v27-v31 candidates.
- Q4-vs-Q8 precision at n=1 did not produce a speedup; exactness/content
  fields were unavailable in the frozen wrapper.
- A read-only PQ-012 analysis found aggregate Q8 n=1 draft/decode/prompt
  counters, but no per-component draft/target/cache/scheduler timings or
  exactness/argv binding; it is a measurement-gap negative, not a causal
  overhead result.
- A read-only PQ-013 analysis found heterogeneous per-prompt Q8 n=1 wall
  deltas, but the 12-prompt slice has no held-out policy split and the
  preserved client has no source-backed per-request mixed-mode switch; the
  prompt-gate idea is terminalized as a docs-only hypothesis.
- PQ-019 cache-on is not a speed result. Planner, runtime, critic, and
  literature artifacts agree that enabling the flag on the existing unique
  prompt screen would not establish cache reuse or speculative-decoding speed.

## Current research posture

The next work should maximize information about contiguous-prefix acceptance
and verifier/runtime fidelity while preserving frozen validation and sealed
held-out controls. Precision at n=1 is retired for this configuration; the
next candidate is verifier/state or runtime-overhead localization. New remote
work requires explicit authorization.

PQ-013 is not an executable exception: reopening requires a source-backed
mixed-mode launcher/client contract plus a source-disjoint calibration/
held-out manifest and predeclared threshold. No GPU run is authorized from
the current prompt-gate evidence.

The post-PQ-013 portfolio audit found no remaining source-backed executable
Qwen acceptance/speed candidate. PQ-014 records this as a terminal queue
disposition; the next permissible action is exact artifact recovery or a
separately authorized new contract. Blind sweeps, guessed runtime flags,
threshold fitting, and model/data mutations remain out of scope.

The PQ-015 cache preflight confirmed the flag semantics and zero cached tokens
in existing runs, but found no positive reuse receipt or repeated-prefix
contract. Prompt-cache toggling is therefore also terminal no-run for the
speculative-decoding objective.

PQ-016 now enumerates the exact artifacts that can reopen GPU work: the
deployment verifier bundle, a mixed-mode selector bundle, or a repeated-prefix
cache bundle. PQ-019 has a source-backed four-arm design, but its current
status is `conditional-blocked-repeated-prefix-manifest`; no cache-on GPU run
is approved until that manifest and a fresh CEO decision exist.

PQ-015 compared two recovery paths and rejected both for GPU execution:
counterfactual gating is not online serving evidence, while prompt-cache
enablement lacks a cache-state/repeated-prefix contract and does not isolate
speculative decoding. The next recovery action is read-only artifact
verification; no experiment is approved until that contract is source-backed.

PQ-017 refreshed the live remote state at `2026-08-21T21:57:10Z`: host
`9719ca4634c7`, RTX 3060 idle at 1 MiB/0%, no task processes, and
2,144,796,672 bytes free. The external artifact blocker is unchanged; this is
a dated state receipt, not a speed or model result.

The 2026-08-22 cache decision is preserved in
[`PQ-019 decision review`](experiments/planning/PQ-20260821-019-CACHE-ON-N1-DECISION-REVIEW-20260822.md)
and [`readiness.json`](receipts/PQ-20260821-019-cache-on-n1-20260822/readiness.json).
It records no SSH mutation, model load, inference, held-out access, flag
toggle, or GPU action.

### PQ-019 reconciliation addendum (2026-08-22)

The earlier Q8 wording is superseded. The selected cache diagnostic is
target-only/Q4_K_M at fixed n=1, using the exact v21 Q4 artifact and a
byte-identical six-prompt v20 source duplicated into 12 cold/warm rows. The
source contract is `4be899…`; the n=1 cache-off derivative is `d14ee941…`
(`draft_tokens_max 7→1`), and cache-on is `50c3a875…`
(`prompt_cache false→true`). The canonical local identity/workload receipt is
[`canonical-contract-workload-preflight.json`](receipts/PQ-20260821-019-cache-on-n1-20260822/canonical-contract-workload-preflight.json).

This closes only the local contract/workload repair. Fresh remote artifact,
resource, and prompt-rendering/prefix-hash checks remain pending; no cache-on
GPU result exists.

The artifact/resource portion is now read-only verified: exact v21 Q4
`18a380…` (1,143,006,752 bytes), idle RTX 3060 (1 MiB/0%), and
2,144,796,672 free workspace bytes. The stale v30-Q4 receipt (`2a7828…`) is
preserved but superseded. Five rendered/token-prefix hashes remain UNKNOWN,
so no cache-on GPU run is authorized yet.

PQ-019 subsequently completed as a bounded cache-cost diagnostic. Within the
registered repeated-prefix workload, target-only cache-on was 17.8801 vs
16.0895 tok/s off (+11.13%), and Q4 n=1 cache-on was 21.7631 vs 18.1639 off
(+19.82%). Positive cached-token counters and unchanged Q4 208/236 acceptance
were observed; output/content hashes matched within cache pairs. This is local
prompt-cache evidence only. Rendered/token-prefix hashes and strict exactness
remain UNKNOWN, so no general speculative-decoding speed or losslessness claim
is established. See `receipts/PQ-20260821-019-cache-on-n1-20260822/` and the
post-run critique; focus returns to verifier/state localization.

### Post-PQ019 active boundary (2026-08-22)

The active goal remains Qwen speculative-decoding improvement on the RTX 3060.
The post-PQ019 planner/critic/literature/runtime audit found no new
source-backed GPU candidate. The next action is a recovery of the exact
PLAN-001/PQ008 deployment/evaluator/state contract, not another cache or
precision sweep.

The read-only reconciliation receipt
`receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json`
(SHA `945548c5…`) closes several oracle/evaluator fields but leaves exact
Arm-B serialization/source tie, complete logger/replay/dependency identity,
explicit split, and the `[171,171]`/`[170,170]` conflict unresolved. The live
GPU state receipt
`receipts/PQ-20260821-019-cache-on-n1-20260822/live-state-check-20260822.json`
(SHA `7b1dd3cb…`) records the RTX 3060 idle and no task process. No new GPU
experiment is approved until one exact source-backed recovery input arrives.

The scoped remote artifact probe at `2026-08-21T23:11:33Z` found no
PLAN-001/Arm-B/replay/logger/evaluator candidate files under the remote
experiments tree. Receipt:
`receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-20260822.json`
(SHA `f0b244bc…`). The external artifact blocker is therefore confirmed again;
no broader search or GPU mutation is authorized.

The follow-up probe at `2026-08-21T23:21:26Z` extended the same read-only
search to depth seven and included verifier filenames. It again found no
candidate paths; the RTX 3060 remained idle at 1 MiB/0%/55 C with no task
process. Receipt:
`receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-r2-20260822.json`
(SHA `6bffd9b3…`). This is a stronger no-found recovery boundary, not a
scientific negative about Qwen's potential.

The content-level follow-up at `2026-08-21T23:26:49Z` found only historical
logs/build/runtime matches in its broad pass and zero source/config/planning
matches after narrowing. Receipt:
`receipts/PQ-20260821-019-cache-on-n1-20260822/remote-content-probe-r3-20260822.json`
(SHA `63768b01…`). The scoped recovery path is exhausted; only external
artifact supply or separately authorized regeneration can reopen the GPU lane.

The planner, critic, runtime, and literature reviews now agree on this r3
boundary. Their consensus receipt is
`receipts/PQ-20260821-019-cache-on-n1-20260822/r3-lane-review-receipt-20260822.json`.
No new one-variable Qwen acceptance/speed run is admissible until the exact
Arm-B/evaluator/state bundle is supplied or regenerated under a new
authorization.

### EXP020 library identity recovery (2026-08-22)

The target-only phase diagnostic hard-stopped before model load because active
`libllama_common` `65b8a862607e…` did not match required historical identity
`d07ed8b4c22e…`; server and implementation hashes matched. This is a
provenance/build mismatch, not a Qwen quality or speed result. Rebuild only
from the pinned source/hash contract with no-model boundaries, verify the
historical bytes, run trace-only control, then restore and verify the current
library. Do not infer numeric trace outcomes until that gate passes.

The final recovery receipt confirms the rebuild hash `1bbaf7b5…` still differs
from required `d07ed8b4…`; no model or GPU trace ran. Source `c1b1f6f0…`,
library `65b8a862…`, server, and implementation were restored/verified. The
phase trace is unavailable; prior EXP020 6/12 independent-v23 and PQ019 cache
results remain bounded and unchanged.

### Current candidate review

The only admissible next measurement is the planner-PASS, CEO-approval-gated
same-library EXP020 phase trace: target-only versus Q4 n=1 through restored
`65b8a862…`, margin override disabled, identical frozen inputs. It has not run
and is diagnostic only; no speed, exactness, verifier, or source intervention
claim is authorized. All other source-level improvement ideas remain blocked.

### EXP021 v22 build checkpoint

Observed: malformed historical patch reconstructed as candidate-only graph/
server diffs; `/dev/shm` UI-download/noexec hard stop at 8%; explicit UI-OFF/OFF
retry hard stop at 38% because `LLAMA_BUILD_APP=ON` still required missing
embedded assets. Pending: source-backed asset preseed with exact frozen
manifest and a fresh `/workspace` build currently near 25%. No model, network,
GPU inference, exactness, or timing result exists.

The preseed build now succeeds build-only with manifest `e811817a…` (140 files,
12,951,994 bytes), server `b17850bc…`, and Build ID `22ecf3ea…`.
Implementation/common/llama hashes are `605d798e…`/`19fdf005…`/`fdb0bc83…`.
No network/model/GPU execution occurred; exactness and timing remain pending.

Literal argv provenance now closes the preseed build: exact UI copy, CUDA-86/UI
OFF configuration, and named `llama-server -j2` build returned 0. No inference
claim follows; six-prompt exactness remains pending.

EXP021 exactness is now terminal-negative: stable six-prompt target-only
control, but same-build Q4 split-OFF mismatched `code_python_debug` (64 tokens,
`length`, 104/118 accepted). Split-ON was not launched. No candidate timing,
acceptance, or general speed claim is valid; raw receipts and cleanup remain.

Read-only mismatch reconciliation finds one concrete punctuation difference at
character 194 in `code_python_debug`; five prompts match. Shared tuple fields
are bound, but token index and seed/sampler/client argv remain UNKNOWN.
Historical v22 prompt tokens 747 versus current 531 indicate rendering/runtime
drift, so old 6/6 is stale. Split-ON remains unrun; no rerun.

Rendering reconciliation binds raw prompt source and contracts but finds a
constant +36-token historical offset per prompt (747 vs current 531). Rendered
bytes, token IDs, tokenizer/template artifact, and old argv are absent, so old
6/6 is stale. This remains read-only; no GPU or rerun.

Artifact lookup is terminal no-found: only one historical rendered hash
`a83e3752…`; all six rendered bytes/token IDs, tokenizer/template artifacts,
historical argv, special-token policy, and exact +36 mapping are absent. Runtime
gets the model chat template dynamically. Reopen only with an external bundle.

Post-EXP021 source/runtime audits are terminal `NO-CANDIDATE`: no independent
GPU axis remains. Highest-value recovery is exact rendering/Arm-B provenance;
until an external bundle supplies it, no state/mask/rollback/scheduler guess,
rerun, or split-ON launch is allowed.

Post-EXP021 ranking is recovery-first and docs-only: external rendering/Arm-B
contract intake is highest information; optional phase measurement is diagnostic;
causal GPU work is deferred. Source recheck is `NO-CANDIDATE`.

Read-only recovery explains +36 historical tokens via the xhigh reasoning
preamble in one preserved `code_python_debug` render. Inventory finds 12
artifacts all for that prompt/hash; six-row/current rendered bytes, token IDs,
argv, and template identity remain UNKNOWN. No GPU/rerun; external bundle only.

Current client sends raw messages and does not render/save tokens; `/apply-template`
exists only in the model-loading tracer. Six-row capture requires separate
authorization, not no-model preflight. No endpoint/model/GPU/rerun.

`/tokenize` preflight `8d0c8f0c…` is verified; amended packet `21f4bc87…`
permits one CPU-only six-row `/apply-template`→`/tokenize` capture. No
completion/generation, GPU, drafter, or split-ON; retain hard-stop `0ae0c510…`.

Capture-r2 passes the authorized six-row CPU-only render/tokenize gate.
Receipts: `capture-r2.json` SHA `cdab75d7…`; metadata receipt SHA
`ccc5f3da…`; manifest SHA `77a9b570…`. Ordered rows are
`code_python_debug`, `code_rust_parser`, `math_modular`, `logic_schedule`,
`technical_explain`, `structured_extract`, with rendered bytes/tokens
`752/169, 589/122, 592/115, 572/111, 523/96, 640/134` (747 total).
All rows use `add_special=false`, `parse_special=true`, `with_pieces=true` and
carry rendered/token-prefix hashes. This closes the observed +36-token drift
as a metadata fact. Identity caveat: r2 used original `5c43b943…` tracer/server;
EXP021 used `b17850bc…` benchmark path and 531-token contract. Do not combine
them. No completion/generation, GPU, split-flash, acceptance, speed, or general
claim; cleanup and GPU idle passed.

Repaired Stage-0 packet SHA `1a9e3f78…` plus alignment receipt `4a736a15…`
freeze the recovery boundary: r2's six rows/747 tokens are valid for old
`5c43…` only. The `b178…` EXP021 candidate must first match all six bytes,
IDs/pieces/counts and identity/argv linkage. Until that CPU-only equivalence
gate passes, no target-only, split-OFF, split-ON, GPU, or timing run is allowed.

Stage-0 b178 equivalence now passes six-of-six. Candidate receipt SHA
`8f74cf64…`; metadata receipt SHA `2e1d50b5…`; packet SHA
`1a9e3f78…`. All six r2 rows matched manifest/target/order, rendered bytes and
SHA, token IDs/pieces/counts, and apply/tokenize payload hashes. Ordered render
hashes are `a83e3752…`, `97aabb92…`, `a374606b…`, `27400339…`, `ab472707…`,
`cc5d2c6d…`; counts are `169,122,115,111,96,134`. Flags are
`add_special=false`, `parse_special=true`, `with_pieces=true`; six apply + six
tokenize and zero generation/timing calls. Cleanup terminated the server and
verified GPU idle. The receipt stops here: target oracle, split-OFF, split-ON,
timing, and GPU remain unrun pending final planner/critic/literature gate.

Final Stage-0 handoff packet `96820b66…` / queue `080f9042…` is ready but not
approved: CEO approval plus live read-only preflight remain pending. Conditional
sequence is target-only b178 oracle → same-build Q4 split-OFF → split-ON only
after six-of-six exact controls, one process at a time. Any instability,
mismatch, identity/argv drift, resource or cleanup failure stops the sequence.
No GPU, split-flash, acceptance, or timing result is present.

CEO launch packet `9d8c5add…`, live preflight `14ac6bf2…`, literature gate
`d448cb6e…`, and critic final have authorized the bounded run. The 747-token
tracer path is explicit and must not mix with the 531-token benchmark path.
Target-only is running, followed by split-OFF and conditional split-ON only
after six-of-six exactness. No numeric result yet; one process and hard-stop
gates remain in force.

Terminal corrected-tracer screen: target-only was stable six-of-six; Q4
split-OFF mismatched `code_python_debug` and `logic_schedule`, both at 64
tokens/`length`. Split-ON and timing were not run. Raw/summary/stop/cleanup
receipts are preserved; no causal split-flash, acceptance, speed, or general
claim is supported. Treat this as a tuple-bound evaluator/runtime negative.

Final-run accounting: target-only 6/6 stable at 747 prompt tokens. Q4
split-OFF rendered hashes all matched but exact outputs were 4/6; first
divergences were `code_python_debug` token 50 (accepted 30/33) and
`logic_schedule` token 37 (accepted 27/35), both at the 64-token limit.
Split-ON/timing were not run; GPU/process cleanup was clean. Classify this as
a split-OFF control failure, not split-flash evidence.

Superseding planner packet `9ea4c80a…`, queue `70d65736…`, and receipt
`b3c1e8db…` classify the copied final raw run as a 531-token no-xhigh contract
violation, not a valid 747 result. Preserve `0c98f7d` as stale contradictory
history; apparent 6/6 and 4/6 exactness are invalid. No rerun or split-ON.
Reopen only with literal launch/tracer enforcement and 747 hashes/IDs bound
through `/completion`.

Raw-contract audit `a1fcc5cc…` / `2f2a5d67…` confirms final JSONs are
benchmark/completion generations with pre-rendered 531-token prompts; no
apply-template/tokenize/tracer evidence. They cannot support 747 exactness.
No rerun or GPU work.

Launch audit `4f897f40…` leaves executor argv UNKNOWN and confirms raw
531/no-xhigh route. Fail-closed recovery requires six apply-template + six
Stage0-tokenize hash/ID/count checks and total 747 before any completion;
wrong route yields zero generation. No wrapper, rerun, split-ON, or speed.

Repaired wrapper `01f937e5…` with tests `6828fb70…` and packet `ddf7e99a…`
passed live v22 CPU identity. Receipt `c398d7f1…` binds capture `322ab37f…`,
contract v22 `a69610f9…`, b178, and Stage0 six-of-six/747. Six apply + six
tokenize passed; zero completion/GPU/timing, cleanup and GPU idle passed.
Completion/GPU work remains separately unauthorized.

Target-only final oracle is valid: summary `d1a9ff6d…`, terminal `7b1ce0c1…`,
v22 contract `a69610f9…`, b178 pinned. Four reps × six rows passed all 747
assertions and were byte-identical 6/6; finish technical=eos, others=limit,
cache_n=0. Diagnostic tok/s 18.9016/18.6411/18.8415/18.8491. Cleanup
`91d1a65f…` and GPU/process state are clean. No candidate arm; oracle only,
not speed promotion; split-OFF remains gated.

Q4 split-OFF hard-stopped on warmup `code_python_debug`: summary
`94170d0a…`, terminal `9b24d3dc…`; Q4 SHA `6400f118…` vs oracle
`a382e0c0…`, 31/31 accepted, 64-token limit, 3007.86 ms. v22 747 Stage0
passed for the first row; no further rows/timing/split-ON. GPU/process clean.
This is baseline/evaluator mismatch, not split-flash evidence.

Authoritative reconciliation `50e7832c…` supersedes contaminated 531 receipt
`d119ff45…`: valid 747 row diverges at token 2 (target 760 vs Q4 248069),
duplicate `</think>`, 31/31 accepted, cache_n=0, 64/limit. Localization
`3b66872b…` / `0bc83dcc…` is observational only; candidate branch inactive,
no causal patch/rerun, split-ON, or timing.

Literature verdict `cc007b73…` terminalizes this candidate branch for the
747 packet—not as split-flash evidence. Split-ON/timing are prohibited.
Reopen requires the immutable first-divergence/evaluator bundle, then fresh
oracle plus six-of-six same-contract split-OFF exactness. Stale 531 data stays
separate and invalid.

Mapping execution `9d16cbcf…` / note `48920f0f…` binds exact symbols/offsets
and source lines. DWARF is absent (`addr2line ??`), split-off hunks are
unreachable, and duplicate marker origin/rollback branch are UNKNOWN. No
repair/rerun/GPU; terminal boundary remains pending review.

Postreview planner/queue `e10285cb…`/`a25db317…`, critic `40a8174b…`, and
literature `d8cc9594…` mark partial provenance PASS, causal repair
BLOCKED/terminal. No DWARF/debug map or token transaction trace; reopen
requires exact BuildID-matched debug/linker map plus token/logit/commit/rollback
evidence. No GPU, rerun, or patch.

Search receipt `b94030f…` (planner `f43d01f…`, queue `aad39d7…`, literature
`17195aba…`) found exact b178 unstripped ELF only; no b178 DWARF/.map/core or
token trace. Historical `080fe7cf…` attn_pregate-3 is non-b178 hypothesis
(`983a51ee…`/`f4919bb6…`). No candidate/repair/rerun/GPU.

Q_len/attention screen `58b7fe15…` / runtime `d8aee23f…` is NO-CANDIDATE;
historical attn_pregate remains hypothesis-only. No patch/GPU. Reopen requires
exact Arm-B state/rollback, 747 rendering/token IDs, and immutable token/logit/
acceptance/transaction evidence; split-OFF remains terminal.

Final q_len reviews `fa22970b…`/`8e7b57d1…`, critic `2deb8fd9…`, literature
`b35356fd…` keep NO-CANDIDATE. Reopen only with authoritative Arm-B/rendering/
evaluator 747 contract or exact b178 token/logit/accept/rollback trace. No
GPU/build/rerun.

External intake `c48ab5f…`/`c177ef7…`, literature `8c1e9e3…`: reopen requires
Arm-B/rendering/evaluator 747 or exact b178 BuildID, rendered/tokenizer
artifacts, immutable token/logit/accept/rollback/cache trace, and literal
argv/env/library hashes. No GPU/rerun; attn_pregate unbound.

Idle closeout `7022e301…`/`9a027bb5…`: RTX3060 1 MiB/0%, no processes,
1.5 GB workspace free; stale PID markers only. No-run/external-intake boundary.
