---
id: PAPER-20260821-verifier-fidelity-dflash-qwen
status: reviewed-handoff
tags: [DFlash, DFlash2, verifier, exactness, KV-cache, llama.cpp]
---

# Verifier-fidelity handoff: DFlash/DFlash2 on Qwen

This is the canonical literature note for `PLAN-20260821-001` and
`LIT-20260821-001`. It records source-backed constraints, not repository
measurements. “Exact” below means only the explicitly declared contract has
passed; source authors' use of “lossless” remains an author claim.

## Source boundary

- **DFlash:** Chen, Liang, Liu, [DFlash: Block Diffusion for Flash Speculative Decoding](https://arxiv.org/abs/2602.06036), plus the [official implementation](https://github.com/z-lab/dflash).
- **DFlash2:** no distinct primary paper was found in the reviewed source set. Treat the name as an implementation/checkpoint lineage until an authoritative release defines a separate algorithm. Cite DFlash for the mechanism and the concrete runtime/checkpoint source for behavior.
- **Rejection/correction oracle:** [Leviathan et al.](https://arxiv.org/abs/2211.17192) and [Chen et al.](https://arxiv.org/abs/2302.01318).
- **Verifier/state references:** [BlockVerify](https://arxiv.org/abs/2403.10444), [LLM-42](https://arxiv.org/abs/2601.17768), and [VeriCache](https://arxiv.org/abs/2605.17613).
- **Pinned runtime:** [RUNTIME-llamacpp-dflash-pr27342](../runtimes/RUNTIME-llamacpp-dflash-pr27342.md), isolated llama.cpp DFlash2 PR lineage `5ecbe1ac`.

## Author claims retained as claims

**Author claim (DFlash):** the paper reports more than 6x lossless
acceleration and up to 2.5x the EAGLE-3 speedup in its evaluated setups.
**Author claim (foundational sampling):** the rejection/residual rule
preserves the target distribution under its stated assumptions. **Author claim
(adjacent verifier/state work):** BlockVerify improves expected accepted
length, LLM-42 provides deterministic verified replay, and VeriCache can
restore full-KV output behavior. None of these claims is a local Qwen receipt.

## Source/claim-to-test matrix

| Topic | Source claim / observed evidence | Hypothesis to test | Recommendation / falsifier |
|---|---|---|---|
| DFlash/DFlash2 status | **Observed:** DFlash is the reviewed paper and official code path. No separate DFlash2 paper is present; the local runtime note calls DFlash2 a published/custom implementation lineage. **Author claim:** DFlash reports >6x lossless acceleration in its evaluated setup. | Divergence attributed to “DFlash2” may be checkpoint, interface, quantization, or runtime fidelity rather than a new correctness rule. | Freeze checkpoint/revision, block length, mask/anchor semantics, target-layer IDs, and runtime commit before comparing. A distinct algorithm claim requires an authoritative source. |
| Rejection and correction | **Observed/verified:** foundational speculative sampling drafts a block, scores it with the target, accepts a prefix, then samples a residual correction at the first rejection. **Author claim:** this rule preserves the target distribution. Greedy argmax matching is a narrower contract. | A greedy mismatch can arise from using the wrong correction or from numerical differences, even when the draft is adequate. | Log candidate tokens, per-position target/proposal probabilities or logits, accepted-prefix length, first rejection, correction token/residual, and sampler/RNG state. Test stochastic distribution preservation separately from greedy identity. |
| KV/cache commit and rollback | LLM-42 replaces fast-path KV with fixed-shape verified KV; VeriCache treats compressed and full KV as separate draft/verify states. The local runtime note records speculative output divergence despite stable target-only output. | Text may match for one step while tentative target/drafter KV, hidden buffers, positions, allocator pages, or RNG state diverge and alter the next step. | Model each speculative step as a transaction. Receipt must show committed prefix, target/drafter KV ranges, hidden-state slots, mask/positions, allocator pages, sampler state, rollback ranges, and post-commit state. Negative control: force target-only continuation after every rejection. |
| Shape and hidden-state interface | DFlash conditions masked block prediction on target hidden states; runtime guidance warns that backend paths and shapes affect numerics. The pinned Qwen runtime records singleton-vs-block trajectory dependence as an unresolved issue. | Singleton and deployment-shaped block execution produce different hidden/logit/KV states, causing apparent verifier failure independent of drafter quality. | Hold prompt, positions, target weights, backend, and quantization fixed; compare singleton versus block target states at each layer used by the drafter. Hashes are diagnostic only; fail if the declared state/output oracle diverges. |
| Quantization assumptions | QSpec separates low-precision draft execution from higher-precision verification; QuantSpec changes KV precision/cache state. The pinned runtime uses GGUF Qwen3.8-27B IQ1_S and matching published/custom DFlash2 GGUFs. | Weight, activation, or KV quantization changes ties, logits, cache restoration, and accepted prefixes; “quality preserved” does not establish target identity. | Record target/drafter format, activation precision, KV precision, sampler, backend, and device split. Run a same-format target-only oracle and a higher-fidelity comparison; label any speed/quality result approximate unless the exactness oracle passes. |
| Exactness contract | Rejection sampling is distribution-preserving in the source theorem; llama.cpp documentation recommends greedy sampling for repeatable output matching and warns backend floating-point paths can differ. | “Exact” may mean distributional, deterministic replay, numerical state tolerance, or token identity; these are not interchangeable. | Declare one contract per receipt: stochastic distribution, deterministic greedy token identity, or committed-state equality (byte/tolerance). Never use exact/lossless/equivalent without the matching passed receipt. |
| Pinned llama.cpp lineage | The repository runtime metadata pins isolated PR lineage `5ecbe1ac`; it notes missing build/compiler/CUDA backfill and no vendored source tree. | Re-running on another llama.cpp revision, build, backend, or device split can change acceptance and trajectories. | Treat `5ecbe1ac` plus complete build metadata as a frozen control. Block promotion if commit/build/quantization/hash metadata are incomplete; do not infer upstream-master behavior. |
| Unknowns and reproducibility gaps | Sources do not establish this repository's Qwen checkpoint hashes, exact PR patch contents, build flags, compiler/CUDA versions, or a passed committed-state receipt. | The unresolved greedy divergence may be localized to feature extraction shape, verifier correction, rollback, or quantized numerics; current evidence cannot rank them. | Planner should choose one causal change and one negative control, seal held-out prompts, and collect phase-separated acceptance, exactness, and serving receipts. No serving-speed or losslessness claim before the oracle and matched baseline pass. |

## Handoff state

**Observed:** canonical source notes, pinned runtime metadata, and the matrix
above now cover all requested verifier-fidelity dimensions.

**Hypothesis:** a deployment-shaped state/rollback mismatch is a higher-value
first localization target than increasing drafter capacity.

**Recommendation:** planner links one falsifiable verifier/state probe to this
note, then obtains the required approval before any execution. This note does
not authorize code, GPU, SSH, download, evaluation, or held-out access.

## Canonical links

- [Literature handoff note](../literature/HANDOFF-20260821-LIT-001.md)
- [DFlash2 status note](../literature/notes/dflash2-status.md)
- [llama.cpp runtime metadata](../runtimes/RUNTIME-llamacpp-dflash-pr27342.md)
- [PLAN-20260821-001](../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md)
