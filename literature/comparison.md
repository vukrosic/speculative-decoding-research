# Comparison tables

## Method-level comparison

| Method | Proposal interface | Verification shape | Exactness contract in source | Training / extra state | Main reported result (author claim) | Main risk to test |
|---|---|---|---|---|---|---|
| Leviathan et al. (2023) | Separate small model, autoregressive tokens | Batched target logits over a draft prefix | Distribution-preserving rejection sampling | No target retraining; separate drafter | 2–3x on T5-XXL | Draft cost and target/draft numerical mismatch |
| Chen et al. (2023) | Separate autoregressive approximation model | Parallel scoring of proposed sequence | Speculative sampling preserves target distribution | No target architecture change | 2–2.5x on Chinchilla 70B | Acceptance falls with distribution gap and long drafts |
| SpecInfer (2023) | One or more draft sequences arranged as a tree | Tree attention / parallel verification | Reuses exact sampling rule | Runtime and kernel work | Up to 2.6x in the paper's serving setups | Tree padding, KV management, batch shape |
| BlockVerify (2024) | Any single draft block | Joint block-level coupling | Paper proves target-distribution preservation under its formulation | Verifier-only change | 5–8% over token-level verification in reported tasks | Expected accepted length is not total runtime |
| Medusa-1/2 (2024) | Extra heads on the target hidden state | Tree attention over head proposals | Medusa-1 is intended lossless under its verifier | Head fine-tuning; no separate full LM | 2.2x (Medusa-1), 2.3–3.6x (Medusa-2) | Head calibration, backbone changes, tree overhead |
| EAGLE (2024) | Autoregressive feature-level drafter plus token shift | Tree or sequence verification | Claims distribution maintenance via target verifier | Train a lightweight feature drafter | 2.7–3.5x on LLaMA2-Chat 70B | Feature alignment and target-layer dependence |
| EAGLE-2 (2024) | EAGLE drafter with context-aware dynamic tree | Confidence-guided tree verification | Claims lossless output distribution | Dynamic tree search at runtime | 3.05–4.26x; 20–40% over EAGLE-1 | Confidence calibration and context-dependent shapes |
| EAGLE-3 (2025) | Token drafter fed fused target features | EAGLE-style tree verification | Claims same target distribution | Training-time test; multi-layer fusion | Up to 6.5x; 1.38x throughput at batch 64 in SGLang | Extra hidden-state extraction, training/inference mismatch |
| Gloeckle et al. MTP (2024) | Shared trunk with independent future-token heads | Must be wrapped in a verifier to be speculative | Training objective, not by itself a correctness proof | Heads trained with the model | Up to 3x inference in their setting | Head predictions are not automatically target-equivalent |
| DeepSeek-V3 MTP (2024) | Sequential MTP modules attached to target | Used as a native draft path by runtimes | Requires target verification for lossless use | 14B MTP module in released checkpoint | Author reports training/data-efficiency gains | Version-specific cache and module semantics |
| DFlash (2026) | Target hidden-state-conditioned masked block drafter | Left-to-right target verification of a block | Paper describes lossless speculative decoding | Train lightweight block diffusion drafter | >6x; up to 2.5x over EAGLE-3 | Block-shape, hidden-state capture, rollback |
| QSpec (2024/2025) | Same quantized weights, low-precision draft execution | High-precision weight-only verification | Greedy top-1 matching in implementation | No extra drafter weights | Up to 1.64x vs high-precision quantization | Quantization changes logits and acceptance |
| QuantSpec (2025) | Self-speculation with quantized KV cache | Target-side verifier with hierarchical cache | Source reports quality-preserving acceleration | Quantized KV cache and early-exit/self-draft path | Edge/long-context speed and memory claims | Cache error, early-exit quality, workload dependence |
| VeriCache (2026) | Compressed KV state | Full-KV verification | Claims same output as full-KV decoding | Compression plus full-KV staging | Up to 4x in reported long-context settings | Full-cache availability and swap/restore cost |

## Runtime comparison (implementation sources)

| Runtime | Documented methods | Important implementation contract |
|---|---|---|
| vLLM + Speculators | EAGLE-family and speculator models | Speculator metadata selects the draft; benchmark output equality and throughput separately |
| SGLang | EAGLE-2/3, DFLASH, MTP/NEXTN, standalone, n-gram, Spec V2 | Some algorithms disable overlap/DP features; measure scheduler and backend effects |
| TensorRT-LLM | EAGLE-3, MTP, DFlash, user-provided drafter | Configuration couples target, draft, layer IDs, mask IDs, and backend support |
| llama.cpp | draft model, EAGLE-3, DFlash, MTP/NEXTN, n-gram | Greedy is the documented route for repeatable output matching; backend and quantization can change numerics |
| LLM-42 (SGLang-based) | Fast dynamic-batch decode plus fixed-shape replay | Determinism/repeatability via verify–rollback; state replacement and mismatch predicate are runtime-specific; not stochastic target-distribution equivalence |

## Metrics that must not be collapsed

| Metric | What it answers | What it cannot prove |
|---|---|---|
| Teacher-forced loss / accuracy | Did the drafter fit labels under teacher forcing? | Better autoregressive acceptance or speed |
| Acceptance rate / accepted prefix length | How many proposed tokens survive the verifier? | End-to-end speed or task quality |
| Exact target equivalence | Did the chosen verifier reproduce the target under a declared decoding contract? | Generalization to another runtime, quantization, or sampler |
| Task quality | Did outputs preserve the task metric? | Exact equality or throughput |
| End-to-end latency / throughput | Did the whole serving path improve? | Exactness unless compared with an oracle |
