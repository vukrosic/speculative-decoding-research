# CEO decision — PQ-20260821-002 acceptance-calibrated objective

Date: 2026-08-21  
Proposal: [`PQ-20260821-002`](../experiments/planning/EXPERIMENT-QUEUE.md)  
Readiness: [`PQ-20260821-002-READINESS-20260821.md`](../experiments/planning/PQ-20260821-002-READINESS-20260821.md)  
Decision: **CEO APPROVED IN PRINCIPLE — SUSPENDED BEFORE FITTING pending implementation amendment**

## Current CEO approval — 2026-08-21

This amendment supersedes the earlier blocked decision for this same packet;
the earlier decision and its reasons remain below as preserved historical
evidence. The CEO reconciled the final written lane inputs:

| Lane | Current record | Verdict |
|---|---|---|
| Planner | [`PQ-20260821-002-READINESS-20260821.md`](../experiments/planning/PQ-20260821-002-READINESS-20260821.md) and [`PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md`](../experiments/planning/PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md) | **READY-NEEDS-APPROVAL** |
| Critic | [`PQ-20260821-002-OBJECTIVE-FINAL-VERDICT-20260821.md`](../experiments/critique/PQ-20260821-002-OBJECTIVE-FINAL-VERDICT-20260821.md) | **READY-NEEDS-APPROVAL** |
| Literature | [`VERDICT-20260821-PQ002-OBJECTIVE-FINAL.md`](../literature/VERDICT-20260821-PQ002-OBJECTIVE-FINAL.md) | **PASS for CEO consideration** |

The CEO approves exactly one bounded remote run, subject to preflight and
terminal receipts. This is a training/validation diagnostic, not approval of
any general quality, exactness, losslessness, or serving-speed claim.

### Immutable scope and command boundary

- One causal change: replace the v27 position-weighted CE objective with the
  proposed direct FP32 cumulative-log prefix-survival objective. Do not change
  architecture, features, labels, optimizer, seed, runtime, evaluator,
  sampler, or validation contract.
- Use the selected lineage only: v23f epoch-03 parent
  `58d21ea393171203a52fba4df431e1850216cb9ea948faf83190e1473abc8930`, v27
  step-4000 checkpoint
  `d3caaa631eb7b3ab6bb10c63f7e1efe2de461a7f651ed0235fdaf5ca3c3faad0`, and
  F16 export
  `8e3edd04ecacd949da675dcdbe0263689fa820ee729e4376137ed816a4b0be31`.
- Freeze target GGUF
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`, layer
  62; v23b manifest
  `3004d4fae84bb2df0de5c47089c2d86345a2b7c66ca4cf66f7ee3aee9439c97d`; v23f
  labels
  `bedc0561f5aca18d38b9839cf87bb36892de18f70c6d4e6a50a92f2b158b0d7b`.
- Freeze trainer SHA
  `13480e24cfe3188a526afbf69bf20f94300107273953ab90d414696391053859`, v27
  curve trainer SHA
  `f0bbb3f4e8217e7e5003dec305107ceccf951165afc70c67a1924ea37474f857`, and
  wrapper SHA
  `fa8fd20de9c6c17cbf78ce325741c3d27649681ebfac3e033bf69f696fdb067c`.
  The wrapper's frozen inputs are the existing v23b feature directory,
  v23f label manifest, v23f output head, epoch-03 parent, one epoch, batch 2,
  lr `1e-4`, and seed `42`; the objective implementation must be the manifest
  policy and no other code or flag may change.
- Objective manifest SHA-256 at approval:
  `e2a8597438b9b1a327b418ebdd24f6ba31e6a9fbef4d2d3e3f2e87309d777adf`.
- Run one epoch and capture looks at optimizer steps 800/1600/2400/3200/4000;
  select at most one checkpoint using the registered n=4 accepted/cycle
  metric and tie-break rules. Validation lengths are n=4/8/16 under the
  pinned contract (seed 42, greedy, 4K context, 64 max tokens, 12 prompts).
- Resource boundary: one approved remote RTX 3060, one process, maximum four
  GPU-hours, existing artifacts only. The executor must not run GPU code on
  the Mac.

### Controls, stops, and receipts

- Compare against the v27 parent using the original objective. Keep fit loss,
  teacher-forced metrics, prefix survival, acceptance, target-content,
  output-token counts, timing/VRAM, and diagnostic exactness separate.
- Current validation references are the fresh v30 target-only receipt
  `44ec15bb2c751684155132658292b1d8e625e6df2ab8be785c354d1d2b95d778` and F16
  receipt `f906269ebd09bf365fefdd8bb5b015d0db0626fc967962977f40a1fc8c224cb5`.
- Stop before fitting on any identity/hash/data/objective mismatch, held-out
  access, resource/process contention, invalid mask/EOS data, non-finite
  forward/backward values, zero relevant gradients, optimizer failure, or
  missing command/configuration capture. Stop validation on evaluator,
  output-token, cache/correction, or cleanup failure. If no checkpoint beats
  the v27 n=4 acceptance baseline, record a negative result and do not run a
  timing-promotion screen.
- Write complete receipts under
  `receipts/PQ-20260821-002-prefix-objective-20260821/`: `objective-manifest.json`,
  `environment.json`, `data-manifest.json`, `fit.json`, `validation.json`,
  `summary.json`, `cleanup.json`, and `terminal.json`. Include every command,
  configuration, identity, milestone, error, failure, result, artifact
  hash/path, held-out state, cleanup state, and final GPU/process state.
- No downloads, installs, patches, new trajectories, spending, publication,
  destructive action, or sealed-holdout access. Any scope change requires a
  new planner packet, critic review, and CEO decision; anything outside this
  bounded policy remains **SEPARATE USER APPROVAL REQUIRED**.

The v23b aggregate-directory, trainer source-commit, and absent optimizer/
sampler-state caveats are accepted as written and must be copied into the
environment receipt, not silently repaired. The executor handoff is recorded
in the CEO action log and queue card; no second GPU experiment may start while
this one is running.

## Pre-fit implementation amendment — 2026-08-21

The executor's read-only preflight found that the pinned v23f/v27 trainer
contains only the prior hard-label position-weighted CE and has no
implementation of the approved FP32 cumulative-log prefix objective. This is
an exact provenance/scope mismatch, not an experiment result. Fitting,
validation, and all comparison receipts are therefore suspended; no model or
GPU process was launched.

The critic's [`implementation-gate critique`](../experiments/critique/PQ-20260821-002-IMPLEMENTATION-GATE-CRITIQUE-20260821.md)
returns **BLOCK / CEO AMENDMENT REQUIRED**. Literature's
[`ephemeral-wrapper verdict`](../literature/VERDICT-20260821-PQ002-EPHEMERAL-WRAPPER.md)
finds a wrapper conditionally admissible only if it is an objective-only
implementation with immutable provenance. The planner must now create an
additive implementation manifest/card that names:

1. wrapper/patch path, exact bytes SHA-256, base trainer SHA-256, interpreter,
   dependency versions and environment;
2. exact command/configuration and receipt path;
3. the synthetic-logit/unit gate for `log_softmax`, `log_epsilon`, EOS masks,
   cumulative logs, finite losses/gradients, and `lambda=0` CE equivalence;
4. an explicit invariant that model, data, features, labels, optimizer,
   runtime, evaluator, sampler, selection, and held-out boundary are
   unchanged; and
5. amended pre-run, post-run, cleanup, and terminal receipt fields.

After that manifest exists, planner, critic, and literature must re-review it;
only then may the CEO issue a fresh amendment. Until then the original
bounded approval is **not executable**, the executor must remain stopped, and
the reserved run directory must contain no fit/validation/summary/cleanup or
terminal run receipts. Any implementation that changes behavior beyond the
frozen objective is a new proposal requiring a new card and CEO decision.

### No-artifact inventory — 2026-08-21

The executor then searched the approved remote project read-only for an
existing implementation instead of creating one. Receipt
[`objective-implementation-inventory-20260821.json`](../receipts/PQ-20260821-002-prefix-objective-20260821/objective-implementation-inventory-20260821.json)
SHA-256 `c063fd2dd2738647748de1c74dd0c2c42773812e99ee0e39a23ea0cbeb715a38`
records zero exact matches for the required objective symbols and shows that
all candidate log-softmax, KD, perplexity, and sampler helpers are unrelated.
Therefore no approved implementation artifact exists. PQ-002 remains
**BLOCKED / NEEDS-CEO-AMENDMENT**; the only admissible next step is a new,
separately reviewed implementation proposal or an explicit user-approved
scope expansion. No fitting, validation, or GPU action may begin from the
current card.

## Lane inputs

| Lane | Record | Verdict |
|---|---|---|
| Planner | readiness packet | **BLOCK**: conflicting v27 lineage, missing feature/label and training-script hashes, non-executable objective formula. |
| Critic | [`PQ-20260821-002-READINESS-CRITIQUE-20260821.md`](../experiments/critique/PQ-20260821-002-READINESS-CRITIQUE-20260821.md) | **BLOCK**: provenance, formula, checkpoint selection, baseline receipts, and cleanup contract incomplete. |
| Literature | [`VERDICT-20260821-PQ002.md`](../literature/VERDICT-20260821-PQ002.md) | Bounded hypothesis, but not the highest-information next action while PLAN-001 state mismatch remains unresolved. |

## CEO finding

The prefix-survival objective is a legitimate existing hypothesis: v27 n=4
acceptance was 5.175%, v29 early-only continuation fell to 4.819%, and v30 Q8
remains 5.175% acceptance / 11.5572 tok/s with 7/12 target-content matches.
Those observations do not make the proposed loss executable or prove that
training will improve serving. No objective formula, checkpoint, or data
identity may be inferred from those results.

The exact blockers are:

1. conflicting v27 parent/checkpoint lineage (`cf97d59f`/`e29bcb57` versus
   `d3caaa63`/`8e3edd04`);
2. missing immutable v23b/v23f feature/label manifest hashes and training
   script/configuration hashes;
3. non-executable prefix-survival formula: target probability/logit source,
   normalization/reduction, masks/EOS, epsilon, precision/gradient behavior,
   and prefix-target definition are unspecified;
4. incomplete validation checkpoint/multiplicity selection and baseline
   receipt linkage; and
5. missing task-owned training cleanup/device/terminal receipt schema.

## Next action and boundary

Planner owns a read-only lineage/data/config inventory; executor may inspect
preserved remote artifacts only, without training, GPU use, download, install,
or held-out access. Literature and critic must re-review any repaired packet.
The reserved execution path is
`receipts/PQ-20260821-002-prefix-objective-20260821/`; it must remain free of
training/validation receipts until a new CEO approval. PLAN-001 localization
remains the higher-information diagnostic; PQ-002 is retained as a follow-up,
not promoted or discarded.

Actions outside the delegated bounded policy remain
`SEPARATE USER APPROVAL REQUIRED`.

## Provenance inventory amendment — 2026-08-21

The read-only inventory
[`v27-v23b-v23f-provenance-inventory-20260821.json`](../receipts/PQ-20260821-002-prefix-objective-20260821/v27-v23b-v23f-provenance-inventory-20260821.json)
(SHA-256 `750d77097c08f65f71d765e85424a8fb517791c9ed49156e4c4095107bd10480`)
substantially closes the selected v23f→v27 lineage, feature/label manifests,
trainer/config/optimizer/seed, evaluator, and baseline provenance. Planner's
[`PQ-20260821-002-PROVENANCE-VERDICT-20260821.md`](../experiments/planning/PQ-20260821-002-PROVENANCE-VERDICT-20260821.md)
and critic's recheck still identify the exact prefix-survival formula,
checkpoint/multiplicity policy, stale alternate-lineage explanation, and
training cleanup/terminal schema as open. Literature considers PQ-002 bounded
but secondary to PLAN-001.

CEO keeps PQ-002 **BLOCKED**. Planner must next write a complete mathematical
objective manifest, explicitly label it as the proposed causal change, and
repair selection/cleanup records. No training or GPU run is authorized until
critic and literature re-review and the CEO records a fresh approval.
