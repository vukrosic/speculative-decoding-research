---
id: EXP-20260821-007-smollm-3layer-vs-1layer
date: 2026-08-21
status: completed-bounded
method: DFlash2-style intermediate-depth capacity comparison
exactness_contract: fixed-90 target-equivalent outputs with exact guard enabled
heldout_touched: false
tags: [smollm, dflash2, capacity, acceptance, throughput, bounded]
---

# Can intermediate depth retain the five-layer acceptance gain more cheaply?

## Question

On the frozen SmolLM2-135M target, does a three-layer DFlash2-style drafter
improve accepted draft tokens and end-to-end throughput relative to the
6,520,256-parameter one-layer incumbent, while avoiding the five-layer
candidate's measured latency penalty?

## Authorization and scope

- Current user authorization: the user explicitly said “go” and “continue GPU
  experiments” on 2026-08-21, authorizing this bounded 3-layer continuation.
- Executed action: constructed, smoke-tested, trained, and evaluated one
  additive three-layer candidate using existing artifacts only.
- Explicit exclusions: no new data generation, downloads, installs, target
  changes, runtime changes, or final sealed held-out evaluation.
- Stop conditions: construction/parameter/finite-loss failure; incorrect
  fixed-prompt outputs; disk or VRAM risk; or completion of the fixed-90
  acceptance and repeated timing comparison.
- Artifact budget: one remote candidate checkpoint plus compact metrics,
  acceptance, timing, and terminal receipts. Large artifacts remain remote.

## Frozen controls

- Target: the existing SmolLM2-135M-Instruct snapshot and tokenizer used by
  EXP-20260821-006.
- Baseline drafter: the existing 6,520,256-parameter one-layer checkpoint
  `checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best`.
- Data: existing on-policy-20k corpus, 18k train / 1k validation / 1k test;
  no new trajectories or features.
- Fixed comparison slice: 90 prompts, 30 each chat, code, and document, in
  frozen order. This is development evidence, not a final sealed holdout.
- Block: size 4 / 3 speculative proposals; greedy decoding;
  `max_new_tokens=32`; acceptance seed `20260819`; training seed `20260820`.
- Evaluator/runtime: existing official DFlash2 modules and compatibility
  bridge, official source commit
  `07ebd93db9f472af339b644bb70221ad8428328a`, exact guard enabled.
- Hardware: existing RTX 3060 12 GB environment and `/workspace/vllm-venv`.

## Intended change

Change only draft decoder depth from one layer to three layers. Use the same
residual-identity expansion convention as EXP-20260821-006, then apply the
same existing on-policy training protocol and validation-loss early stopping.
Record the exact parameter count from the saved tensors; do not infer it from
the layer count.

## Baseline and promotion gate

- Baseline fixed-90 results in this matched timing run: 6.0045% acceptance,
  0.1764 accepted draft tokens/cycle, 14.4526 tok/s, and 180/180 exact
  guarded outputs.
- Five-layer reference: 7.1566% acceptance, 0.2104 accepted/cycle, but
  12.4785 tok/s and 180/180 exact outputs.
- Promotion requires all exact-output gates to pass and the three-layer model
  to beat the one-layer model on matched end-to-end tok/s. If it only improves
  acceptance but is slower, preserve it as a non-promoted research result.

## Preflight gates

- [x] construction receipt and saved tensor shapes
- [x] exact total/trainable parameter count: 13,738,944
- [x] finite forward/loss/backward and nonzero gradients
- [x] additive checkpoint and provenance paths
- [x] validation split integrity and no new data
- [x] fixed-90 evaluator exactness
- [x] repeated matched timing
- [x] owned-process cleanup and idle GPU
- [ ] final sealed held-out evaluation (explicitly out of scope)

## Results

### Observed

| Evidence class | Metric | 1-layer baseline | 3-layer candidate | Receipt |
|---|---:|---:|---:|---|
| teacher-forced loss | selected validation CE | 3.438434 | 3.409669 | training metrics |
| teacher-forced accuracy | selected validation | 50.4333% | 50.2667% | training metrics |
| teacher-forced accuracy | per-position | 55.4 / 49.5 / 46.4% | 55.7 / 47.7 / 47.4% | training metrics |
| acceptance | accepted / proposed | 642 / 10,692 | 744 / 10,396 | acceptance/timing |
| acceptance | overall draft-token rate | 6.0045% | 7.1566% | acceptance/timing |
| acceptance | positions 1 / 2 / 3 | 11.978 / 3.535 / 2.294% | 14.706 / 4.155 / 2.357% | acceptance/timing |
| acceptance | mean accepted tokens/cycle | 0.1764 | 0.2104 | acceptance/timing |
| exactness | target-equivalent outputs | 180/180 | 180/180 | acceptance/timing |
| end-to-end speed | tokens/sec | 14.4526 | 13.5385 | timing |
| end-to-end speed | total wall time | 307.903 s | 328.692 s | timing |
| latency | mean / median / p95 | 1.7106 / 1.9428 / 2.3735 s | 1.8261 / 2.0798 / 2.4997 s | timing |
| resource | peak VRAM | 323,866,624 B | 354,971,648 B | timing |

The three-layer candidate changed acceptance by **+1.1521 percentage points**
and **+19.19% relative**, but changed end-to-end throughput by
**-0.9141 tok/s** and **-6.32% relative**. Both models passed the exact guard
for every measured output. The candidate used 3,536 target block verifications
and 4,270 singleton exact-guard calls; the baseline used 3,640 and 4,270.

Training loss fell from 2.7846 to 1.4397 over three epochs, while validation
loss worsened from the identity-initialized 3.4097 to 3.4966, 3.5011, and
3.7446. Epoch 0 was selected by lowest validation CE. Peak training allocation
was 384,974,336 bytes; training duration was 109.213 seconds.

### Interpretation / hypotheses

- **Observed decision:** the three-layer candidate reproduces the five-layer
  epoch-0 acceptance gain on this fixed slice but does not preserve the
  one-layer throughput advantage. It is not promoted.
- **Interpretation:** reducing depth from five to three recovers throughput
  (13.5385 versus 12.4785 tok/s in the prior 5-layer run) but still loses to
  the one-layer incumbent (14.4526 tok/s). The acceptance gain remains too
  small to pay for added draft compute.
- **Training limitation:** epoch 0 was selected, so this is primarily an
  identity-initialized intermediate-capacity result, not evidence that the
  three-layer training run improved validation behavior.
- The 90-prompt slice and two timing repetitions are bounded development
  evidence, not a broad workload or production-SLO claim.

## Decision

- Promotion decision: do not promote the three-layer model as the serving
  incumbent. Preserve it as an acceptance-positive, throughput-negative
  research candidate.
- The next higher-value direction is acceptance-calibrated training or
  verifier/runtime fidelity, not another blind depth increase.

## Reproduction

```bash
ssh -p 35738 root@125.240.239.50
cd /workspace/smollm-eagle3-prototype
/workspace/vllm-venv/bin/python -m dflash2_adapter.expand_capacity3_bounded \
  --source checkpoints/dflash2-official-bridge-block3-onpolicy20k-best \
  --output checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-init
/workspace/vllm-venv/bin/python -m dflash2_adapter.capacity_fit_smoke \
  --states benchmarks/dflash2-block3-onpolicy20k-anchors-v1 \
  --target-snapshot hf-cache/models--HuggingFaceTB--SmolLM2-135M-Instruct/snapshots/12fd25f77366fa6b3b4b768ec3050bf629380bac \
  --small-checkpoint checkpoints/dflash2-official-bridge-block3-onpolicy20k-best \
  --large-checkpoint checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-init \
  --output benchmarks/dflash2-block3-capacity3layer-bounded-20260821-fit-smoke-parent.json
/workspace/vllm-venv/bin/python -m dflash2_adapter.train_onpolicy20k \
  --states benchmarks/dflash2-block3-onpolicy20k-anchors-v1 \
  --target-snapshot hf-cache/models--HuggingFaceTB--SmolLM2-135M-Instruct/snapshots/12fd25f77366fa6b3b4b768ec3050bf629380bac \
  --initial-checkpoint checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-init \
  --output checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-trained \
  --epochs 6 --batch-size 32 --learning-rate 0.0002 --weight-decay 0.01 \
  --early-stop-patience 3 --seed 20260820 --device cuda
/workspace/vllm-venv/bin/python -m dflash2_adapter.evaluate_onpolicy20k_acceptance \
  --trajectories datasets/dflash2-block3-onpolicy20k-trajectories-v1 \
  --target-snapshot hf-cache/models--HuggingFaceTB--SmolLM2-135M-Instruct/snapshots/12fd25f77366fa6b3b4b768ec3050bf629380bac \
  --baseline-checkpoint checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best \
  --candidate-checkpoint checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-trained \
  --output benchmarks/dflash2-block3-capacity3layer-bounded-20260821-fixed90-acceptance.json \
  --prefixes-per-category 30 --max-new-tokens 32 --seed 20260819 --device cuda
/workspace/vllm-venv/bin/python -m dflash2_adapter.benchmark_capacity3_bounded \
  --trajectories datasets/dflash2-block3-onpolicy20k-trajectories-v1 \
  --target-snapshot hf-cache/models--HuggingFaceTB--SmolLM2-135M-Instruct/snapshots/12fd25f77366fa6b3b4b768ec3050bf629380bac \
  --acceptance-receipt benchmarks/dflash2-block3-capacity3layer-bounded-20260821-fixed90-acceptance.json \
  --one-layer-checkpoint checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best \
  --three-layer-checkpoint checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-trained \
  --one-layer-metrics checkpoints/dflash2-official-bridge-block3-capacity6520256-layer0-onpolicy20k-best/capacity6520256_metrics.json \
  --three-layer-metrics checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-trained/onpolicy20k_metrics.json \
  --output benchmarks/dflash2-block3-capacity3layer-bounded-20260821-timing.json \
  --repetitions 2 --max-new-tokens 32 --seed 20260819
```

## Artifacts and receipts

- Initialization receipt:
  `checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-init/capacity3_initialization_receipt.json`;
  SHA-256 `13a0d83dff38fc34c2ad291518adcc09cbf776ad87ab70b293388805d888c2fe`.
- Candidate initialization directory-manifest SHA-256:
  `c69ffaf7681689d1805aa94dc1174bcdc5d763464e5be5d011bbafe26febd109`.
- Parent-preservation/fit receipt:
  `benchmarks/dflash2-block3-capacity3layer-bounded-20260821-fit-smoke-parent.json`;
  SHA-256 `160cdbb88acd09ae5b18b9e051c6c5fa3e8a079bf66e10f845ffd5466a9ec037`.
- Deliberately mismatched diagnostic receipt (1-layer versus 3-layer init):
  `benchmarks/dflash2-block3-capacity3layer-bounded-20260821-fit-smoke.json`;
  SHA-256 `bdd06596d796c5ca133b22301d990e87d52d128baffc8bf5878ced6c66de9167`.
- Candidate training metrics:
  `checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-trained/onpolicy20k_metrics.json`;
  SHA-256 `98a2853d276eaa75995c297c5150b13131fdd3382dcdf6f63b7bc551cd1e350e`.
- Candidate trained directory-manifest SHA-256:
  `82ab94cb21251a6c1d2b04a0a398fbef2b7d9d2a06ba5acba3a57c417f50436d`.
- Acceptance receipt:
  `benchmarks/dflash2-block3-capacity3layer-bounded-20260821-fixed90-acceptance.json`;
  SHA-256 `83bcc7e5726bcfd580b47bd6c4b5ab38c5cef6c0f1fed6f1384b45daa54b6a02`.
- Timing receipt:
  `benchmarks/dflash2-block3-capacity3layer-bounded-20260821-timing.json`;
  SHA-256 `c682060fe4d97c6043140bcf445f2afb5665985133da5cbefc835bc59eabd7ef`.
- Remote helper scripts:
  `dflash2_adapter/expand_capacity3_bounded.py` SHA-256
  `29f0ec805f98b8c84a205248a68f48fdf9e3df14c122b0c30824c7ab3ccf1ece`;
  `dflash2_adapter/benchmark_capacity3_bounded.py` SHA-256
  `300e0053d30b067ccb6df7ec5d367a6b7660d151d41456971b79dc59c929cc2d`.
- Logs remain at their additive remote paths; large artifacts were not copied
  into this compact repository.
- Final remote state: task-owned tmux sessions/processes absent; RTX 3060 at
  0% utilization and 1 MiB used.

## Failures and amendments

- 2026-08-21: registered as a bounded continuation after the five-layer
  candidate improved acceptance but lost end-to-end throughput.
- 2026-08-21: an earlier planning version recorded the card as documentation-
  only; the user's later “go” and “continue GPU experiments” instruction
  superseded that planning state and authorized this bounded run.
- 2026-08-21: the first generic fit smoke compared the three-layer candidate
  to the one-layer model and reported non-identical logits (max absolute
  difference 10.8671875). This was the wrong function-preservation control,
  not a candidate failure. The corrected two-layer-parent comparison passed
  with exact logits and zero difference; both receipts are preserved.

## Follow-up questions

- If three layers still lose throughput, should future capacity work stop in
  favor of acceptance-calibrated training or verifier/runtime fidelity?
