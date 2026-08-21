# Failure index

Failures are retained as first-class research evidence.

| Failure | Experiment | Observed invariant | What it rules out / next question |
|---|---|---|---|
| Capacity did not buy acceptance | [EXP-20260819-002](../experiments/cards/EXP-20260819-002-smollm-capacity35m.md) | 35.40M improved loss/accuracy but acceptance fell | Capacity alone is not the demonstrated bottleneck |
| Qwen block verification changed greedy outputs | [EXP-20260820-001](../experiments/cards/EXP-20260820-001-qwen-published-dflash-runtime.md) | 4/6 frozen prompts diverged | Approximate speed cannot be called lossless |
| Smaller Qwen drafter was slower overall | [EXP-20260821-002](../experiments/cards/EXP-20260821-002-qwen-v28-small-drafter.md) | Lower parameters, lower acceptance and tok/s | Shared/target/runtime costs dominate saved draft compute |
| Early-position-only objective regressed | [EXP-20260821-003](../experiments/cards/EXP-20260821-003-qwen-v29-early4.md) | n=4 acceptance fell to 4.819% | Training only positions 1–4 is insufficient |
| Block-17 aligned features changed target states but not acceptance | [EXP-20260821-005](../experiments/cards/EXP-20260821-005-qwen-v31-block17-alignment.md) | Target states were shape-dependent; aligned training still regressed | Alignment is necessary but not sufficient |
| Extra training was non-monotonic | [EXP-20260821-001](../experiments/cards/EXP-20260821-001-qwen-v27-curve.md) | Intermediate steps beat nearby/final points for n=4/n=8 | Select by acceptance, not final epoch or CE alone |
| Five-layer capacity cost more than its acceptance gain | [EXP-20260821-006](../experiments/cards/EXP-20260821-006-smollm-1layer-vs-5layer.md) | Acceptance rose 19.19% relative, while end-to-end throughput fell 13.51% | Added depth is not a serving win under this guarded runtime; test intermediate depth or an acceptance-selected objective |
| Three-layer capacity still misses the throughput incumbent | [EXP-20260821-007](../experiments/cards/EXP-20260821-007-smollm-3layer-vs-1layer.md) | Acceptance rose 19.19% relative, but throughput fell 6.32%; validation selected identity epoch 0 | Stop blind depth scaling; prioritize contiguous-prefix objective or verifier/runtime fidelity |
| Wrong parent used in first 3-layer smoke control | [EXP-20260821-007](../experiments/cards/EXP-20260821-007-smollm-3layer-vs-1layer.md) | One-layer versus three-layer init showed max logit delta 10.867; two-layer-parent control was exactly identical | Function-preservation tests must compare an expansion to its actual parent |
