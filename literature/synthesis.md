# Synthesis

## 1. The durable algorithmic core

The foundational papers agree on a two-model pattern: a cheap proposer emits a
short continuation, and the target scores that continuation in parallel. Under
the rejection-sampling rule, a proposed token is accepted with a probability
derived from the target and proposal distributions; on rejection, sampling
continues from the residual target distribution. That is the source-level
reason a speculative algorithm can be *distribution preserving*. A greedy
"accept if argmax matches" path is a different, narrower contract.

**Verified fact:** exactness is a property of the complete sampler, verifier,
randomness, numerical path, and rollback—not of the drafter's loss or a raw
acceptance percentage.

**Hypothesis:** the most useful local oracle is a batch-one, token-by-token
replay against target-only decoding, followed by a separate throughput test.

## 2. What changed across drafter families

- **Separate token drafters** (the original papers) are conceptually simple but
  pay serial draft latency and a second model's memory footprint.
- **Head-based drafters** (Medusa and native MTP) reuse the target trunk, which
  reduces model duplication but makes head calibration and cache semantics
  architecture-specific.
- **Feature drafters** (EAGLE) move autoregression into a target-derived
  representation. EAGLE-2 makes the tree context-dependent; EAGLE-3 changes
  the training interface to fused multi-layer features and training-time test.
- **Block drafters** (DFlash) trade autoregressive drafting for a masked block
  prediction pass. They can reduce draft seriality, but they add target hidden
  state capture, block masks, and rollback boundaries.

The comparison is therefore not "which acceptance rate is highest?" It is a
joint design problem over proposal cost, target verification cost, accepted
prefix length, memory movement, and runtime scheduling.

## 3. Verification is the likely portability boundary

SpecInfer and the runtime documents make the same systems point from different
angles: tree or block verification is only fast when the runtime can represent
the candidate shape without excessive padding, synchronization, or KV-cache
copies. The llama.cpp documentation explicitly warns that backend sampling and
floating-point paths can select different tokens; SGLang documents algorithm-
specific restrictions; TensorRT-LLM requires target-layer and mask metadata.

**Verified fact:** a source paper's lossless theorem does not automatically
cover a quantized target, a different kernel, or a different sampler.

**Repository observation:** the current project already has a Qwen DFlash2
runtime case where approximate throughput and strict greedy identity diverge;
see [EXP-20260820-001](../experiments/cards/EXP-20260820-001-qwen-published-dflash-runtime.md).

**Hypothesis:** feature capture and verifier/rollback fidelity are higher-value
next variables than simply increasing drafter depth.

## 4. Quantization changes both economics and the oracle

QSpec's complementary execution is a useful design pattern: use a fast,
low-precision activation-and-weight path to propose, then a higher-fidelity
weight-only path to verify while reusing weights and KV state. QuantSpec instead
targets KV-cache memory and self-speculation. Both show that "quantized
speculative decoding" is not one knob. It can mean quantized target weights,
quantized draft weights, quantized activations, quantized KV, or a mixed pair.

For this lab, every quantization comparison should record: target format,
drafter format, activation precision, KV precision, sampler, backend, and exact
output agreement. A speedup from a changed numerical contract must be labelled
approximate.

## 5. MTP is a training/interface choice, not a free correctness guarantee

Gloeckle et al. introduce independent future-token heads as an auxiliary
training objective. DeepSeek-V3 uses sequential MTP modules and ships separate
MTP weights. In both cases, a runtime may use the heads as a speculative draft,
but the target still needs to verify proposed tokens if losslessness is the
goal. This distinction explains why native MTP can be fast yet still require
runtime-specific cache and mask handling.

## 6. Practical research consequences

1. Keep four receipts separate: teacher-forced fit, acceptance, exact replay,
   and matched serving speed.
2. Treat block length, tree shape, and draft steps as serving variables, not
   just model hyperparameters.
3. Compare methods at equal target, sampler, prompt set, output budget,
   hardware, runtime revision, and correctness contract.
4. Report accepted-prefix distributions, not only mean acceptance.
5. Preserve negative results: a better fit score with lower acceptance is a
   useful causal result, not a failed benchmark.

## 7. Highest-value open questions for this repository

- Can a single verifier/rollback harness reproduce token identity across
  standalone, EAGLE, MTP, and DFlash on the same target?
- How much of DFlash2's behavior is due to the block drafter versus quantized
  target numerics and runtime integration?
- Does target hidden-state extraction executed on singleton versus block-shaped
  inputs change the feature distribution enough to explain acceptance loss?
- When does a larger drafter stop paying for itself once draft latency, KV
  memory, and synchronization are included?
- Which runtime optimizations (tree kernels, overlap scheduling, graph capture,
  cache reuse) change the ranking of methods at batch 1 versus batch > 1?

## 8. New verifier/state-localization knowledge

**Verified fact:** BlockVerify shows that the verifier is an independent
optimization axis: even with a fixed drafter, changing the coupling can improve
expected accepted length while preserving the source-level distributional
contract.

**Verified fact:** the production-vLLM study reports that target verification
dominates execution and that acceptance length varies by output position,
request, and dataset. Therefore a single mean acceptance number is an
insufficient runtime diagnostic.

**Verified fact:** LLM-42 and VeriCache both make state replacement part of the
correctness path. LLM-42 replaces fast-path KV after fixed-shape replay;
VeriCache verifies compressed-KV drafts against a full-KV state.

**Knowledge update:** the lab's verifier proposal should treat a speculative
step as a transaction over tokens, KV, hidden-state buffers, positions/masks,
sampler state, allocator pages, and batch-shape metadata. Text equality without
committed-state equality can leave the next step on a different trajectory.

**Uncertainty:** “state equality” can mean byte identity, numerical tolerance,
deterministic replay, or output identity. These are distinct contracts and must
not be collapsed into one `exact` label.

See the [CEO-facing verifier/state-localization note](ceo-note-verifier-state-localization.md)
for the proposed receipt and decision gate.
