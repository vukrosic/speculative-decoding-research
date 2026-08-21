---
id: EXP-20260821-006-smollm-1layer-vs-5layer
date: 2026-08-21
status: completed-bounded
method: DFlash2-style capacity comparison
exactness_contract: fixed-90 target-equivalent outputs with exact guard enabled
heldout_touched: false
tags: [smollm, dflash2, capacity, acceptance, throughput, bounded]
---

# Does a five-layer drafter beat the existing one-layer drafter?

## Question

On the frozen SmolLM2-135M target and fixed block-3 evaluator, does a
five-layer DFlash-style drafter improve accepted draft tokens enough to offset
its additional draft latency compared with the existing 6,520,256-parameter
one-layer drafter?

## Authorization and scope

- Authorized action: one bounded 1-layer versus 5-layer comparison.
- Explicit exclusions: no new data generation, large training run, or final
  sealed held-out evaluation.
- Stop conditions: stop after the fixed acceptance and repeated timing
  receipts, or on correctness/runtime failure.
- Artifact budget: additive remote checkpoints and compact receipts only;
  large logs and weights remain on the remote project.

## Frozen controls

- Target: SmolLM2-135M-Instruct, 134,515,008 parameters, snapshot
  `hf-cache/models--HuggingFaceTB--SmolLM2-135M-Instruct/snapshots/12fd25f77366fa6b3b4b768ec3050bf629380bac`.
  Snapshot file-manifest SHA-256:
  `8c4e8eb47fc6bce1264cb971e468b9b60187e173be8babddfc1a0a037fc238c3`.
- One-layer baseline:
  `checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best`;
  6,520,256 total/trainable parameters; checkpoint directory-manifest
  SHA-256 `670a03d3219c82977df33d35189d91ca4d136c5dd86f4b69e595f785aa272876`.
- Five-layer candidate:
  `checkpoints/dflash2-official-bridge-block3-capacity5layer-bounded-20260821-trained`;
  20,957,632 total/trainable parameters; checkpoint directory-manifest
  SHA-256 `1b7f235273cc91356cf523cb5a286902ffc089bcfcd3dd5e67f21dabd279fcda`.
- Five-layer parent used for additive expansion:
  `checkpoints/dflash2-official-bridge-block3-onpolicy20k-best`;
  directory-manifest SHA-256
  `32c45673545530d3cffa0409c8a2a0e8c99485d3c01ea49f00bfb0feb66550c9`.
- Dataset: existing `datasets/dflash2-block3-onpolicy20k-trajectories-v1`,
  with the established 18k train / 1k validation / 1k test split and one
  anchor per trajectory. The fixed balanced comparison used 90 prompts, 30
  each from chat, code, and document categories, in frozen order.
- Evaluator: official DFlash source commit
  `07ebd93db9f472af339b644bb70221ad8428328a` plus the project bridge;
  evaluator SHA-256 `bca46e5d839b81fc88672c46b7347ce951d5f942ec008af7514e421d9a2676d3`.
- Timing settings: seed `20260819`, greedy generation, block size 4 / 3
  speculative proposals, `max_new_tokens=32`, two repetitions per model,
  same prompt order and frozen target-only output references.

## Intended change

Draft decoder depth changed from one layer to five layers. The inserted
layers used residual-identity initialization, with endpoint layers copied from
the two-layer bridge and inserted residual output/down projections zeroed.
This is a capacity/initialization comparison, not a pure retraining ablation:
the one-layer baseline and five-layer candidate do not share the same parent
checkpoint.

## Environment

- GPU / VRAM: NVIDIA GeForce RTX 3060 / 12,288 MiB.
- Driver / CUDA: driver `580.173.02`; CUDA `13.0`.
- Runtime / framework: `/workspace/vllm-venv`; Python `3.12.13`; PyTorch
  `2.13.0+cu130`; Transformers `5.15.0`.
- Attention/backend and project source: existing official DFlash modules and
  compatibility bridge; no runtime or target change.

## Objective and hyperparameters

- Training objective: existing target-conditioned token cross-entropy used by
  the comparable on-policy-20k bridge.
- Optimizer: existing AdamW protocol; learning rate `0.0002`, weight decay
  `0.01`, batch size `32`, seed `20260820`.
- Training: maximum six epochs, early-stop patience three; three epochs
  completed and epoch 0 selected by lowest validation cross-entropy.

## Baseline

The existing one-layer checkpoint and its fixed-90 acceptance receipt were the
baseline. The five-layer checkpoint was evaluated with the same evaluator,
target, prompts, seed, and decoding settings.

## Preflight gates

- [x] construction and tensor shapes
- [x] exact total/trainable parameter counts
- [x] finite forward/loss/backward and optimizer training path
- [x] evaluator and exact-output guard
- [x] fixed prompt order and split controls
- [x] additive artifact paths
- [x] process cleanup and GPU-idle verification
- [ ] final sealed held-out evaluation (explicitly out of scope)

## Results

### Observed

| Evidence class | Metric | 1-layer baseline | 5-layer candidate | Receipt |
|---|---:|---:|---:|---|
| teacher-forced loss | selected validation CE | 3.438434 | 3.409669 | training metrics |
| teacher-forced accuracy | selected validation | 50.4333% | 50.2667% | training metrics |
| teacher-forced accuracy | per-position | 55.4 / 49.5 / 46.4% | 55.7 / 47.7 / 47.4% | training metrics |
| acceptance | accepted / proposed | 642 / 10,692 | 744 / 10,396 | acceptance/timing |
| acceptance | overall draft-token rate | 6.0045% | 7.1566% | acceptance/timing |
| acceptance | mean accepted draft tokens/cycle | 0.1764 | 0.2104 | acceptance/timing |
| acceptance | positions 1 / 2 / 3 | 11.978 / 3.535 / 2.294% | 14.706 / 4.155 / 2.357% | acceptance/timing |
| exactness | target-equivalent outputs | 90/90 acceptance; 180/180 timing | 90/90 acceptance; 180/180 timing | acceptance/timing |
| end-to-end speed | tokens/sec | 14.4277 | 12.4785 | timing |
| end-to-end speed | total wall time | 308.435 s | 356.614 s | timing |
| latency | mean / median / p95 per call | 1.7135 / 1.9418 / 2.3793 s | 1.9812 / 2.2321 / 2.8046 s | timing |
| resource | peak VRAM | 323,866,624 B | 385,585,152 B | timing |

The five-layer model therefore changed acceptance by **+1.1521 percentage
points** and **+19.19% relative**, but changed end-to-end throughput by
**-1.9492 tok/s** and **-13.51% relative**. Both models passed the exact guard
for every measured output. The candidate used 3,536 target block verifications
and 4,270 singleton exact-guard calls; the baseline used 3,640 and 4,270.

Training loss fell from 2.7848 to 1.4391 over the three completed epochs, while
validation loss worsened from the identity-initialized 3.4097 to 3.4968,
3.4962, and 3.7459. Epoch 0 was consequently selected. The training metrics
receipt contains a post-selection `selected_test` diagnostic; it was not used
for checkpoint selection. The fixed timing receipt reports
`heldout_data_used=false`.

### Interpretation / hypotheses

- **Observed decision:** the five-layer candidate improves acceptance on this
  fixed slice but is slower end to end. The one-layer draft remains the better
  throughput choice under this exact guarded runtime.
- **Interpretation:** the acceptance gain does not pay for the added draft
  compute. This does not establish that five layers are intrinsically worse on
  other workloads or with a better-trained objective.
- **Important limitation:** because epoch 0 was selected, this result mainly
  measures the bounded identity-initialized five-layer capacity path, not a
  successful five-layer training improvement.
- The fixed 90-prompt slice and two timing repetitions are sufficient for this
  bounded comparison but not a broad workload or production-SLO claim.

## Decision

- Promotion decision: do not promote the five-layer model as the serving
  incumbent. Preserve it as an acceptance-improving but throughput-negative
  research candidate.
- Why: exactness passed, acceptance improved, but measured end-to-end speed
  fell 13.51%.
- What this does not establish: no final held-out quality claim, no general
  cross-workload ranking, and no evidence that more five-layer training would
  reverse the throughput result.

## Reproduction

```bash
ssh -p 35738 root@125.240.239.50
cd /workspace/smollm-eagle3-prototype
/workspace/vllm-venv/bin/python dflash2_adapter/train_onpolicy20k.py \
  --epochs 6 --batch-size 32 --learning-rate 0.0002 \
  --weight-decay 0.01 --early-stop-patience 3 --seed 20260820 --device cuda
/workspace/vllm-venv/bin/python -m dflash2_adapter.evaluate_onpolicy20k_acceptance \
  --prefixes-per-category 30 --max-new-tokens 32 --seed 20260819 --device cuda
/workspace/vllm-venv/bin/python -m dflash2_adapter.benchmark_capacity5layer_bounded \
  --repetitions 2 --max-new-tokens 32 --seed 20260819
```

## Artifacts and receipts

- Initialization receipt:
  `checkpoints/dflash2-official-bridge-block3-capacity5layer-bounded-20260821-init/capacity5_initialization_receipt.json`;
  SHA-256 `f465a42a97326631c4eb64fe9a2ea43c35e52ceeac0d6959311fc3c50e5537bb`.
- Training metrics:
  `checkpoints/.../onpolicy20k_metrics.json`;
  SHA-256 `069c7e4481440fe808db952d8a0be661514971fbe34aa6cf346198d2e626104d`.
- Acceptance receipt:
  `benchmarks/dflash2-block3-capacity5layer-bounded-20260821-fixed90-acceptance.json`;
  SHA-256 `1dcc1f6033957ac2e42699cede8a994bf98415c0d4b8a48f72cf548fcb7bb160`.
- Timing receipt:
  `benchmarks/dflash2-block3-capacity5layer-bounded-20260821-timing.json`;
  SHA-256 `815c722efe8f74b4913c051c0c5f0ce1337cd24475678a9319f58e41460354a2`.
- Timing script SHA-256:
  `a92a00787a07dd314585882dae333c2960c8a281e79252dca5aa0b5d79a3c8c9`.
- Logs remain at the remote paths next to the receipts; they were not copied
  into this compact repository.
- Final remote state after timing: task-owned process exited; RTX 3060 at 0%
  utilization and 1 MiB used.

## Failures and amendments

- 2026-08-21: five-layer training stopped after three epochs because
  validation loss failed to improve for three epochs. The selected checkpoint
  is epoch 0; this is retained as a negative training result.
- 2026-08-21: no speed claim is made for acceptance alone; the only speed
  comparison is the matched fixed-prompt timing receipt above.

## Follow-up questions

- Can a smaller intermediate depth recover some of the acceptance gain without
  paying the five-layer latency cost?
- Can a training objective selected by contiguous acceptance, rather than CE,
  make added capacity useful without a larger runtime burden?
