---
id: runtime-llama-cpp-speculative
status: reviewed
---

# llama.cpp speculative decoding

**Primary implementation sources:** [speculative decoding guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md), [common implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp), and [benchmark guide](https://github.com/ggml-org/llama.cpp/blob/master/tools/server/bench/speed-bench/README.md).

## Verified facts

The guide documents standalone draft models, EAGLE-3, DFlash, MTP, n-gram
variants, draft-length controls, backend sampling, and acceptance statistics.
It explicitly recommends greedy sampling when exact output matching is
required because CPU/backend floating-point paths can differ.

## Interpretation

llama.cpp exposes the full cost surface: draft model placement, GPU layers,
backend sampling, quantization, block length, and accumulation/rollback. Its
benchmark tool compares target-only and speculative server runs; an acceptance
counter alone is not a speed benchmark.

## Mapping

Use the pinned runtime revision and record model file hashes, quantization,
device split, sampler, seed, context, and prompt set. Keep approximate
throughput and strict identity as separate outcomes.
