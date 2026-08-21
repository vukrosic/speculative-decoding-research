---
id: EXP-20260821-004-qwen-v30-quantization
date: 2026-08-21
status: completed-positive
method: drafter deployment quantization
exactness_contract: approximate validation screen; exact heldout sealed
heldout_touched: false
tags: [qwen, dflash2, quantization, serving]
---

# Does quantizing the v27 drafter improve the n=4 serving screen?

## Frozen controls

Source checkpoint, IQ1_S target, runtime, 12 validation prompts, prompt order,
64-token generation contract, proposal length 4, and evaluator were fixed. Only
the drafter export format changed: F16, Q4_K_M, or Q8_0.

## Observed

| Draft form | Accepted/proposed | Tok/s | Target-content | Peak VRAM |
|---|---:|---:|---:|---:|
| F16 | 102/1,971 | 11.476 | 7/12 | 8,085 MiB |
| Q4_K_M | 103/1,967 | 11.550 | 7/12 | 8,015 MiB |
| Q8_0 mean of 3 | 102/1,971 | 11.550 | 7/12 | 8,033 MiB |

Q8_0 repeated runs measured 11.538, 11.568, and 11.543 tok/s. Mean improvement
over F16 was 0.65%. It remained 34.3% below target-only 17.592 tok/s. Exactness
failed, so this is not a lossless speedup.

## Interpretation / hypotheses

Q8_0 is the stable compact deployment form for this approximate custom drafter.
The small gain is real within the repeated screen but too small to change the
overall serving conclusion.

## Reproduction

```bash
# Quantize the preserved v27 curve-step-4000 export, then run the frozen n=4
# validation screen. Exact command is retained in the v30 external receipt.
bash run_compact_dflash16_validation_screen_v23.sh
```

## Artifacts and receipts

- Q4_K_M SHA-256:
  `2a7828cfb7fa3ae704a7df4a36004341ec99ae99ab8bfe6e5262fe28430a63`
- Q8_0 SHA-256:
  `f71a21453e2fc379585045d22ee55c51add979e529882a17cf0ccb9cecf4e4f4`
- No large GGUF is stored in this repository.

