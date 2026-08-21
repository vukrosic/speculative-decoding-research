---
id: PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-MANIFEST-20260821
date: 2026-08-21
status: needs-ceo-amendment
verdict: NEEDS-CEO-AMENDMENT
kind: additive-implementation-boundary
related:
  - PQ-20260821-002
  - PQ-20260821-002-OBJECTIVE-MANIFEST-20260821
  - PQ-20260821-002-IMPLEMENTATION-PREFLIGHT-VERDICT-20260821
  - PQ-20260821-002-IMPLEMENTATION-INVENTORY-DISPOSITION-20260821
---

# PQ-002 objective-only implementation manifest

This is an additive implementation-boundary card, not code and not an
execution approval. It exists because the frozen v23f/v27 trainer tree has no
implementation of the approved FP32 direct cumulative-log prefix objective.
The card is **NEEDS CEO AMENDMENT**. No wrapper, patch, fit, validation, GPU
action, download, install, or held-out access is authorized by this document.

The scientific scope remains exactly one causal change: replace the v27
position-weighted CE objective with the policy in the objective manifest. The
implementation artifact below is an explicit realization of that already
approved policy; it is not permission to change any other variable. A CEO
amendment must authorize the artifact and exact command before executor
handoff.

## Implementation identity (values not supplied remain UNKNOWN)

| Field | Required value |
|---|---|
| `new_wrapper_or_module_path` | **UNKNOWN** — executor has not supplied a new path; no file has been created. The amendment must name an absolute remote path and whether the artifact is a module, wrapper, or both. |
| `new_wrapper_or_module_sha256` | **UNKNOWN** until the complete source file is supplied and hashed. |
| `new_file_set_manifest_sha256` | **UNKNOWN** until every new/modified file, path, byte size, and SHA-256 is captured in a file-set manifest. |
| `source_commit_or_tree` | **UNKNOWN**; the preserved trainer files are working-file hashes without a source commit. The amendment must record a commit/tree ID or retain explicit `UNKNOWN`. |
| `base_v23f_trainer` | `/workspace/smollm-eagle3-prototype/experiments/qwen38-27b-iq1s-dflash2-train-v23-20260820/scripts/train_compact_dflash16_token_ce_v23f.py`, SHA-256 `13480e24cfe3188a526afbf69bf20f94300107273953ab90d414696391053859`. |
| `base_v27_curve_trainer` | `/workspace/smollm-eagle3-prototype/experiments/qwen38-27b-iq1s-dflash2-autoresearch-v27-20260820/scripts/train_compact_dflash16_token_ce_v27_gamma8_ls002_curve.py`, SHA-256 `f0bbb3f4e8217e7e5003dec305107ceccf951165afc70c67a1924ea37474f857`. |
| `base_existing_wrapper` | `/workspace/smollm-eagle3-prototype/experiments/qwen38-27b-iq1s-dflash2-autoresearch-v27-20260820/scripts/run_qwen_v27_gamma8_ls002_curve_train.sh`, SHA-256 `fa8fd20de9c6c17cbf78ce325741c3d27649681ebfac3e033bf69f696fdb067c`. |
| `objective_manifest` | `/Users/vukrosic/my-life/open-discovery-workspace/llm-inference-optimization/speculative-decoding-research/experiments/planning/PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md`, recaptured SHA-256 `e2a8597438b9b1a327b418ebdd24f6ba31e6a9fbef4d2d3e3f2e87309d777adf`. Recapture again immediately before amended handoff. |

No new artifact hash may be guessed from a proposed name. If the executor
cannot provide a path or hash, the field stays `UNKNOWN` and the gate remains
closed.

## Frozen model, lineage, data, and controls

- Target: Qwen3.8-27B IQ1_S, layer 62, SHA-256
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Parent lineage: v23f epoch-03 checkpoint SHA-256
  `58d21ea393171203a52fba4df431e1850216cb9ea948faf83190e1473abc8930`;
  v27 step-4000 checkpoint SHA-256
  `d3caaa631eb7b3ab6bb10c63f7e1efe2de461a7f651ed0235fdaf5ca3c3faad0`;
  F16 export SHA-256
  `8e3edd04ecacd949da675dcdbe0263689fa820ee729e4376137ed816a4b0be31`.
- Data: v23b feature-group manifest SHA-256
  `3004d4fae84bb2df0de5c47089c2d86345a2b7c66ca4cf66f7ee3aee9439c97d`;
  v23f token-label manifest SHA-256
  `bedc0561f5aca18d38b9839cf87bb36892de18f70c6d4e6a50a92f2b158b0d7b`;
  output head SHA-256
  `8df6c677988e82b920d895fb761081ae93ed1ee73220dae3120f941a064471a7`.
  The v23b feature directory has no aggregate hash; preserve the manifest,
  window-plan, group-response, and extractor hashes as an identity bundle.
- Optimizer/seed/control: AdamW, betas `(0.9, 0.95)`, weight decay `0.01`,
  learning rate `1e-4`, batch `2`, seed `42`; one epoch and checkpoint looks at
  steps `800,1600,2400,3200,4000`. Existing optimizer and sampler state were
  not serialized/restored; this caveat is fixed, not repaired by the wrapper.
- Runtime/evaluator: runtime and dependency identity are **UNKNOWN** until
  amended preflight captures exact Python, PyTorch, CUDA/driver, container or
  environment-lock identities. Evaluator client SHA-256
  `477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4`;
  finalizer SHA-256
  `84101a5f11f44ccee00f75cf594eb7b42925caf408507cd6cafa8c7a11f79a60`;
  benchmark contract SHA-256
  `42cf6a40304e278c8c4f4a01ecd612191cef55d22ae6d182b277a134bf416c39`;
  prompt manifest SHA-256
  `30668abcb12a25a8c6b69f8f54bcf5f8942df3b800c996a52ba28d4e9af1f914`.
- Resource boundary: one approved remote RTX 3060, one process, maximum four
  GPU-hours; no Mac GPU execution, concurrent process, install, download, or
  new trajectory.

## Exact command and environment capture

`exact_command_argv`, `working_directory`, `environment_variables`,
`device_visibility`, and `process_owner` are all **UNKNOWN** until the amended
executor preflight. They must be captured verbatim, including launcher path,
shell, every flag, and output/receipt paths. The existing frozen data and
checkpoint flags are:

```text
--feature-dir .../shards/features-compact-v23b
--label-manifest .../manifests/token-labels-v23f.jsonl
--output-head .../target-output-weight-iq1s-v23f.f16
--initial-checkpoint .../v23f-token-ce-full/epoch-03.pt
--expected-parent-epoch 3 --epochs 1 --batch-size 2 --lr 1e-4 --seed 42
```

The full command may not add architecture, feature, label, optimizer, seed,
runtime, evaluator, sampler, validation, prompt, or held-out flags. A command
that cannot be captured exactly is a hard stop.

## Source-diff invariant: objective only

The amendment must attach a machine-readable diff (paths, before/after SHA-256,
and changed symbols) against the three base hashes above. It must prove that
the only semantic change is the loss implementation specified in the objective
manifest:

1. FP32 `log_softmax` over frozen logits;
2. true-label log probability clamped only at `log_epsilon=log(1e-8)` in log
   space;
3. FP32 cumulative log sums
   `c_k = Σ_t m_t r_t` and FP32 reduction
   `L_prefix = (1/K) Σ_k m_k(-c_k)`;
4. `L_new = L_ce + 1.0 * L_prefix`, with no `exp`, probability tensor, or
   probability product;
5. gradients through active positions, with finite checks before backward and
   on gradients.

The diff must show no changes to model architecture, features, labels,
mask/EOS rules, data split, optimizer, seed, precision outside the specified
FP32 objective reductions, checkpoint cadence/selection, runtime, evaluator,
prompt contract, sampler, or held-out boundary. Any additional changed symbol
or file is a new causal scope and requires a separate proposal.

## Synthetic implementation gates (required evidence, not yet run)

Before any training fit, the amended implementation must provide a deterministic
synthetic fixture manifest and SHA-256 (**UNKNOWN** until supplied) and a
read-only smoke-test receipt proving:

- finite logits, FP32 log-softmax, clamped true-label log probabilities,
  cumulative logs, `L_ce`, `L_prefix`, `L_new`, and all gradients;
- at least one active-position gradient is finite and nonzero, while masked
  positions do not contribute; no detached prefix path;
- EOS includes its position and masks every later position; an all-inactive
  window fails the data gate;
- the implementation never constructs a probability product or exponentiates
  cumulative logs; and
- repeated evaluation of the same fixture is deterministic under seed `42`.

The fixture, smoke-test command, environment identity, output JSON, and all
hashes are mandatory receipt fields. No synthetic result may be represented as
a training or validation result.

## Reserved receipts and stop conditions

If, and only if, the CEO amendment is granted, receipts remain reserved at
`receipts/PQ-20260821-002-prefix-objective-20260821/` and must include:
`objective-manifest.json`, `environment.json`, `data-manifest.json`,
`fit.json`, `validation.json`, `summary.json`, `cleanup.json`, and
`terminal.json`. Each receipt must contain captured command/configuration,
implementation/base/objective/runtime/evaluator/prompt hashes, timestamps,
fixture and finite-gradient gate results, checkpoint hashes, separate fit,
teacher-forced, prefix, acceptance, output-token, timing/VRAM, and diagnostic
exactness metrics, held-out state, errors, cleanup, and final GPU/process state.

Stop before fit on any unknown required identity, hash/split/objective mismatch,
source-diff invariant failure, non-finite value, zero relevant gradient,
optimizer failure, held-out access, evaluator/contract mismatch, process or
resource violation, or missing command/configuration capture. Stop validation
on output-token, cache/correction, evaluator, or cleanup failure. The receipt
directory must remain empty while this card is `NEEDS-CEO-AMENDMENT`.

**Disposition:** implementation card complete as a documentation gate;
**NEEDS CEO AMENDMENT**. No code was written and no run occurred.
