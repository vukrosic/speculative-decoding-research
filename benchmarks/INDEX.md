# Benchmark contracts

Every benchmark record must freeze prompts, prompt order, tokenizer, generation
settings, evaluator, target, drafter, runtime, warmup, repetitions, output token
accounting, correctness gate, and hardware.

## Required benchmark families

- Teacher-forced loss and token accuracy
- Draft acceptance overall and per position
- Accepted draft tokens per verification cycle
- Task/output quality by domain
- Exact-output or declared approximate-contract guard
- Target-only versus speculative end-to-end latency and throughput
- Peak VRAM and target/draft call accounting
- Repeated-run variation

Do not compare draft latency alone to target-only end-to-end generation.

