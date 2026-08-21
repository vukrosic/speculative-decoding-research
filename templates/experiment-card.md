---
id: EXP-YYYYMMDD-NNN-short-slug
date: YYYY-MM-DD
status: planned
method: unknown
exactness_contract: unknown
heldout_touched: false
tags: []
---

# Question

State one falsifiable question.

## Authorization and scope

- Authorized action:
- Explicit exclusions:
- Stop conditions:
- Artifact/storage budget:

## Frozen controls

- Target checkpoint and SHA-256:
- Drafter parent/checkpoint and SHA-256:
- Tokenizer:
- Dataset/splits and hashes:
- Evaluator and hash/commit:
- Prompt IDs/order:
- Seed and generation settings:
- Hardware/runtime contract:

## Intended change

Exactly one variable, or clearly label this experiment as bundled/confounded.

## Environment

- GPU / VRAM:
- CPU / RAM:
- Driver / CUDA or ROCm:
- OS / kernel:
- Runtime / framework / commit:
- Compiler / attention backend / kernels:
- Python/environment identity:

## Data

- Source and provenance:
- Train / validation / test counts:
- Leakage and deduplication checks:
- Held-out seal:

## Objective and hyperparameters

- Objective:
- Optimizer:
- Learning rate / schedule:
- Batch / accumulation:
- Epochs / steps / selection rule:
- Precision:
- Seed:
- Other:

## Baseline

Name the exact baseline and receipt.

## Preflight gates

- [ ] construction and tensor shapes
- [ ] exact total/trainable parameter counts
- [ ] finite forward/loss/backward
- [ ] nonzero relevant gradients
- [ ] optimizer step
- [ ] bounded fit/learning check
- [ ] evaluator and negative controls
- [ ] data/split/hash integrity
- [ ] disk/GPU/process ownership

## Results

### Observed

| Evidence class | Metric | Baseline | Candidate | Receipt |
|---|---:|---:|---:|---|
| loss | | | | |
| accuracy | | | | |
| acceptance | | | | |
| quality | | | | |
| exactness | | | | |
| end-to-end speed | | | | |

Include per-position acceptance, accepted tokens per verification, output token
counts, latency distribution, peak VRAM, and repeated-run variation when
applicable.

### Interpretation / hypotheses

Separate explanation from measurement. State confounders and uncertainty.

## Decision

- Promotion decision:
- Why:
- What this does not establish:

## Reproduction

```bash
# exact working directory and command
```

## Artifacts and receipts

- Checkpoint identity/path/hash/size:
- Metrics receipt:
- Benchmark receipt:
- Logs:
- External artifacts:
- Cleanup/final GPU state receipt:

## Failures and amendments

Append dated failures, corrections, and protocol deviations here.

## Follow-up questions

-

