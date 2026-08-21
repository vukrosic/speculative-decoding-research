---
id: EXP-20260821-002-qwen-v28-small-drafter
date: 2026-08-21
status: completed-negative
method: compact-drafter capacity reduction
exactness_contract: approximate validation screen; exact heldout sealed
heldout_touched: false
tags: [qwen, dflash2, capacity, throughput, negative-result]
---

# Does a smaller Qwen drafter improve end-to-end throughput?

## Intended change

Reduce draft attention to 4 query heads / 1 KV head and FFN width 256 while
keeping the 5,120-wide target interface and up to 16 proposals. Result:
36,720,896 trainable parameters versus 47,206,656 for v27.

Target, data (9,944/508), hard-label CE family, held-out seal, runtime, validation
screen, optimizer family, seed, and target-only baseline remained fixed.

## Observed

Four epochs reached 47.65% mean validation token accuracy, below v27’s 48.73%.

| Proposals | Accepted/proposed | Acceptance | Accepted/cycle | Tok/s |
|---:|---:|---:|---:|---:|
| 4 | 85/2,040 | 4.167% | 0.16284 | 11.118 |
| 8 | 72/4,051 | 1.777% | 0.13433 | 9.300 |
| 16 | 77/7,502 | 1.026% | 0.14556 | 8.262 |

Target-content matches were 7/12, 5/12, and 7/12; exactness failed. Peak VRAM
was approximately 8,063/8,697/9,913 MiB for n=4/8/16.

## Interpretation / hypotheses

Reducing draft parameters did not improve complete throughput because the lost
acceptance outweighed draft savings. Target verification, shared target-head
work, and runtime overhead remain likely dominant costs.

## Reproduction

```bash
/workspace/vllm-venv/bin/python scripts/train_small4h1ff256_v28.py
bash run_compact_dflash16_validation_screen_v23.sh
```

## Artifacts and receipts

- Epoch-4 checkpoint SHA-256:
  `0e9e57319ead55ab9fa604d632d9b70eaaed4e5b402a19e6ec431054ebb397d3`
- Export SHA-256:
  `eeef850d6a27c0d1a9930ce3717ed1e5c48eaa9e5a785b5ea50379b27c1b3d41`
- Exact held-out remained sealed.

