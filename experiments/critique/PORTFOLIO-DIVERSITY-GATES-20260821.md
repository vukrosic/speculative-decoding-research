---
id: PORTFOLIO-DIVERSITY-GATES-20260821
date: 2026-08-21
status: review-complete-blocked
scope: experiment-card-and-receipt portfolio duplication/confounding audit
authorization: documentation-only; no run, approval, or queue mutation
---

# Portfolio diversity-gate audit — 2026-08-21

## Verdict

**BLOCKED for independent-portfolio claims; no experiment is created or
approved by this note.** The repository contains useful bounded observations,
but several records are members of the same causal family and must not be
counted as independent evidence. The smallest safe repair is to attach the
family and metric fields below to every future card and to consolidate each
family before opening another rung. Existing cards, receipts, queue state, and
negative results remain unchanged.

## Adversarial family audit

| Family | Records reviewed | Duplication/confound finding | Diversity disposition |
|---|---|---|---|
| SmolLM draft capacity/depth | `EXP-20260819-002`, `EXP-20260821-006`, `EXP-20260821-007`, `EXP-20260821-008`, and proposed `PQ-20260821-003` | All vary draft depth/parameterization against the same SmolLM target/evaluator lineage. The 2/3/5-layer branch reports the same 7.1566% fixed-slice acceptance while changing depth; EXP-006/007 select identity-initialized epoch-0 checkpoints, so their observations are not independent training-depth effects. | Treat as one depth/capacity family and one pooled acceptance/latency evidence class. Do not open another depth rung without a pre-registered level and a reason that is not “more capacity.” |
| Qwen objective/selection | `EXP-20260821-001` (v27 curve), `EXP-20260821-003` (v29 early4), proposed `PQ-20260821-002` | Same Qwen architecture, data lineage, evaluator, and repeatedly searched validation screen. v29 is a continuation from a validation-selected v27 checkpoint; PQ-002 is a new objective, not an independent replication. Objective implementation is currently absent from the pinned trainer tree (see `PQ-20260821-002-IMPLEMENTATION-GATE-CRITIQUE-20260821.md`). | Count v27 as the parent/selection reference and v29 as a negative control. PQ-002 may be compared only after its implementation artifact, hash, and CEO amendment are added; no second objective card may reuse the same selection screen as if fresh evidence. |
| Qwen execution-shape/state interface | `EXP-20260821-005` (block-17 feature alignment), proposed `PLAN-20260821-001`, proposed `PQ-20260821-005` | All address singleton-versus-block target-state mismatch. Alignment changes feature extraction and corpus size; PQ-005 would add a state-consistency term, so treating them as a clean sequence would confound data and objective. PLAN-001 is diagnostic, not a training replication. | Run/order is diagnostic-first in design only: establish the evaluator/state contract before any consistency training. PQ-005 must freeze one feature manifest and one coefficient; it cannot claim an alignment-only or runtime-only effect. |
| Qwen serving/runtime trade-off | `EXP-20260820-001`, `EXP-20260821-004` (v30 quantization), proposed `PQ-20260821-004` | Quantization, published runtime behavior, and adaptive scheduling are distinct mechanisms but share the small approximate Qwen screen and target-only speed comparison. Repeating the screen without a new policy or component-level hypothesis would be duplicate measurement, not a new causal result. | Keep separate subfamilies (format, runtime semantics, scheduler), but require the same frozen evaluator tuple and matched target-only control. A speed result cannot be promoted from acceptance or target-content alone. |
| Baseline/lineage controls | `EXP-20260819-001`, v27/v30 references, and existing target-only receipts | These are parent checkpoints, controls, or incumbent measurements, not independent causal experiments. Reusing a validation-selected incumbent as a fresh baseline creates selection leakage. | Label each use as `parent`, `negative-control`, or `target-only-control`; never count it as a replicate unless the data, prompts, and selection boundary are independently sealed. |

## Mandatory diversity gates for a new card

1. **One causal axis.** Declare exactly one `changed_variable`; freeze target,
   drafter architecture (unless that is the axis), tokenizer/prompt order,
   data/splits, evaluator, runtime/build, seed, decoding, hardware, and parent
   artifact hashes. A changed feature manifest, objective, and architecture in
   one card is a confounded card, not a diversity point.
2. **Distinct mechanism or pre-registered rung.** Assign a `family_id` and
   mechanism (`capacity`, `objective`, `state-interface`, `quantization`, or
   `scheduler`). A same-family card is allowed only as a pre-registered level
   with a frozen parent and a pooled family analysis; otherwise it is rejected
   as duplicate portfolio coverage.
3. **Metric contract.** Pin denominator and cycle definition, proposal lengths,
   target-only baseline, warmups, repetitions, output-token accounting,
   latency/VRAM capture, and evaluator command/dependency hashes. Report
   acceptance, target-content, strict exactness, quality, and speed in separate
   fields. Exactness is not inferred from acceptance; speed is not inferred
   from accepted tokens.
4. **Evidence-class boundary.** Mark each result as teacher-forced,
   autoregressive acceptance, target-content/quality, strict exactness,
   end-to-end speed, or resource/cleanup. Do not pool classes or use a proxy
   class to promote a claim in another class. Validation selection is evidence
   for that screen only; held-out remains sealed.
5. **Selection and multiplicity.** Record every searched checkpoint,
   proposal length, prompt, and threshold. Freeze at most one selection rule
   before replay; do not compare a newly selected winner to the same exposed
   validation screen as though it were an untouched replicate.
6. **Lifecycle/provenance/safety.** Link the card to its approval/dependency
   state and named receipt directory. Every receipt must include source,
   model/dataset/tokenizer/runtime/evaluator hashes, terminal process/GPU state,
   cleanup, and exactness boundary. A runtime policy or wrapper is a new code
   artifact and requires its own manifest/approval; it cannot be smuggled into
   an existing one-variable card.

## Current action boundary

This audit is an index/critique update only. It does not authorize PQ-002,
PQ-003, PQ-004, PQ-005, PLAN-20260821-001, or any additional capacity rung.
The existing implementation, evaluator, provenance, and user-approval blocks
remain authoritative.

