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
