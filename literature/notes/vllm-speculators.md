---
id: runtime-vllm-speculators
status: reviewed
---

# vLLM and Speculators

**Primary implementation sources:** [Speculators documentation](https://docs.vllm.ai/projects/speculators/en/stable/), [vLLM speculative decoding documentation](https://docs.vllm.ai/en/latest/features/spec_decode/).

## Verified facts

vLLM's Speculators project defines a format and training/deployment path for
learned speculators, including EAGLE-family models. The server can read
speculator metadata and load target plus speculator together. vLLM also has
native speculative decoding methods whose support varies by release.

## Interpretation

The runtime is a serving system, not a correctness theorem. Its documented
“lossless” framing assumes the verifier and numerical path implement the target
contract. A successful load proves compatibility, not speed or exactness.

## Mapping

Pin the vLLM and Speculators revisions, model config, target/draft dtypes,
batch/concurrency, sampler, and acceptance/equality instrumentation. Compare
against target-only serving under the same scheduler.
