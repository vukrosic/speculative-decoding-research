---
id: PQ-20260821-002-IMPLEMENTATION-PREFLIGHT-VERDICT-20260821
date: 2026-08-21
status: blocked-preflight
verdict: BLOCK
approval: CEO-AMENDMENT-REQUIRED
related:
  - PQ-20260821-002
  - PQ-20260821-002-OBJECTIVE-MANIFEST-20260821
  - PQ-20260821-002-IMPLEMENTATION-GATE-CRITIQUE-20260821
---

# PQ-002 implementation preflight verdict

**Dated decision — 2026-08-21: BLOCK.** The executor's read-only finding is
that the frozen v23f/v27 trainer tree contains the original position-weighted
token-CE path only; it contains no implementation of the approved FP32 direct
cumulative-log prefix objective. The local objective manifest defines the
policy, but a markdown policy is not an executable loss implementation.

An ephemeral wrapper cannot be admitted under the current CEO approval. The
approval freezes the v23f trainer, v27 curve trainer, existing wrapper, and
their hashes, and says that the objective implementation must be the manifest
policy with no other code or flag changed. A wrapper is a new executable
artifact and command boundary even if its scientific intent is only to realize
the already-approved objective. Treating it as temporary would make the
implementation identity irreproducible and would silently amend the approved
trainer boundary. No fit, validation, or receipt may start.

This is an implementation-boundary blocker, not a new research hypothesis. A
new additive implementation card/manifest and a fresh critic review followed by
a CEO amendment are required. The amendment may preserve the single causal
change (objective only), but must explicitly authorize the implementation
artifact and its exact invocation. Until then, preserve all approved scope and
leave the reserved receipt directory empty.

## Required immutable identity fields for the amendment

The implementation card and preflight receipt must record these fields as
values or explicit `UNKNOWN`; no value may be inferred:

| Field | Required value/evidence |
|---|---|
| `implementation_path` | Absolute path to the objective-only wrapper/module and any launcher; the existing v23f/v27 paths remain frozen controls. |
| `implementation_sha256` | SHA-256 of every new source/launcher file; include a manifest hash for the complete file set. |
| `source_commit` | Commit/tree identifier, or explicit `UNKNOWN` because preserved trainer files currently have working-file hashes only. |
| `parent_trainer_sha256` | v23f `13480e24cfe3188a526afbf69bf20f94300107273953ab90d414696391053859`; v27 curve `f0bbb3f4e8217e7e5003dec305107ceccf951165afc70c67a1924ea37474f857`; no silent edits. |
| `existing_wrapper_sha256` | `fa8fd20de9c6c17cbf78ce325741c3d27649681ebfac3e033bf69f696fdb067c`; retain as the frozen control and prove the new artifact is not substituted for it without amendment. |
| `objective_manifest_sha256` | Current manifest `e2a8597438b9b1a327b418ebdd24f6ba31e6a9fbef4d2d3e3f2e87309d777adf`; recapture immediately before any amended handoff. |
| `target_parent_checkpoint_hashes` | Target `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`; v23f epoch-03 `58d21ea393171203a52fba4df431e1850216cb9ea948faf83190e1473abc8930`; v27 step-4000 `d3caaa631eb7b3ab6bb10c63f7e1efe2de461a7f651ed0235fdaf5ca3c3faad0`; F16 `8e3edd04ecacd949da675dcdbe0263689fa820ee729e4376137ed816a4b0be31`. |
| `data_identity` | v23b manifest `3004d4fae84bb2df0de5c47089c2d86345a2b7c66ca4cf66f7ee3aee9439c97d`; v23f labels `bedc0561f5aca18d38b9839cf87bb36892de18f70c6d4e6a50a92f2b158b0d7b`; output head `8df6c677988e82b920d895fb761081ae93ed1ee73220dae3120f941a064471a7`; preserve the feature-directory aggregate-hash `UNKNOWN` caveat. |
| `runtime_dependency_identity` | Exact Python/Torch/CUDA/driver/container or environment-lock identities, with hashes where available; otherwise explicit `UNKNOWN`. No install or environment mutation. |
| `evaluator_and_prompt_identity` | Existing evaluator client `477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4`; finalizer `84101a5f11f44ccee00f75cf594eb7b42925caf408507cd6cafa8c7a11f79a60`; contract `42cf6a40304e278c8c4f4a01ecd612191cef55d22ae6d182b277a134bf416c39`; prompt manifest `30668abcb12a25a8c6b69f8f54bcf5f8942df3b800c996a52ba28d4e9af1f914`. |

## Required command and invariant evidence

The amendment must capture the **full exact command**, working directory,
environment variables, process/device selection, and argv—not a shortened
example. The frozen data/checkpoint flags must remain the provenance-inventory
values:

`--feature-dir .../shards/features-compact-v23b --label-manifest .../manifests/token-labels-v23f.jsonl --output-head .../target-output-weight-iq1s-v23f.f16 --initial-checkpoint .../v23f-token-ce-full/epoch-03.pt --expected-parent-epoch 3 --epochs 1 --batch-size 2 --lr 1e-4 --seed 42`

The implementation record must also show, by source diff or an equivalent
machine-readable comparison, that only the loss path changes: FP32
`log_softmax`, true-label `log_epsilon=log(1e-8)` clamp in log space, FP32
cumulative sums/reductions, no exponentiation/probability product, gradients
through active positions, and finite checks. Architecture, features, labels,
optimizer, seed, model precision, runtime, evaluator, sampler, validation
contract, prompt set, and held-out boundary must be unchanged. The absence of
any one of these proofs is a preflight stop.

## Required receipt contract after amendment

No run receipts are authorized before the amendment. If approved, the reserved
directory must contain `objective-manifest.json`, `environment.json`,
`data-manifest.json`, `fit.json`, `validation.json`, `summary.json`,
`cleanup.json`, and `terminal.json`; each must include its own SHA/path,
captured command/configuration, implementation and parent hashes, timestamps,
finite forward/backward and nonzero-gradient gates, optimizer-step result,
checkpoint hash, evaluator/prompt/contract hashes, separate acceptance and
teacher-forced/timing metrics, held-out state, errors, cleanup, and final
GPU/process state. Missing identity, objective, finite-gradient, evaluator,
resource, held-out, or cleanup evidence remains a hard stop.

**Smallest next action:** write the additive
`PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-MANIFEST`/card with the fields above,
obtain critic review, then request a CEO amendment. Do not create an ephemeral
wrapper, patch the frozen trainer, or run code while this verdict is BLOCK.

