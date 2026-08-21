---
id: MODEL-qwen38-27b-iq1s
kind: target
status: available-external
---

# Qwen3.8-27B IQ1_S target

- Canonical artifact: `Qwen3.8-27B-UD-IQ1_S.gguf`.
- Source: Unsloth GGUF distribution.
- Quantization: IQ1_S.
- SHA-256:
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Runtime used: pinned llama.cpp and isolated DFlash2 PR builds.
- Context tested in seeded DFlash comparison: 4K.
- Known behavior: strict greedy target outputs were stable across target-only
  runtime checks, while block-shaped speculative target execution was
  shape-dependent under the quantized path.
- Large GGUF is external and intentionally excluded from Git.
- Related experiments:
  [EXP-20260820-001](../experiments/cards/EXP-20260820-001-qwen-published-dflash-runtime.md)
  and Qwen v27-v31 cards.
- Last verified in recorded evidence: 2026-08-21.

