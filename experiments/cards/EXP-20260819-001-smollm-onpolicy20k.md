---
id: EXP-20260819-001-smollm-onpolicy20k
date: 2026-08-19
status: completed-positive
method: DFlash2-style compatibility bridge
exactness_contract: exact batch-one target replay
heldout_touched: true
tags: [smollm, dflash2, on-policy, block-3, exactness]
---

# Does on-policy training improve the 10.13M SmolLM DFlash2-style bridge?

## Frozen controls

- Target: existing SmolLM2-135M-Instruct snapshot, 134,515,008 parameters.
- Drafter: two-layer bridge, 10,129,600 trainable parameters.
- Vocabulary 49,152; selector rank 16; block size 4 / 3 proposals.
- Data: 20,000 on-policy trajectories; 18k train, 1k validation, 1k test.
- Runtime: `/workspace/vllm-venv`; official DFlash source commit
  `07ebd93db9f472af339b644bb70221ad8428328a` plus an explicitly labeled local
  compatibility bridge.
- Hardware: RTX 3060 12 GB. Driver/CUDA versions were not captured in the
  compact seed record and remain `unknown`.

## Objective and hyperparameters

- Existing block-3 target-conditioned objective and optimizer settings.
- Validation-loss checkpoint selection; five epochs run; epoch 2 selected.
- Exact target replay guard retained because BF16 block verification could
  differ from singleton execution.

## Baseline

Matched initialization under the same fixed 90-prompt acceptance slice.

## Observed

- Selected validation/test token loss: 3.4287.
- Teacher-forced token accuracy: 50.10%.
- Acceptance: 7.1566% versus 7.1292% matched initialization, +0.0274
  percentage points.
- Exact outputs: 90/90 on the fixed exact comparison.
- No end-to-end serving benchmark was run.

## Interpretation / hypotheses

The bridge learned, but the acceptance gain over initialization was not
material. The run establishes a reproducible exact block-3 baseline, not a
serving-speed benefit or official-checkpoint equivalence.

## Reproduction

```bash
cd /workspace/smollm-eagle3-prototype
/workspace/vllm-venv/bin/python dflash2_adapter/train_onpolicy20k.py
/workspace/vllm-venv/bin/python dflash2_adapter/evaluate_onpolicy20k_acceptance.py
```

## Artifacts and receipts

- Checkpoint: `checkpoints/dflash2-official-bridge-block3-onpolicy20k-best`
- Metrics: `checkpoints/.../onpolicy20k_metrics.json`
- Acceptance receipt:
  `benchmarks/dflash2-block3-onpolicy20k-heldout-acceptance-20260819.json`
- Large artifacts remain external; hashes should be backfilled from the remote
  receipt before any future reuse.

