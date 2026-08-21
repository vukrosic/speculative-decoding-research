# Terminal receipt: EXP-20260821-008

## Scope

- Remote project: `/workspace/smollm-eagle3-prototype`
- Target: frozen SmolLM2-135M-Instruct snapshot
- Comparison: 6,520,256-parameter one-layer draft versus existing
  10,129,600-parameter two-layer draft
- Evaluation: 90 fixed prompts, 30 each chat/code/document; two timing
  repetitions per model; block size 4 / 3 speculative proposals;
  `max_new_tokens=32`; seed `20260819`.
- Exact guard: enabled. Final sealed held-out set: not used.

## Measured result

| Metric | One layer | Two layers |
|---|---:|---:|
| Exact outputs | 180/180 | 180/180 |
| Draft-token acceptance | 6.0045% | 7.1566% |
| Mean accepted tokens/cycle | 0.1764 | 0.2104 |
| Per-position acceptance | 11.978 / 3.535 / 2.294% | 14.706 / 4.155 / 2.357% |
| End-to-end throughput | 14.1751 tok/s | 13.8359 tok/s |
| Total wall time | 313.932 s | 321.628 s |
| Peak VRAM | 323,866,624 B | 339,124,224 B |

Candidate changes: acceptance `+1.1521 percentage points` / `+19.19%`
relative; throughput `-0.3392 tok/s` / `-2.39%` relative. Exactness passed for
all timed calls.

## Immutable remote references

- Existing two-layer checkpoint:
  `/workspace/smollm-eagle3-prototype/checkpoints/dflash2-official-bridge-block3-onpolicy20k-best`
- Acceptance:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity2layer-bounded-20260821-fixed90-acceptance.json`
- Timing:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity2layer-bounded-20260821-timing.json`
- Timing log:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity2layer-bounded-20260821-timing.log`

The full remote artifacts remain external to this compact repository. Hashes
and final cleanup state are recorded in the experiment card.
