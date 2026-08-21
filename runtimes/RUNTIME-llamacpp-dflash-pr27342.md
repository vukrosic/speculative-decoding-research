---
id: RUNTIME-llamacpp-dflash-pr27342
kind: runtime
status: experimental-external
---

# llama.cpp DFlash2 PR runtime

- Source: isolated llama.cpp DFlash2 pull-request implementation.
- Pinned lineage: `5ecbe1ac`.
- Target format: GGUF, including Qwen3.8-27B IQ1_S used in seeded studies.
- Drafter format: matching published and custom DFlash2 GGUFs.
- Exactness contract: not generally lossless for the recorded IQ1_S Qwen
  block-verification path; target-only remained stable but speculative outputs
  diverged.
- Known issue: target hidden/logit trajectories depend on singleton versus block
  execution shape under the quantized runtime. A unique exact root cause was not
  fully isolated in the seeded record.
- Build flags/compiler/CUDA versions: backfill from external v20-v22 receipts
  before reuse.
- Runtime source/build tree is external and not vendored into this repository.

