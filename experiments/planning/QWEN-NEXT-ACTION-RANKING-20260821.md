---
id: QWEN-NEXT-ACTION-RANKING-20260821
date: 2026-08-21
status: documentation-only
scope: existing-proposals-only
---

# Qwen next-action ranking

This is a documentation-only portfolio ranking of the four existing Qwen
proposals. It does not create a card, change a status, authorize a run, or
promote any proposal. Ranking combines expected information gain with the
amount of preserved evidence that can close the next gate without execution.

## Ranking

| Rank | Proposal | Why this is the next useful lane | Current dependency / boundary |
|---:|---|---|---|
| 1 | PLAN-20260821-001 verifier/shape localizer | Highest information gain per documentation action: it can localize the strict mismatch and protect all later training decisions from an invalid evaluator contract. The remaining work is a finite contract/receipt mapping, not a new causal hypothesis. | Preserve LIT-20260821-001 and v20–v22 source/receipt evidence; evaluator tuple, Arm-B shape/mask/cache fields, tokenizer/runtime identities, and drafter identity remain required. Current status stays BLOCKED; no comparison is authorized. |
| 2 | PQ-20260821-002 prefix objective | The objective math, lineage, controls, and receipts are already specified, so it is the most mature training follow-up once an implementation exists. The inventory found no admissible candidate, making the next step governance/identity work rather than fitting. | Existing additive implementation card, critic review, and CEO amendment. Current status stays deferred/blocked before fit; no ephemeral wrapper or substitute candidate. |
| 3 | PQ-20260821-004 confidence-gated length | Runtime-only scheduling could answer a useful overhead question, but the pinned DFlash2 runtime has no confidence score, threshold, or selector. Pursuing it requires a separate runtime-change proposal, not a repair hidden inside PQ-004. | Source-backed DFlash2 policy/implementation, deterministic n-selection and overhead contract, separate critic/CEO decision. Current status stays BLOCKED; no runtime patch or screen. |
| 4 | PQ-20260821-005 paired state consistency | It addresses a plausible mechanism, but it is the least ready: paired v31 manifests/state contract and coefficient are not frozen, and the proposed objective/data change risks confounding. It should follow contract and implementation closure rather than precede them. | Preserved v31 paired-state feature/state manifests, one frozen coefficient, data/fit gate, and explicit user approval. Current status stays deferred queue-only; no feature regeneration or training. |

## Historical designated action: PLAN-001 contract closure (now terminal)

**Action.** Perform one read-only reconciliation of preserved v20–v22 source and
receipts into an immutable PLAN-001 evaluator/Arm-B contract manifest. The
manifest must bind one evaluator/logger/finalizer tuple and explicitly record
or mark `UNKNOWN`: runtime/build/tokenizer/target/drafter hashes, prompt and
contract hashes, committed prefix and proposed/target IDs, correction and
accept/commit decision, block width/positions/sequence IDs, mask tensor/schema,
cache before/after schema and state hashes, anchor/`n_extract` transition,
deterministic replay ID, and the historical singleton memory-after discrepancy.
This is a documentation/read-only action only; it must not invoke the runtime.

**Dependency.** The canonical `LIT-20260821-001` handoff and the preserved
v20–v22 source/receipt set must be available for inspection. The mapping may
reuse only source-backed identities and receipts; it may not infer Arm-B
equivalence from generic source descriptions or historical block fixtures.

**Stop condition.** Stop and retain `PLAN-001` as BLOCKED if any required
identity or tuple field remains unknown, if the singleton memory-after conflict
cannot be resolved from preserved evidence, or if the manifest cannot prove
that Arm-B is the deployment-shaped schedule. Do not launch Arm A/B/D, open
held-out data, or broaden the scope to a runtime patch.

## Why not the others first?

- PQ-002 has no implementation artifact; another search has already established
  that preserved CE/KD/perplexity/sampler candidates are not substitutes.
- PQ-004 has no existing DFlash2 adaptive selector; `p_min`, DSpark, and
  adaptive-p mechanisms are not admissible substitutions.
- PQ-005 depends on unresolved paired-state manifests and introduces a more
  confounded, higher-cost objective/data change.

The ranking leaves all four proposals’ existing approval flags, receipt paths,
sealed-heldout boundaries, and negative-result controls unchanged.

## Post-PQ007 ranking update (additive)

PQ007 is now terminal-negative: its augmented fit reached 0.176699
accepted/cycle versus the 0.20198 incumbent, so no further blind data scaling
is ranked. **PQ-20260821-008 verifier/state localization** remains the
preserved diagnostic design, using the existing planning packet
[`PQ-20260821-008-VERIFIER-STATE-LOCALIZATION-PACKET-20260821`](PQ-20260821-008-VERIFIER-STATE-LOCALIZATION-PACKET-20260821.md).

PQ-008 was planning-only and is now terminal-blocked. Its historical unblock
checklist was: mechanically bind the
evaluator/logger/finalizer tuple; recover prompt IDs/order/hash; bind Arm-B
deployment-shaped positions, sequence IDs, mask, cache, anchor, and
`n_extract`; prove singleton determinism; and preserve target/drafter/runtime
hashes. Stop before any comparison if any field is UNKNOWN, the historical
memory-after discrepancy remains unresolved, or process/GPU/cleanup/resource
state is unsafe. This diagnostic is intended to explain acceptance/runtime
losses before another objective or data intervention; it does not authorize a
run or alter sealed-holdout boundaries.

## PQ-008 remaining-field checkpoint (additive, 2026-08-21)

The completed read-only manifest leaves five rendered prompt hashes,
replay/state-logger/dependency identities, exact PLAN-001 Arm-B serialization,
explicit device split, and the `[171,171]` versus `[170,170]` memory-after
mapping UNKNOWN or CONFLICT. Therefore PQ-008 remains blocked. The smallest
next action is one immutable artifact-recovery pass for the exact PLAN-001
deployment bundle; that recovery has now completed with a no-found terminal
receipt (`f470e615...`). PQ-008 is terminal-blocked; the only recovery is
external artifact supply or a separately authorized regeneration task. No
further search, runtime, build, GPU, held-out, or Arm A/B/D comparison is
implied.

PQ-013 (prompt/category-gated mixed mode) is terminal-blocked: EXP011's
per-prompt receipts are not an unbiased selector set, and the existing client
does not establish per-request mixed-mode dispatch. Reopen only after a
source-backed launcher and source-disjoint calibration/held-out manifest are
supplied; do not fit a threshold on the 12 observed prompts.

## Queue audit after PQ-013 (additive)

No source-backed executable Qwen acceptance/speed candidate remains. PQ-002 is
terminal-negative at its n=4 gate; PQ-004 and PQ-005 lack implementation or
paired-state identities; PQ-008 is terminal-blocked on the missing deployment
bundle; PQ-012 is a counter measurement gap; and PQ-013 lacks a mixed-mode
launcher plus disjoint calibration/held-out data. Preserve the negatives and
await one exact recovery input rather than launching a blind sweep.

Post-PQ014 recovery review ranks neither candidate for GPU execution. Option A
(offline counterfactual prompt gate) is admissible only as CPU/read-only
descriptive analysis; Option B (repeated-prefix cache) lacks a source-backed
cache flag/launcher and repeated-prefix manifest. See
[`PQ-20260821-015-RECOVERY-OPTIONS-20260821`](PQ-20260821-015-RECOVERY-OPTIONS-20260821.md).

## Current intake after PQ-015

The current action is the PQ-016 artifact-recovery intake, not a GPU run. One
authoritative input can reopen work: (1) the exact PLAN-001 deployment
verifier bundle, (2) a source-backed per-request mixed-mode selector with a
source-disjoint calibration/held-out manifest, or (3) a repeated-prefix cache
bundle with independent hit accounting. See
[`PQ-20260821-016-ARTIFACT-RECOVERY-INTAKE-20260821`](PQ-20260821-016-ARTIFACT-RECOVERY-INTAKE-20260821.md).
Until one arrives or a new regeneration decision is authorized, all Qwen
acceptance/speed items remain negative, blocked, or measurement-only.

## Post-PQ008 runtime ranking (additive)

The next independent hypothesis was PQ-012, a fixed-Q8 n=1 runtime-overhead
decomposition against matched target-only. A local read-only analysis of the
completed EXP011 receipts found prompt/decode/draft counters but no per-
component draft/target/cache/scheduler timings, exactness reconciliation, or
literal compact argv hash. The counter gate therefore failed as a
measurement-gap negative; no runtime patch, inferred cost, or new GPU run is
justified. Receipt:
`receipts/PQ-20260821-012-runtime-overhead-decomposition-n1-20260821/analysis.json`.

## PQ-019 cache-on update (2026-08-22)

The v21 source-backed boolean and client `timings.cache_n` accounting close
the earlier cache-semantics gap. PQ-019 is now the highest-ranked bounded
runtime candidate: four isolated target/Q4 n=1 cache-off/on arms with only
`prompt_cache` and the corresponding server flag changed. It is admissible for
CEO consideration, but any result remains a prompt-reuse throughput finding;
acceptance, exactness, and general serving claims stay separate.

The smallest source-backed repeated-prefix workload for PQ-019 is the
12-row concatenation of the canonical six-prompt v20 public manifest, with
cold rows 0–5 and repeated warm rows 6–11. Duplicate-ID sequence preservation
and all six rendered/prefix hashes are hard preflight gates; cache-on must show
`cache_n>0` on warm rows or the screen stops as a measurement failure. The
earlier 12→24 v23 derivation is superseded. See
[`PQ-20260821-019-REPEATED-PREFIX-MANIFEST-20260822`](PQ-20260821-019-REPEATED-PREFIX-MANIFEST-20260822.md).

Contract route correction: source v21 hash `4be899...` is already Q4-bound
(`18a380...`), so the cleaner route uses target/Q4 arms and derives only the
Q4 cache-on JSON contract (`prompt_cache false→true`). No Q8 contract
derivation is in scope.

Local derivation is now complete: n=1 cache-off `d14ee941...`, cache-on
`50c3a875...`, machine diff `cab5e1ea...`, and six→12 workload `f911c7d3...`.
PQ-019's fresh preflight verified exact identities/idle resources and
byte-identical API-message duplication. Five token-prefix hashes remain
UNKNOWN because CPU model loading is excluded. The minimum cache diagnostic is
now ready for CEO consideration only if it records serialized-message hashes,
`cache_n`, output accounting, and cleanup; no token-prefix, acceptance,
exactness, quality, verifier, or general-speed claim is admissible.

Final planner disposition is PASS for CEO approval of the narrow diagnostic:
one persistent PID per arm, warmups `0a/0b`, timed reps `1–3`, serialized API
message hashes/order, positive warm-row `cache_n`, output/token accounting,
and strict cleanup. The authoritative Q4 superseding preflight is
`d204dea9...` (alias `cb1ab88f...`).

PQ-019 is now terminal-completed as a narrow cache/prompt-processing result:
cache-on improved local repeated-workload throughput while Q4 acceptance stayed
208/236 in both modes. Exactness/token-prefix hashes remain UNKNOWN; the next
gate is read-only output/evaluator reconciliation before any broader claim.

Post-PQ019 audit finds no new source-backed GPU improvement candidate. Repeating
cache, precision, draft-length, data-scale, or objective screens is
low-information or explicitly negative; PQ-008 and the remaining runtime
hypotheses lack required artifacts. The next action is read-only output/
evaluator reconciliation, with GPU work waiting on one exact recovery input.

That read-only reconciliation has now completed in
`receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json`
(SHA `945548c5…`). It recovers target-only oracle/evaluator totals and
historical Arm-B fields but does not close the exact PLAN-001 deployment
serialization/source tie, logger/replay/dependency identity, explicit split,
or `[171,171]`/`[170,170]` conflict. The ranking therefore stays at a
recovery boundary: no new GPU run is admissible until one exact source-backed
deployment, selector, paired-state, or runtime artifact arrives.

## Explicit EXP020/PQ019 ranking reconciliation — 2026-08-22

EXP020's independent-v23 screen is now a ranked negative, not a promotion:
target-only matched 12/12 hashes (625 tokens), frozen corrected Q4 matched
6/12 with no override events, and its +12.994677% Q4 timing is diagnostic only
because the projection gate failed. The six-prompt calibrated +12.496004% lead
therefore remains local evidence; no retuning, prompt exception, or threshold
rerun is admissible. See the [analysis](../analysis/PQ-20260822-020-INDEPENDENT-V23-SCREEN.md)
and [raw summary](../../receipts/EXP-20260822-020-qwen-singleton-correction/independent-v23-screen-r1/raw-remote/summary.json),
SHA `bb65c097f20f36f063f46ca3f3730a229f4a954decc43705b05b9d0b8dbd97c8`.

PQ019 remains ranked as a narrow cache/prompt-processing positive only:
target-only 16.089540→17.880100 tok/s (+11.13%) and Q4 n=1
18.163882→21.763139 (+19.82%), with acceptance unchanged at 208/236 and
exactness/token-prefix hashes UNKNOWN. It does not outrank the recovery gate
or support a general speculative-decoding speed claim; see the
[experiment card](../cards/EXP-20260822-019-qwen-prompt-cache-reuse.md) and
[post-run receipt](../../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md).

Accordingly, the next ranked action is still read-only, source-backed
PLAN-001/PQ008 verifier/state/evaluator recovery (or separately authorized
regeneration). No blind cache repeat, threshold retune, prompt exception, or
new GPU run is ranked until that exact artifact boundary is closed.
