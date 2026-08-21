---
id: EXP-20260821-005-qwen-v31-block17-alignment
date: 2026-08-21
status: completed-negative
method: deployment-shape-aligned feature continuation
exactness_contract: approximate validation screen; exact heldout sealed
heldout_touched: false
tags: [qwen, dflash2, feature-alignment, quantization, negative-result]
---

# Do block-17-aligned IQ1_S target states improve deployment acceptance?

## Question and protocol

The original compact corpus used batch-one target features, while deployment
verifies blocks. Extract target features in 17-token teacher-forced chunks,
validate alignment, continue the 47,206,656-parameter v27 parent on 1,536 train
windows, select on 152 source-disjoint validation windows, and screen proposal
lengths 4/8/16. Held-out stayed sealed.

Controls: target/hash, target layer 62, tokenizer, architecture, optimizer
(AdamW 1e-4, betas 0.9/0.95, wd 0.01), batch 2, seed 42, gamma-8 hard CE,
label smoothing 0.02, runtime, and validation acceptance evaluator.

## Preflight observed

- New block-17 feature alignment and successor-label hashes passed.
- Target state was materially batch-shape dependent:
  - auxiliary context RMSE 1.0999;
  - target hidden RMSE 0.2648;
  - all 5,120 anchor and mask elements matched exactly.
- Finite construction/loss/backward/optimizer gates passed.

## Observed

Epoch 5 raised validation teacher-forced accuracy from 42.434% to 43.051%, but
acceptance did not improve:

| Proposals | v31 epoch 5 | v27 incumbent | v31 tok/s |
|---:|---:|---:|---:|
| 4 | 96/1,995 = 4.812% | 102/1,971 = 5.175% | 11.352 |
| 8 | 105/3,806 = 2.759% | 105/3,804 = 2.760% | 9.788 |
| 16 | 102/7,153 = 1.426% | 105/7,137 = 1.471% | 8.631 |

Neighboring epoch n=4 screens were also lower: epoch 4, 4.399%; epoch 6,
4.350%. No candidate was promoted.

## Interpretation / hypotheses

Deployment-shape alignment is a real data-interface issue, but this bounded
continuation shows it is not sufficient by itself to improve acceptance.
Possible remaining causes include objective mismatch, limited aligned data,
parent initialization tied to batch-one states, and small-screen variance.

## Reproduction

```bash
cd /workspace/smollm-eagle3-prototype/experiments/qwen38-27b-iq1s-dflash2-autoresearch-v31-margin-20260821
bin/extract_features_compact_v31_block17 --config manifests/block17-subset-1536-v31
/workspace/vllm-venv/bin/python scripts/train_block17_gamma8_ls002.py
bash /workspace/smollm-eagle3-prototype/run_compact_dflash16_validation_screen_v23.sh
```

The extractor command above is a compact reconstruction; exact historical
flags remain in the external v31 scripts/logs and must be verified before reuse.

## Artifacts and receipts

- Epoch-5 checkpoint SHA-256:
  `d0b06f12a3cce004f1b195790e996cd1db00408b81279a9c2c42c535c37ba002`
- Epoch-5 export SHA-256:
  `d624011f59eedb78d65d230cf4556497a374a0de3fd9375a146db254ed1d302b`
- Best-setup documentation SHA-256:
  `18ef23b5de0683f16ff2aa50ce183ee85c86e352efadd5cdaeddd0ffebfa74df`
- Final recorded state: GPU idle, no task-owned process/tmux. Disk was 3.8 GB
  free and below the 4 GB reserve, so no further feature extraction started.

