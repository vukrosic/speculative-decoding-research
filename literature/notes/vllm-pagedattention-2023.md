---
id: paper-vllm-pagedattention-2023
status: reviewed
---

# vLLM / PagedAttention as the serving substrate

**Citation:** Woosuk Kwon et al., [Efficient Memory Management for Large Language Model Serving with PagedAttention](https://arxiv.org/abs/2309.06180).

## Relevance

**Verified fact:** PagedAttention manages KV cache in blocks and uses a serving
scheduler to improve memory utilization and throughput. This is not a
speculative-decoding algorithm, but it controls the memory and batching regime
in which speculative verification runs.

**Author claim:** the paper reports 2–4x throughput improvements over prior
serving systems at similar latency in its evaluated workloads.

## Mapping

Speculative comparisons must pin cache block size, scheduler, batch/concurrency,
and context distribution. A method's speedup can change when the incumbent
runtime changes its KV allocation or batching policy.
