# Research roadmap

## Phase 1: foundations and receipts

- Standardize target, drafter, runtime, hardware, dataset, and benchmark cards.
- Build exactness tests with rejection at every proposal position, EOS,
  correction, cache commit/rollback, mask, and position negative controls.
- Define comparable acceptance and end-to-end benchmark contracts.

## Phase 2: method reproduction

- Reproduce DFlash/DFlash2, EAGLE-family, MTP/NEXTN, Medusa, prompt lookup, and
  block-diffusion baselines on small targets.
- Distinguish official implementations from compatibility bridges.

## Phase 3: training science

- Data distribution, source leakage, anchors, later-position coverage.
- Hard-label CE versus target-logit distillation and position-aware objectives.
- Capacity, selector, target-layer interface, and proposal-length ablations.
- Select on validation acceptance, then run sealed evaluation once.

## Phase 4: verifier and runtime science

- Numerical shape dependence across quantization and attention backends.
- KV/cache transaction semantics and exact correction handling.
- Target-call accounting, launch overhead, batching, and adaptive block length.

## Phase 5: hardware and deployment

- Break-even analysis across GPU generations, memory bandwidth, VRAM, power,
  and batching regimes.
- Exact and approximate product contracts by workload.
- Reproducible serving recipes with complete receipts.

## Phase 6: new research

- Acceptance-calibrated training objectives.
- Learned adaptive proposal length and verifier-aware curricula.
- Hybrid DFlash/block-diffusion/tree drafting.
- Quantization-aware target-state interfaces.

