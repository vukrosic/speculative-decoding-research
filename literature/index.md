# Speculative-decoding literature

Reviewed 2026-08-21. This is a primary-source reading map for the research
thread. The notes are deliberately narrower than a survey: they capture the
mechanism, correctness contract, reported evaluation, and the questions that
must be answered by this repository's own receipts.

## Evidence labels

- **Verified fact** — directly stated in, or mechanically checkable from, the
  linked primary paper or implementation source.
- **Author claim** — an empirical or interpretive claim made by the source's
  authors. It is not a result of this repository.
- **Repository observation** — an existing local result linked from the
  project; included only to map literature to the lab.
- **Hypothesis** — a proposed explanation or testable next step, not evidence.

## Reading map

| Area | Notes |
|---|---|
| Exact speculative sampling | [Leviathan et al.](notes/leviathan-2023-speculative-decoding.md), [Chen et al.](notes/chen-2023-speculative-sampling.md) |
| Verification and serving | [SpecInfer](notes/specinfer-2023.md), [BlockVerify](notes/block-verification-2024.md), [theory](notes/yin-2024-theory.md), [Performance or Illusion](notes/performance-or-illusion-2026.md) |
| Learned drafters | [EAGLE](notes/eagle-2024.md), [EAGLE-2](notes/eagle-2-2024.md), [EAGLE-3](notes/eagle-3-2025.md), [Medusa](notes/medusa-2024.md) |
| Native multi-token prediction | [Gloeckle et al.](notes/gloeckle-2024-mtp.md), [DeepSeek-V3](notes/deepseek-v3-2024-mtp.md) |
| Parallel/block drafting | [DFlash](notes/dflash-2026.md) and the [DFlash2 status note](notes/dflash2-status.md) |
| Quantization-aware decoding | [QSpec](notes/qspec-2024.md), [QuantSpec](notes/quantspec-2025.md) |
| Runtime boundary | [vLLM](notes/vllm-speculators.md), [SGLang](notes/sglang-speculative.md), [TensorRT-LLM](notes/tensorrt-llm-speculative.md), [llama.cpp](notes/llama-cpp-speculative.md) |
| State localization | [LLM-42](notes/llm42-2026.md), [VeriCache](notes/vericache-2026.md), [CEO note](ceo-note-verifier-state-localization.md) |

See [comparison.md](comparison.md) for the method matrix, [synthesis.md](synthesis.md)
for the cross-paper conclusions, [knowledge-updates.md](knowledge-updates.md)
for durable review updates, and [sources.md](sources.md) for the complete URL
list and source-status notes.

## Reading order for this repository

1. Establish the rejection-sampling oracle with the two foundational papers.
2. Read tree verification and the theoretical paper before interpreting
   acceptance or speed.
3. Compare drafter interfaces (tokens, target features, heads, block masks).
4. Read quantization and runtime notes before designing a serving benchmark.

No statement in these notes upgrades a local experiment's evidence level. In
particular, teacher-forced loss, draft acceptance, exact target equivalence,
and end-to-end speed remain separate metrics.
