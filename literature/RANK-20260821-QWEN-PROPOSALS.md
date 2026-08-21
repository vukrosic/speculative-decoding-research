# Source-aware Qwen proposal ranking — 2026-08-21

This ranking is a literature handoff, not a queue change or execution
authorization. It ranks information gain under the current blockers, after the
PQ-002 implementation inventory found no admissible objective artifact.

## 1. PLAN-20260821-001 — verifier/state fidelity (highest information)

**Knowledge question:** does the pinned IQ1_S target produce a different
committed state/logit trajectory under singleton versus deployment-shaped block
execution, and does rollback replace the state that will be used next?

**Primary handoff:** DFlash ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)) establishes block/hidden-state
semantics; LLM-42 ([2601.17768](https://arxiv.org/abs/2601.17768)) establishes
verified state replacement; llama.cpp's [guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md)
and [implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp)
establish runtime/shape/greedy caveats; BlockVerify ([2403.10444](https://arxiv.org/abs/2403.10444))
shows verifier design is independent of drafter capacity.

**Current boundary:** highest information because it can explain strict
divergence before any training or scheduling claim. It remains blocked on the
complete evaluator tuple and exact Arm-B layout manifest; do not infer from
historical v22 shapes.

## 2. PQ-20260821-002 — acceptance-calibrated objective

**Knowledge question:** can an objective that explicitly weights cumulative
prefix survival improve autoregressive acceptance over v27 under fixed feature
and runtime identities?

**Primary handoff:** Chen ([2302.01318](https://arxiv.org/abs/2302.01318)) and
Yin ([2411.00841](https://arxiv.org/abs/2411.00841)) separate proposal fit from
target/proposal acceptance; DFlash/EAGLE ([2602.06036](https://arxiv.org/abs/2602.06036),
[2401.15077](https://arxiv.org/abs/2401.15077)) require frozen target-feature
interfaces.

**Current boundary:** provenance and objective math are specified, but the
implementation inventory is BLOCKED. A named immutable wrapper/task, unit gate,
and CEO amendment are needed; the candidate remains secondary because a better
drafter may not repair a verifier/state mismatch.

## 3. PQ-20260821-005 — paired singleton/block state consistency

**Knowledge question:** can training against both execution shapes improve
feature alignment after alignment-only v31 failed to improve acceptance?

**Primary handoff:** DFlash and EAGLE feature dependence ([2602.06036](https://arxiv.org/abs/2602.06036),
[2401.15077](https://arxiv.org/abs/2401.15077)) motivate the axis; LLM-42
([2601.17768](https://arxiv.org/abs/2601.17768)) motivates committed-state
checks.

**Current boundary:** medium-high information but expensive and confounded
until PLAN-001 establishes the state contract. The v31 negative result shows
alignment alone was insufficient; it does not prove a consistency objective
will work. Remains deferred queue-only.

## 4. PQ-20260821-004 — confidence-gated proposal length

**Knowledge question:** can a fixed, confidence-defined policy avoid low-yield
proposals without changing DFlash2 verifier semantics?

**Primary handoff:** llama.cpp draft-length controls ([guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md))
and EAGLE-2 confidence/tree selection ([2406.16858](https://arxiv.org/abs/2406.16858))
provide precedents; QSpec ([2410.11305](https://arxiv.org/abs/2410.11305)) warns
quantization changes confidence/logits.

**Current boundary:** lower readiness than PQ-002: the pinned DFlash2 runtime
has no confidence selector; `p_min`, DSpark confidence, n-gram statistics, and
adaptive-p are other paths. A new selector is a runtime-change proposal, not a
configuration-only follow-up.

## 5. Completed v30 quantization screen — no new promotion question

**Knowledge question already answered locally:** does F16/Q4_K_M/Q8_0 export
format materially improve the approximate n=4 screen? The rerun was near-tied,
all drafter arms were slower than target-only, and exactness failed
diagnostically. QSpec ([2410.11305](https://arxiv.org/abs/2410.11305)) provides
the quantization framing, but no further quantization promotion follows from
this result.

## Rank conclusion

The next highest-information knowledge question is PLAN-001's verifier/state
contract, subject to its source-backed manifest blocker. PQ-002 is the strongest
downstream training question once its implementation artifact is approved; PQ-
005 is later and expensive; PQ-004 requires a new runtime policy; v30 remains
an approximate completed baseline. Existing statuses and queue ownership are
unchanged.
