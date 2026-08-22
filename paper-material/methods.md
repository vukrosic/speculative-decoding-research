# Methods

- Hardware: authorized NVIDIA RTX 3060 12 GiB remote instance only.
- Target: Qwen3.8-27B IQ1_S SHA `3895b6eaa91e...f887`.
- Current promising drafter: v21 Q4_K_M SHA `18a380efc9b7...0594`.
- Runtime: llama.cpp commit `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4`.
- Primary performance metric: matched end-to-end output tokens per second.
- Evidence is split into teacher-forced metrics, autoregressive acceptance,
  output/content agreement, token exactness, and serving speed.
- Negative and invalid attempts are additive and never overwritten.

