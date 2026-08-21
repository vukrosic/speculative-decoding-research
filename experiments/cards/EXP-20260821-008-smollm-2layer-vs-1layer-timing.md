---
id: EXP-20260821-008-smollm-2layer-vs-1layer-timing
date: 2026-08-21
status: completed-bounded
method: DFlash2-style incumbent timing comparison
exactness_contract: fixed-90 target-equivalent outputs with exact guard enabled
heldout_touched: false
tags: [smollm, dflash2, baseline, acceptance, throughput, bounded]
---

# What is the throughput cost of the existing 10.13M two-layer draft?

## Question

The one-layer draft is currently the throughput incumbent, while the existing
two-layer 10.13M bridge is the acceptance incumbent. On the same frozen
SmolLM2 target and fixed 90-prompt contract, does the two-layer model provide a
useful acceptance/latency tradeoff?

## Authorization and scope

- Current user authorization: continue GPU experiments; this was the next
  bounded baseline measurement after EXP-20260821-007.
- Executed scope: evaluated existing checkpoints only; no training, data
  generation, downloads, installs, or target/runtime changes.
- Stop conditions: exact-output failure, artifact mismatch, or completion of
  the fixed-90 acceptance and two-repetition timing receipts.
- Artifact budget: compact additive receipts and one timing helper; no model
  weights or datasets copied into the research repository.

## Frozen controls

- Target: same SmolLM2-135M-Instruct snapshot, tokenizer, target-only oracle,
  runtime, and exact guard as EXP-20260821-007.
- One-layer draft: existing 6,520,256-parameter checkpoint.
- Two-layer draft: existing 10,129,600-parameter
  `dflash2-official-bridge-block3-onpolicy20k-best` checkpoint.
- Data/evaluation: existing on-policy-20k trajectories; fixed 90 prompts, 30
  each chat/code/document, frozen order; final sealed held-out set excluded.
- Settings: block size 4 / 3 proposals, greedy decoding,
  `max_new_tokens=32`, seed `20260819`, two timing repetitions.
- Hardware/runtime: RTX 3060 12 GB; `/workspace/vllm-venv`; PyTorch 2.13.0+cu130;
  CUDA 13.0; official DFlash source commit
  `07ebd93db9f472af339b644bb70221ad8428328a` plus the compatibility bridge.

## Intended change

No model or training change. This is a matched timing/acceptance measurement
of the already-existing two-layer acceptance incumbent against the one-layer
throughput incumbent.

## Promotion gate

Both checkpoints must pass the exact fixed-90 output guard. A speed claim is
allowed only from the complete repeated end-to-end timing receipt. This card
does not promote a new checkpoint.

## Preflight gates

- [x] artifact and parameter identity
- [x] fixed-90 acceptance exactness
- [x] repeated matched timing
- [x] owned-process cleanup and idle GPU

## Results

### Observed

| Evidence class | Metric | 1-layer | 2-layer | Receipt |
|---|---:|---:|---:|---|
| acceptance | overall draft-token rate | 6.0045% | 7.1566% | acceptance/timing |
| acceptance | per-position / accepted per cycle | 11.978 / 3.535 / 2.294%; 0.1764 | 14.706 / 4.155 / 2.357%; 0.2104 | acceptance/timing |
| exactness | target-equivalent outputs | 180/180 | 180/180 | acceptance/timing |
| end-to-end speed | tokens/sec | 14.1751 | 13.8359 | timing |
| latency / VRAM | mean / median / p95; peak | 1.7441 / 1.9852 / 2.4300 s; 323,866,624 B | 1.7868 / 2.0551 / 2.4418 s; 339,124,224 B | timing |

The two-layer model improved acceptance by **+1.1521 percentage points** and
**+19.19% relative**, but reduced end-to-end throughput by **0.3392 tok/s**
and **2.39% relative**. It used 3,536 target block verifications and 4,270
singleton exact-guard calls; the one-layer model used 3,640 and 4,270.

### Interpretation / hypotheses

- **Observed decision:** the existing 10.13M two-layer draft remains the
  acceptance incumbent, but it is not the throughput incumbent on this exact
  guarded RTX 3060 path.
- The measured depth branch is now complete: 2, 3, and 5 layers all reach the
  same 7.1566% fixed-slice acceptance, while 1 layer is fastest. This does not
  prove a universal capacity law, but it rules out blind depth scaling as the
  next serving optimization for this setup.
- The next higher-value direction is acceptance-calibrated training or
  verifier/runtime overhead reduction, not another capacity-only run.

### Interpretation / hypotheses

To be filled only from the terminal receipt. The prior 3-layer and 5-layer
results show that higher acceptance alone may not pay for added draft compute.

## Decision

- Promotion decision: no new checkpoint promoted. Keep the existing two-layer
  draft as the acceptance reference and the one-layer draft as the measured
  throughput reference.
- No speedup claim: the two-layer candidate is slower than one layer despite
  higher acceptance.

## Reproduction

```bash
ssh -p 35738 root@125.240.239.50
cd /workspace/smollm-eagle3-prototype
/workspace/vllm-venv/bin/python -m dflash2_adapter.evaluate_onpolicy20k_acceptance \
  --trajectories datasets/dflash2-block3-onpolicy20k-trajectories-v1 \
  --target-snapshot hf-cache/models--HuggingFaceTB--SmolLM2-135M-Instruct/snapshots/12fd25f77366fa6b3b4b768ec3050bf629380bac \
  --baseline-checkpoint checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best \
  --candidate-checkpoint checkpoints/dflash2-official-bridge-block3-onpolicy20k-best \
  --output benchmarks/dflash2-block3-capacity2layer-bounded-20260821-fixed90-acceptance.json \
  --prefixes-per-category 30 --max-new-tokens 32 --seed 20260819 --device cuda
/workspace/vllm-venv/bin/python -m dflash2_adapter.benchmark_capacity2_bounded \
  --trajectories datasets/dflash2-block3-onpolicy20k-trajectories-v1 \
  --target-snapshot hf-cache/models--HuggingFaceTB--SmolLM2-135M-Instruct/snapshots/12fd25f77366fa6b3b4b768ec3050bf629380bac \
  --acceptance-receipt benchmarks/dflash2-block3-capacity2layer-bounded-20260821-fixed90-acceptance.json \
  --one-layer-checkpoint checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best \
  --two-layer-checkpoint checkpoints/dflash2-official-bridge-block3-onpolicy20k-best \
  --one-layer-metrics checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best/capacity6520256_metrics.json \
  --two-layer-metrics checkpoints/dflash2-official-bridge-block3-onpolicy20k-best/onpolicy20k_metrics.json \
  --output benchmarks/dflash2-block3-capacity2layer-bounded-20260821-timing.json \
  --repetitions 2 --max-new-tokens 32 --seed 20260819
```

## Artifacts and receipts

- Two-layer checkpoint directory-manifest SHA-256:
  `32c45673545530d3cffa0409c8a2a0e8c99485d3c01ea49f00bfb0feb66550c9`.
- Two-layer metrics SHA-256:
  `2f0eb8d899b90566f65242e12e27bccbdd5bbfc995198c76e3642dcd7240d993`.
- Acceptance receipt:
  `benchmarks/dflash2-block3-capacity2layer-bounded-20260821-fixed90-acceptance.json`;
  SHA-256 `b7d4fe37fbcf2a26ecaa0e07d428dac3324e53cccd51a8faaf9ba7f27b4dc1e5`.
- Timing receipt:
  `benchmarks/dflash2-block3-capacity2layer-bounded-20260821-timing.json`;
  SHA-256 `f95bfbe45d1dd82417da24a1b09d0216be7d53088fde5431ef4ecb83e70497aa`.
- Timing helper SHA-256:
  `32a67d45b37f7680d42c2cf1aec21068f58436494df6f45517b6d4c513079864`.
- Logs remain at their additive remote paths; no large artifacts were copied
  into the compact repository.
- Final remote state: owned processes and tmux sessions absent; RTX 3060 at 0%
  utilization and 1 MiB used.

## Failures and amendments

- 2026-08-21: opened as the next baseline measurement after intermediate depth
  improved acceptance but remained slower than the one-layer incumbent.
- 2026-08-21: timing confirmed the two-layer acceptance incumbent is still
  2.39% slower end to end than the one-layer draft under the matched contract.
