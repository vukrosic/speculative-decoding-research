# Research roadmap

## Public research-kit release track

The repository is being published in two layers: a friendly, runnable public
surface and a richer internal lab archive. The public layer starts with the
dependency-free toy example, reusable method notes, sanitized summaries,
license, citation file, and release-boundary checklist. Internal governance,
raw receipts, and private executor details remain local until individually
sanitized.

The first release is deliberately a research kit, not a production inference
package. A future release can add model/runtime adapters once a second clean
example demonstrates that the interface is portable.

## Current operating focus — 2026-08-21

1. Complete the queued literature review on verifier fidelity, rejection and
   correction, KV-cache semantics, and quantized shape dependence.
2. Turn its claim-to-test table into one bounded experiment card with frozen
   controls and separate approximate/exact contracts.
3. Have the experiment critic repair or reject the design before it reaches the
   user for explicit approval.
4. Execute only after approval; then update receipts, results, failures,
   questions, and the daily note before selecting another test.

This focus reconciles the current evidence: capacity and teacher-forced gains
have not reliably improved acceptance or end-to-end speed, while Qwen verifier
fidelity and contiguous-prefix behavior remain unresolved. See
[`docs/ORCHESTRATION.md`](ORCHESTRATION.md) and [`queue/INDEX.md`](../queue/INDEX.md)
for the live handoffs and approval state.

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
