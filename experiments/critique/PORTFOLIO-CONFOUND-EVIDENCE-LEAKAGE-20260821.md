---
id: PORTFOLIO-CONFOUND-EVIDENCE-LEAKAGE-20260821
date: 2026-08-21
status: review-complete-blocked
scope: diversity portfolio, PLAN-001, PQ-002, and PQ-004 adversarial audit
authorization: documentation-only; no status, approval, card, queue, or run mutation
---

# Portfolio confound and evidence-leakage audit — 2026-08-21

## Verdict

**BLOCKED for cross-proposal inference.** The portfolio has distinct named
questions, but several proposals reuse the same state/evaluator boundary and
validation screens while changing different layers of the stack. Their results
must not be pooled as independent evidence. The highest-information safe action
is one read-only, source-backed PLAN-001 evaluator/Arm-B contract manifest that
can be reused as a dependency by PQ-002, PQ-004, and PQ-005; it is not a run or
an authorization.

## Adversarial findings

### Duplicated mechanisms

- **State/interface family:** v31 block-17 alignment, PLAN-001 singleton versus
  block schedule, and PQ-005 paired-state consistency all address the same
  singleton/deployment-shaped target-state uncertainty. V31 is not alignment-
  only because feature extraction and corpus size changed; PQ-005 must not be
  counted as an independent mechanism until PLAN-001's contract is resolved.
- **Objective family:** v27 curve selection, v29 early-position continuation,
  and PQ-002 all reuse the Qwen architecture/data/evaluator lineage and the
  exposed validation screen. V29 is a negative control/continuation from a
  selected v27 checkpoint, not an independent objective replication. PQ-002's
  implementation inventory is terminal negative; no candidate satisfies its
  frozen tuple.
- **Runtime family:** v30 quantization, the published runtime result, and PQ-004
  all reuse the approximate target-only serving screen. Quantization and
  adaptive scheduling are distinct mechanisms, but a repeated screen without an
  immutable selector or component-level overhead hypothesis is duplicate
  measurement, not new causal evidence.

### Hidden confounds

- PLAN-001's historical v20–v22 block examples are not proven to be the exact
  pinned Arm-B schedule; unresolved evaluator fields and `[171,171]` versus
  `[170,170]` memory-after values can change the causal interpretation.
- PQ-002 has no approved implementation artifact, source/file-set hash,
  objective-only diff, or exact command. An ephemeral wrapper would silently
  change the frozen code boundary and is inadmissible without a CEO amendment.
- PQ-004 has no DFlash2-compatible confidence score, threshold calibration,
  deterministic selector, EOS/tie/NaN rules, or scheduler-overhead counters;
  `p_min` and DSpark paths cannot be substituted.
- PQ-005 would bundle feature/state data, subset size, parent continuation, and
  a new consistency term unless each is frozen separately.

### Evidence-class leakage

- Validation-selected v27 winners are reused as baselines for later Qwen
  objective, quantization, and scheduling questions; the same exposed prompts
  cannot serve as an independent replicate and promotion set.
- Acceptance and target-content are approximate evidence, not strict
  exactness; state/logit deltas do not establish token identity; teacher-forced
  CE/accuracy does not establish acceptance; accepted tokens do not establish
  speed. V30's asymmetric timing repetitions further limit variance claims.
- Historical exact-guarded SmolLM results and approximate Qwen screens belong to
  different evaluator/evidence contracts and cannot be pooled into one serving
  conclusion.

## One highest-information non-GPU action

Produce a single immutable, read-only PLAN-001 evaluator/Arm-B metadata
manifest from preserved source/config/log/receipt files. It must either bind a
field directly or record `UNKNOWN`; it must not invoke the runtime, build,
replay, infer, evaluate, train, patch, download, install, access held-out data,
or use a GPU. This action resolves the shared contract before any objective,
scheduler, or consistency result can be interpreted.

## Required receipt/schema fields

The metadata receipt should include these exact groups:

1. **Identity and scope:** `receipt_id`, date, `plan_id`,
   `family_id=verifier-state-interface`, `mechanism=evaluator/Arm-B-contract`,
   `changed_variable=none`, `evidence_class=provenance/diagnostic-only`,
   `selection=none`, authorization boundary, and `heldout_touched=false`.
2. **Source evidence:** for every cited file, absolute/remote path, line or
   JSON-key reference, byte size, SHA-256, source tree/commit (or explicit
   `UNKNOWN`), and whether the evidence is historical or PLAN-001-bound.
3. **Runtime/target controls:** runtime source/commit, binary SHA, compiler/
   Python/PyTorch/CUDA/driver/backend/thread/device identities, target GGUF
   SHA, tokenizer SHA, prompt-manifest SHA, strict-greedy/seed/flags, and
   target-only oracle output/token hash.
4. **Per-record evaluator tuple:** prompt ID and rendered-prompt hash,
   deterministic replay ID, committed-prefix IDs, proposed/target IDs, first
   divergence, correction token and accept/commit decision, sampler/RNG config
   hash, logits summary/shape/dtype, state shape/dtype, mask and absolute-
   position schema/hash, cache before/after schema/state hashes, rollback result,
   evaluator/logger path and dependency hash, and output-token accounting.
5. **Arm-B layout:** block width and batch token count, positions and sequence
   IDs, serialized mask/hash, cache extents/full-state hashes, anchor/`n_extract`
   transition, and source/config/command tie proving this is the exact PLAN-001
   deployment-shaped schedule.
6. **Conflict, safety, and terminal state:** source and parsed memory-after
   values, direct resolution reference or `UNRESOLVED`, `unknown_fields[]`,
   `confound_flags[]`, `leakage_notes[]`, exact commands used for inspection,
   `execution_performed=false`, no-build/no-GPU/no-process actions, cleanup/
   terminal process-device state, and next safe action.

Only after this receipt is reviewed by planner, critic, literature, and CEO may
any downstream proposal be reconsidered. This document itself changes no
status and authorizes no run.

