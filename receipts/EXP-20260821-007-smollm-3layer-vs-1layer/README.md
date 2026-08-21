# Terminal receipt: EXP-20260821-007

## Scope

- Remote project: `/workspace/smollm-eagle3-prototype`
- Target: frozen SmolLM2-135M-Instruct snapshot
- Comparison: 6,520,256-parameter one-layer drafter versus
  13,738,944-parameter three-layer drafter
- Evaluation: 90 fixed prompts, 30 each chat/code/document; two timing
  repetitions per model; block size 4 / 3 speculative proposals;
  `max_new_tokens=32`; seed `20260819`.
- Exact guard: enabled. Final sealed held-out set: not used.

## Measured result

| Metric | One layer | Three layers |
|---|---:|---:|
| Exact outputs | 180/180 | 180/180 |
| Accepted / proposed draft tokens | 642 / 10,692 | 744 / 10,396 |
| Draft-token acceptance | 6.0045% | 7.1566% |
| Mean accepted tokens/cycle | 0.1764 | 0.2104 |
| Per-position acceptance | 11.978 / 3.535 / 2.294% | 14.706 / 4.155 / 2.357% |
| End-to-end throughput | 14.4526 tok/s | 13.5385 tok/s |
| Total wall time | 307.903 s | 328.692 s |
| Peak VRAM | 323,866,624 B | 354,971,648 B |

Candidate changes: acceptance `+1.1521 percentage points` / `+19.19%`
relative; throughput `-0.9141 tok/s` / `-6.32%` relative. Exactness passed for
all timed calls.

## Training result

- Three epochs completed; epoch 0 selected by lowest validation CE.
- Training loss: `2.7846 -> 2.1133 -> 1.4397`.
- Validation loss: initial `3.4097`, then `3.4966`, `3.5011`, `3.7446`.
- Selected validation accuracy: `50.2667%`; parameters total/trainable:
  `13,738,944`.
- This is primarily an identity-initialized capacity result, not a successful
  training improvement.

## Immutable remote references

- Initialization:
  `/workspace/smollm-eagle3-prototype/checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-init`
- Training metrics:
  `/workspace/smollm-eagle3-prototype/checkpoints/dflash2-official-bridge-block3-capacity3layer-bounded-20260821-trained/onpolicy20k_metrics.json`
- Acceptance:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity3layer-bounded-20260821-fixed90-acceptance.json`
- Timing:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity3layer-bounded-20260821-timing.json`
- Timing log:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity3layer-bounded-20260821-timing.log`

The full remote artifacts remain external to this compact repository. Their
SHA-256 values, the preserved mismatched-control receipt, and cleanup state are
recorded in the experiment card.
