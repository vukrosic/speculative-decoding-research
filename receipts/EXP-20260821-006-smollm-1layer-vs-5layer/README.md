# Terminal receipt: EXP-20260821-006

## Scope

- Remote project: `/workspace/smollm-eagle3-prototype`
- Target: frozen SmolLM2-135M-Instruct snapshot
- Comparison: 6,520,256-parameter one-layer drafter versus
  20,957,632-parameter five-layer drafter
- Evaluation: 90 frozen prompts, 30 each chat/code/document; two timing
  repetitions per model; block size 4 / 3 speculative proposals;
  `max_new_tokens=32`; seed `20260819`.
- Exact guard: enabled. Final sealed held-out set: not used.

## Measured result

| Metric | One layer | Five layers |
|---|---:|---:|
| Exact outputs | 180/180 | 180/180 |
| Accepted / proposed draft tokens | 642 / 10,692 | 744 / 10,396 |
| Draft-token acceptance | 6.0045% | 7.1566% |
| Mean accepted tokens/cycle | 0.1764 | 0.2104 |
| Per-position acceptance | 11.978 / 3.535 / 2.294% | 14.706 / 4.155 / 2.357% |
| End-to-end throughput | 14.4277 tok/s | 12.4785 tok/s |
| Total wall time | 308.435 s | 356.614 s |
| Peak VRAM | 323,866,624 B | 385,585,152 B |

Absolute candidate changes: acceptance `+1.1521 pp`; throughput `-1.9492
tok/s`. Relative candidate changes: acceptance `+19.19%`; throughput
`-13.51%`.

## Immutable remote references

- Acceptance receipt:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity5layer-bounded-20260821-fixed90-acceptance.json`
- Timing receipt:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity5layer-bounded-20260821-timing.json`
- Timing log:
  `/workspace/smollm-eagle3-prototype/benchmarks/dflash2-block3-capacity5layer-bounded-20260821-timing.log`
- Candidate checkpoint:
  `/workspace/smollm-eagle3-prototype/checkpoints/dflash2-official-bridge-block3-capacity5layer-bounded-20260821-trained`

The full remote artifacts remain external to this compact repository. Their
SHA-256 values and the final idle-device state are recorded in the linked
experiment card.
