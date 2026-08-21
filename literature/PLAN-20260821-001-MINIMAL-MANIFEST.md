# PLAN-20260821-001 — minimal evaluator/layout manifest

This is the literature lane's minimum source-backed contract for the
singleton-versus-deployment-shaped target diagnostic. It is a documentation
aid, not an execution approval and not a replacement for the governance
manifest.

## Source facts versus hypotheses

**Source facts:** DFlash uses a masked block conditioned on target hidden state
([paper](https://arxiv.org/abs/2602.06036), [code](https://github.com/z-lab/dflash));
speculative sampling requires target/proposal scores, first rejection, and a
residual correction ([Leviathan et al.](https://arxiv.org/abs/2211.17192),
[Chen et al.](https://arxiv.org/abs/2302.01318)); verified replay may replace
fast-path state and roll back tentative state ([LLM-42](https://arxiv.org/abs/2601.17768));
and llama.cpp warns that backend, shape, quantization, and sampler paths can
change numerics ([guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md),
[implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp)).

**Hypothesis:** under the pinned IQ1_S target, singleton and deployment-shaped
target execution can produce different next-token state/logits. A state or
token mismatch is diagnostic evidence only; it is not by itself a general
exactness, losslessness, quality, or speed result.

## Minimal evaluator fields

One immutable evaluator/logger path plus commit or SHA-256 must emit, for each
prompt and first divergence (or explicit no-divergence record):

1. prompt ID, rendered-prompt hash, committed-prefix token IDs, and replay ID;
2. target top-1/token IDs and a compact logit summary at the fixed prefix;
3. correction token and accept/commit decision, or explicit `not_applicable`
   for target-only Arm A/B;
4. state shape/dtype, mask IDs/schema, and absolute position IDs;
5. target cache/state ranges and compact before/after digests for each commit
   or rollback transaction;
6. exact target-only oracle output/token hash and the declared strict-greedy
   comparison predicate; and
7. evaluator command/configuration and dependency/runtime identity, linked to
   the environment receipt rather than inferred from a paper.

The evaluator must keep token identity, state diagnostics, acceptance,
target-content, and timing as separate evidence rows. State or hidden/logit
digests are diagnostic and do not prove target equivalence.

## Latest reconciliation and bounded disposition (2026-08-21)

Authoritative receipts:

- [Evaluator/Arm-B reconciliation](../receipts/PLAN-20260821-001/evaluator-armb-contract-reconciliation-20260821.json), SHA-256 `1d0dc945cc25b7dc8ac990b44cacfbfd0fe08ec023df2a2a66ce5b9fe8193d58`.
- [Final no-new-evidence disposition](../receipts/PLAN-20260821-001/final-bounded-disposition-20260821.json), SHA-256 `5b8ae5a154dcd0b39653177dc6734b9e2cdb0e166f54c2902c68873f0549a586`.

The latest receipt reconciles the required matrix without closing the fields:

| Required group | Current status |
|---|---|
| Rendered-prompt/replay binding; committed/proposed/target IDs; first divergence; correction and commit decision | `UNKNOWN` per record |
| Sampler/RNG tuple; per-divergence logits; state shape/dtype; output-token accounting | `UNKNOWN` as a complete PLAN-001 contract |
| Serialized mask/position schema and hashes; cache schema/state hashes before and after rollback | `UNKNOWN` |
| Complete evaluator/logger path and dependency hash in one receipt | `UNKNOWN` |
| Arm-B width/batch schedule; absolute positions/sequence IDs; exact mask/cache state; anchor/n_extract transition; source/config tie | `UNKNOWN` as exact PLAN-001 deployment schedule |

Runtime lineage, binary hash, target hash, prompt-manifest hash, and historical
greedy settings are preserved identities, but they do not bind the missing
per-replay evaluator tuple or Arm-B schedule. The source description reports
memory-after `[171,171]`, while the parsed historical receipt reports
`[170,170]`; this discrepancy remains `UNRESOLVED` and must not be inferred
away.

## Minimal Arm-B layout fields

The layout manifest must bind these fields to the pinned llama.cpp source/config
hash and the exact target-only Arm-B schedule:

- block width and batch token count;
- absolute positions and sequence IDs;
- causal-mask schema plus serialized-mask digest (or explicit `unknown`);
- cache extents before/after the block and compact serialized-state digests
  (or explicit `unknown`);
- target-only anchor/draft fields marked `not_applicable`, unless a drafter
  path is actually in scope; and
- source/config/command hash showing that the fields describe the emitted
  deployment-shaped schedule, not a generic historical example.

## Admissible evidence

Evidence can close a field only when it is immutable and tied to this PLAN:

- a hashed runtime source/config or mechanically inspected command manifest;
- a read-only preflight receipt that records the field and its source/hash;
- an approved-run receipt containing the field, command, and cleanup state; or
- a paper/official implementation citation for semantic requirements only.

Paper claims and historical v22 examples can establish what to measure, but
cannot close a concrete PLAN-001 evaluator identity or prove that a block
shape is the pinned runtime's deployment schedule. Do not infer serialized
mask/cache contents from block width or token IDs. Keep missing fields as
`unknown` and stop before comparison.

## Boundary

The final bounded disposition adds no evidence. The smallest unblock remains a
freshly authorized read-only source/introspection/evaluator-contract task that
produces a field-by-field immutable manifest or explicit `UNKNOWN` values.
Until then, PLAN-001 remains preflight-blocked; this note authorizes no
inference, runtime execution, GPU work, or exactness claim.
