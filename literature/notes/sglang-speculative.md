---
id: runtime-sglang-speculative
status: reviewed
---

# SGLang speculative decoding

**Primary implementation source:** [official speculative-decoding documentation](https://github.com/sgl-project/sglang/blob/main/docs_new/docs/advanced_features/speculative_decoding.mdx).

## Verified facts

The documented runtime supports EAGLE-2, EAGLE-3, DFLASH, MTP/NEXTN,
standalone draft models, n-gram speculation, and a Speculative Decoding V2
overlap scheduler. The documentation lists algorithm-specific flags and
restrictions; for example, DFLASH and some methods constrain parallelism or
disable scheduler features.

## Interpretation

SGLang's overlap and attention backends can materially change the ranking of
methods. The documentation's example throughput table is a runtime claim for a
particular model/hardware/workload, not a universal method comparison.

## Mapping

Record scheduler mode, attention backend, DP/PP settings, draft steps/tree
parameters, and whether mixed prefill is enabled. Use the same server revision
for target-only and speculative runs.
