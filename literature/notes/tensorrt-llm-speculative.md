---
id: runtime-tensorrt-llm-speculative
status: reviewed
---

# TensorRT-LLM speculative decoding

**Primary implementation sources:** [NVIDIA guide](https://nvidia.github.io/TensorRT-LLM/examples/llm_speculative_decoding.html) and [feature reference](https://github.com/NVIDIA/TensorRT-LLM/blob/main/docs/source/features/speculative-decoding.md).

## Verified facts

TensorRT-LLM documents EAGLE-3, MTP, DFlash, and user-provided drafter
configurations. DFlash configuration includes maximum draft length, draft
checkpoint, mask token ID, and target layer IDs. Backend support and sampling
configuration are explicit parts of the API.

## Interpretation

The API makes the target/drafter interface concrete: a checkpoint that loads
with incorrect layer IDs or mask semantics is not a valid reproduction. Engine
build, CUDA graph, and kernel choices can dominate small proposal differences.

## Mapping

Pin TensorRT-LLM, TensorRT, CUDA, engine-build options, target/draft precision,
and all DFlash metadata. Report exact identity and end-to-end speed only after
the engine's target-only baseline is matched.
