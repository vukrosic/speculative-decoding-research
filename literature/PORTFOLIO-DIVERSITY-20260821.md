# Portfolio literature diversity map — 2026-08-21

This is a knowledge map, not a queue decision. It preserves current blocked
and proposed statuses and identifies one unanswered literature question per
axis.

| Knowledge axis | Existing portfolio evidence | Source/claim boundary | Missing literature question |
|---|---|---|---|
| Verifier/state fidelity | PLAN-20260821-001 handoff, evaluator/Arm-B inventories, Qwen target-only schedule localizer | BlockVerify ([2403.10444](https://arxiv.org/abs/2403.10444)) and LLM-42 ([2601.17768](https://arxiv.org/abs/2601.17768)) make verification/state replacement an independent axis; local Arm-B/evaluator fields remain blocked. | What minimum committed-state equality contract (byte, tolerance, replay, or token identity) is portable across singleton and block-shaped quantized execution? |
| Runtime overhead | v30 target-only versus F16/Q4/Q8 timings; PQ-004 confidence-length proposal and runtime inventory | SpecInfer ([2305.09781](https://arxiv.org/abs/2305.09781)), llama.cpp [guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md), and Performance or Illusion note distinguish accepted length from draft/verify/scheduler cost; no adaptive DFlash2 selector exists locally. | Which phase-cost decomposition best predicts break-even across draft length, target verification, correction, cache movement, and scheduler overhead? |
| Training objective | PQ-002 prefix-survival objective manifest, v27 curve, v29 early-position negative result | Chen ([2302.01318](https://arxiv.org/abs/2302.01318)) and Yin ([2411.00841](https://arxiv.org/abs/2411.00841)) tie acceptance to target/proposal distributions, not CE; `1/t` and `λ=1` remain hypotheses. | Which teacher-forced surrogate, if any, predicts contiguous autoregressive acceptance under the deployment-shaped target state? |
| Quantization | EXP-20260821-004/v30 F16-Q4_K_M-Q8_0 rerun: near-tied acceptance/content and all drafter arms slower than target-only | QSpec ([2410.11305](https://arxiv.org/abs/2410.11305)) and QuantSpec ([2502.10424](https://arxiv.org/abs/2502.10424)) separate weight/activation/KV precision effects; local result is approximate and not exactness evidence. | Under what mixed target/drafter/KV precision conditions can quantization preserve a declared target-equivalence contract rather than only approximate content? |
| Drafter capacity | SmolLM EXP-20260821-006/007/008 depth comparisons; Qwen v27/v28 lineage | EAGLE ([2401.15077](https://arxiv.org/abs/2401.15077)) and EAGLE-3 ([2503.01840](https://arxiv.org/abs/2503.01840)) report capacity/feature speed claims conditional on target/runtime; local acceptance and timing remain separate. | Is there a transferable capacity-per-draft-cost law for accepted prefixes once target verification and cache overhead are included? |
| State consistency | Qwen EXP-20260821-005 block-17 alignment; PQ-005 paired singleton/block consistency proposal | DFlash ([2602.06036](https://arxiv.org/abs/2602.06036)) and EAGLE feature work require target-layer/shape fidelity; alignment gains do not establish committed-state equality. | Can training against singleton and deployment-shaped target states improve feature alignment without shifting the verifier/cache contract or merely fitting a runtime artifact? |
| Exactness and promotion | Qwen published DFlash runtime failed strict identity; SmolLM guarded exact outputs; PLAN-001 and all literature receipts separate exactness from acceptance/speed | Leviathan ([2211.17192](https://arxiv.org/abs/2211.17192)) and Chen ([2302.01318](https://arxiv.org/abs/2302.01318)) define distributional rejection contracts; llama.cpp documents greedy matching caveats. | What receipt-complete evidence threshold should promote a local result from approximate/diagnostic to contract-specific exact or lossless, without overgeneralizing across runtimes? |

## Portfolio reading

The axes are deliberately non-substitutable: better fit does not prove
acceptance, acceptance does not prove speed, and content overlap does not prove
quality or exactness. The current highest-information dependency remains
verifier/state localization; PQ-002 is a bounded proposed training change and
PQ-004 is blocked on a missing DFlash2 policy artifact. No axis authorizes a new
run or changes queue ownership.
