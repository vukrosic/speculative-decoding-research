# Qwen speculative-decoding paper material

Question: when and why does DFlash-style drafting improve Qwen inference on an
RTX 3060, and which state/evaluator changes recover target-only greedy behavior
without erasing the speed benefit?

Current status: active. The strongest narrow lead is the v21 Q4 n=1 cache-off
screen (`18.1639` versus `16.0895` tok/s) with one deterministic output mismatch
among six unique prompts. EXP-020 is tracing that divergence.

- [Claims](claims.md)
- [Methods](methods.md)
- [Artifacts](artifacts.md)
- [Decisions](decisions.md)
- [Experiment events](experiments/)

