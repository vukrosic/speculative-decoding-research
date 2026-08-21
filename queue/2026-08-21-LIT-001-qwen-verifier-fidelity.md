# LIT-20260821-001 — Qwen verifier fidelity and shape dependence

Status: `planned` (canonical handoff complete; planner linked)  
Approval: `NOT REQUESTED` (read-only documentation task)  
Created: 2026-08-21  
Owner: literature reviewer  
Next handoff: experiment planner

## Question

What do the primary DFlash/DFlash2 and speculative-decoding sources, plus the
pinned runtime implementation, establish about block verification, rejection
and correction, KV-cache commit/rollback, quantized shape dependence, and the
conditions for exact target-equivalence?

## Scope and exclusions

- Read primary papers and official implementation/runtime material only where
  available; record version or commit.
- Inspect existing repository cards, receipts, and runtime metadata.
- Do not run code, download artifacts, contact anyone, or alter external state.
- Do not present paper metrics as this repository's measurements.

## Required output

Create one paper/implementation note using `templates/paper-note.md` that has:

1. authors' claims;
2. directly observed code behavior;
3. our interpretation and unknowns;
4. exactness contract and rejection/correction semantics;
5. target-state, quantization, and shape assumptions;
6. reproducibility gaps;
7. a claim-to-test table for the planner.

## Current evidence-review finding

The repository now contains a source list, comparison, synthesis, linked
per-paper/runtime notes under `literature/`, and the canonical note
[`papers/PAPER-20260821-verifier-fidelity-dflash-qwen.md`](../papers/PAPER-20260821-verifier-fidelity-dflash-qwen.md)
with the dated handoff
[`literature/HANDOFF-20260821-LIT-001.md`](../literature/HANDOFF-20260821-LIT-001.md).
Unknown build/environment metadata remains explicitly preserved and is a
mandatory preflight stop condition for the linked diagnostic card.

## Source-of-truth links

- `docs/ORCHESTRATION.md`
- `CURRENT-STATE.md`
- `experiments/cards/EXP-20260820-001-qwen-published-dflash-runtime.md`
- `experiments/cards/EXP-20260821-005-qwen-v31-block17-alignment.md`
- `runtimes/RUNTIME-llamacpp-dflash-pr27342.md`
- `papers/INDEX.md`
- `templates/paper-note.md`

## Gate and handoff

The canonical note separates **Observed**, **Hypothesis**, and
**Recommendation**, lists what cannot be established, and makes the `papers/`
relationship explicit. The planner has linked a single falsifiable probe. This
status transition does not imply execution approval; CEO approval is recorded
separately.
