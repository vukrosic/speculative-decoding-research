# Datasets and splits

| ID | Purpose | Counts | Leakage/held-out status |
|---|---|---:|---|
| DATASET-smollm-onpolicy20k | SmolLM block-3 on-policy trajectories | 18k train / 1k validation / 1k test | Fixed untouched test during selection |
| DATASET-qwen-v23f-windows | Qwen compact drafter features and successor labels | 9,944 train / 508 validation | Source-disjoint validation; held-out sealed |
| DATASET-qwen-v31-block17-1536 | Block-17-aligned bounded continuation subset | 1,536 train / 152 validation | Source-disjoint; held-out untouched |

Large dataset files are not stored in Git. Record manifests, hashes, and
external artifact identities only.

