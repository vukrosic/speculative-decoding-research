---
id: EXP-20260819-002-smollm-capacity35m
date: 2026-08-19
status: completed-negative
method: DFlash2-style capacity ablation
exactness_contract: exact batch-one target replay
heldout_touched: true
tags: [smollm, dflash2, capacity, negative-result]
---

# Does draft capacity alone improve exact acceptance?

## Frozen controls and intended change

Target, target weights, data/splits, block size, width, attention, selector,
objective, seed, optimizer, and evaluator matched
[EXP-20260819-001](EXP-20260819-001-smollm-onpolicy20k.md). Only decoder depth
changed from 2 to 9 layers, producing exactly 35,395,008 parameters.

Inserted layers used residual-identity initialization. The expanded model was
bit-for-bit logit-identical to the 10.13M parent on the fit batch before
training.

## Environment and fit gate

- RTX 3060 12 GB; driver/CUDA versions `unknown` in this seed card.
- Batch-32 finite forward/backward/AdamW passed.
- Peak allocated VRAM 816.7 MB; reserved 908.1 MB.
- Training duration 481.1 s; selected epoch 3 by validation loss.

## Observed

- Validation loss trajectory: 3.6840, 3.4001, 3.3866, 3.5347, 3.7298, 3.9685.
- Untouched 1k test: loss 3.3501, accuracy 51.57%, exact outputs 1000/1000.
- Fixed 90-prompt acceptance: 6.8334% versus 7.1566% baseline.
- Absolute change: -0.3232 percentage points; relative change: -4.52%.
- Full-test acceptance: 3,521/55,739 = 6.3169% (not directly comparable to
  the fixed balanced slice).
- No end-to-end serving benchmark was run.

## Interpretation / hypotheses

Capacity alone is not the demonstrated bottleneck. Better teacher-forced loss
and accuracy did not improve autoregressive exact acceptance.

## Reproduction

```bash
cd /workspace/smollm-eagle3-prototype
/workspace/vllm-venv/bin/python dflash2_adapter/capacity_fit_smoke.py
/workspace/vllm-venv/bin/python dflash2_adapter/expand_capacity.py
/workspace/vllm-venv/bin/python dflash2_adapter/evaluate_capacity_test1000.py
```

## Artifacts and receipts

- Checkpoint:
  `checkpoints/dflash2-official-bridge-block3-capacity35m-onpolicy20k-best`
- Fit receipt: `benchmarks/dflash2-block3-capacity35m-fit-smoke-20260819.json`
- Evaluation receipt:
  `benchmarks/dflash2-block3-capacity35m-test1000-acceptance-20260819.json`
- Final recorded GPU state: idle, 1 MiB used, 0% utilization.

