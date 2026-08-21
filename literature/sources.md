# Sources

Reviewed 2026-08-21. Paper links are primary publication pages or author
repositories. Runtime links are the projects' own documentation/code because
the implementation contract is part of the research question.

## Primary papers

1. Leviathan, Kalman, Matias. [Fast Inference from Transformers via Speculative Decoding](https://arxiv.org/abs/2211.17192) (arXiv 2211.17192; ICML 2023).
2. Chen et al. [Accelerating Large Language Model Decoding with Speculative Sampling](https://arxiv.org/abs/2302.01318) (arXiv 2302.01318).
3. Miao et al. [SpecInfer: Accelerating Generative Large Language Model Serving with Tree-based Speculative Inference and Verification](https://arxiv.org/abs/2305.09781) (arXiv 2305.09781).
4. Cai et al. [Medusa: Simple LLM Inference Acceleration Framework with Multiple Decoding Heads](https://arxiv.org/abs/2401.10774) (arXiv 2401.10774; ICML 2024).
5. Li et al. [EAGLE: Speculative Sampling Requires Rethinking Feature Uncertainty](https://arxiv.org/abs/2401.15077) (arXiv 2401.15077; ICML 2024).
6. Li et al. [EAGLE-2: Faster Inference of Language Models with Dynamic Draft Trees](https://arxiv.org/abs/2406.16858) (arXiv 2406.16858; EMNLP 2024).
7. Gloeckle et al. [Better & Faster Large Language Models via Multi-token Prediction](https://arxiv.org/abs/2404.19737) (arXiv 2404.19737).
8. Yin, Chen, Huang, Wang. [A Theoretical Perspective for Speculative Decoding Algorithm](https://arxiv.org/abs/2411.00841) (arXiv 2411.00841; NeurIPS 2024).
9. Zhao et al. [QSpec: Speculative Decoding with Complementary Quantization Schemes](https://arxiv.org/abs/2410.11305) (arXiv 2410.11305; EMNLP 2025).
10. DeepSeek-AI et al. [DeepSeek-V3 Technical Report](https://arxiv.org/abs/2412.19437) (arXiv 2412.19437; includes MTP modules).
11. Li et al. [EAGLE-3: Scaling up Inference Acceleration of Large Language Models via Training-Time Test](https://arxiv.org/abs/2503.01840) (arXiv 2503.01840; NeurIPS 2025).
12. Tiwari et al. [QuantSpec: Self-Speculative Decoding with Hierarchical Quantized KV Cache](https://arxiv.org/abs/2502.10424) (arXiv 2502.10424).
13. Chen, Liang, Liu. [DFlash: Block Diffusion for Flash Speculative Decoding](https://arxiv.org/abs/2602.06036) (arXiv 2602.06036; 2026).
14. Sun et al. [Block Verification Accelerates Speculative Decoding](https://arxiv.org/abs/2403.10444) (arXiv 2403.10444).
15. Liu et al. [Speculative Decoding: Performance or Illusion?](https://arxiv.org/abs/2601.11580) (arXiv 2601.11580).
16. Gond et al. [LLM-42: Enabling Determinism in LLM Inference with Verified Speculation](https://arxiv.org/abs/2601.17768) (arXiv 2601.17768).
17. Yao et al. [VeriCache: Turning Lossy KV Cache into Lossless LLM Inference](https://arxiv.org/abs/2605.17613) (arXiv 2605.17613).

## Runtime and implementation sources

18. Kwon et al. [Efficient Memory Management for Large Language Model Serving with PagedAttention](https://arxiv.org/abs/2309.06180) (vLLM systems paper).
19. [vLLM Speculators documentation](https://docs.vllm.ai/projects/speculators/en/stable/) and [vLLM speculative decoding documentation](https://docs.vllm.ai/en/latest/features/spec_decode/).
20. [SGLang speculative decoding documentation](https://github.com/sgl-project/sglang/blob/main/docs_new/docs/advanced_features/speculative_decoding.mdx).
21. [TensorRT-LLM speculative decoding documentation](https://nvidia.github.io/TensorRT-LLM/examples/llm_speculative_decoding.html) and [feature reference](https://github.com/NVIDIA/TensorRT-LLM/blob/main/docs/source/features/speculative-decoding.md).
22. [llama.cpp speculative decoding documentation](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md) and [implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp).
23. [SafeAILab EAGLE official implementation](https://github.com/SafeAILab/EAGLE).
24. [z-lab DFlash official implementation](https://github.com/z-lab/dflash).
25. [Microsoft LLM-42 official implementation](https://github.com/microsoft/llm-42).

## Source-status notes

- **DFlash2:** no separate primary paper with that title was found in the
  reviewed source set. Treat “DFlash2” as a checkpoint/implementation lineage
  or model release label until an authoritative paper or release note defines
  a distinct algorithm. The DFlash paper and official implementation are the
  primary sources for the block-diffusion mechanism.
- Claims such as “lossless”, “exact”, or a multiplier like “6.5x” are retained
  as **author claims** in the notes. They do not override this repository's
  runtime-specific exactness receipts.
- Third-party blogs, forums, and benchmark posts were used only to discover
  candidate URLs, not as evidence in the notes.
