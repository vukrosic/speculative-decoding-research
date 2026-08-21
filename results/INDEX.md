# Results index

This index separates direct observations from interpretations. “Speed” is not a
speedup unless a matched end-to-end baseline and applicable correctness gate
passed.

## Current incumbents

| Scope | Incumbent | Observed basis | Exactness status |
|---|---|---|---|
| SmolLM block-3 exact acceptance | 10.13M two-layer DFlash2-style bridge | 7.1566% fixed-90 acceptance | 90/90 exact outputs passed |
| Qwen custom drafter, validation n=4 | v27 curve step 4000, 47.21M | 102/1,971 = 5.175% acceptance; 11.476 tok/s | Approximate; target-content 7/12 |
| Qwen custom drafter, validation n=8 | v27 curve step 3200, 47.21M | 105/3,804 = 2.760%; 9.820 tok/s | Approximate; target-content 5/12 |
| Qwen custom drafter, validation n=16 | v27 epoch 04, 47.21M | 105/7,137 = 1.471%; 8.597 tok/s | Approximate; target-content 7/12 |
| Qwen published drafter, approximate serving | Published Q4_K_M DFlash2 | 52.58% proposal acceptance; 22.408 vs 18.091 tok/s | Failed strict identity on 4/6 prompts |

## Experiment cards

| ID | Question | Outcome | Key observation |
|---|---|---|---|
| [EXP-20260819-001](../experiments/cards/EXP-20260819-001-smollm-onpolicy20k.md) | Does on-policy training improve the 10.13M bridge? | Limited positive | 7.1566% acceptance; 90/90 exact |
| [EXP-20260819-002](../experiments/cards/EXP-20260819-002-smollm-capacity35m.md) | Does capacity alone improve acceptance? | Negative | Better loss/accuracy; acceptance fell 4.52% relative |
| [EXP-20260820-001](../experiments/cards/EXP-20260820-001-qwen-published-dflash-runtime.md) | Is published Qwen DFlash exact and faster? | Approximate positive, exactness negative | +23.86% approximate speed; 4/6 outputs diverged |
| [EXP-20260821-001](../experiments/cards/EXP-20260821-001-qwen-v27-curve.md) | Which training point and proposal length work best? | Validation incumbent | n=4 step4000 selected |
| [EXP-20260821-002](../experiments/cards/EXP-20260821-002-qwen-v28-small-drafter.md) | Does a smaller drafter improve throughput? | Negative | Acceptance and throughput both declined |
| [EXP-20260821-003](../experiments/cards/EXP-20260821-003-qwen-v29-early4.md) | Does early-position-only CE improve n=4? | Negative | 5.175% to 4.819% acceptance |
| [EXP-20260821-004](../experiments/cards/EXP-20260821-004-qwen-v30-quantization.md) | Does draft quantization improve serving? | Small approximate gain | Q8_0 +0.65% vs F16, still below target-only |
| [EXP-20260821-005](../experiments/cards/EXP-20260821-005-qwen-v31-block17-alignment.md) | Do block-shape-aligned target states improve acceptance? | Negative bounded result | Accuracy rose; acceptance did not |
| [EXP-20260821-006](../experiments/cards/EXP-20260821-006-smollm-1layer-vs-5layer.md) | Does five-layer capacity beat the one-layer drafter? | Acceptance positive, speed negative | 7.1566% vs 6.0045% acceptance, but 12.4785 vs 14.4277 tok/s; 180/180 exact |
