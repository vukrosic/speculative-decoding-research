---
id: DRAFTER-qwen-compact-v27
kind: drafter
status: validation-incumbent
---

# Qwen compact DFlash v27

- Compatible target: Qwen3.8-27B IQ1_S.
- Architecture: selector-free compact DFlash block-17.
- Total/trainable parameters: 47,206,656.
- Proposal positions trained: 16; practical validation selection n=4.
- Target interface: hidden width 5,120, target layer 62, shared frozen output
  head.
- Objective: hard successor-token CE, position weight gamma 8, label smoothing
  0.02.
- Data: v23f 9,944 train / 508 source-disjoint validation windows.
- Optimizer: AdamW 1e-4, betas 0.9/0.95, wd 0.01, batch 2, seed 42.
- n=4 checkpoint: curve step 4000; SHA-256
  `cf97d59ff143ff3f6a06d86cab9952e548178b4f97508ea0a40062d7c1cf1a28`.
- F16 export SHA-256:
  `e29bcb57dceafcf651431cba9eac16012c96e6f4f979bf01c10921b939fbee78`.
- Exactness: not established; 7/12 target-content matches on validation.
- Best n=4 screen: 5.175% acceptance, 0.20198 accepted/cycle,
  11.476 tok/s versus 17.592 target-only.

