# Current state

Updated: 2026-08-21

## Best supported observations

- SmolLM: the 10.13M two-layer block-3 DFlash2-style bridge remains the exact
  acceptance incumbent at 7.1566% on the fixed 90-prompt slice, with 90/90
  exact outputs.
- SmolLM capacity: increasing draft depth to 35.40M parameters improved
  teacher-forced loss/accuracy but reduced fixed-slice acceptance to 6.8334%.
- Qwen published drafter: high approximate acceptance (52.58%) and +23.86%
  approximate throughput were observed, but strict greedy identity failed on
  4/6 prompts.
- Qwen custom drafter: v27 curve step 4000 at n=4 is the validation incumbent
  with 5.175% acceptance and 11.476 tok/s, but it is slower than target-only
  17.592 tok/s and is not exact.
- Qwen block-shape alignment: target features differ materially between
  singleton and block-17 execution. A bounded aligned continuation improved
  teacher-forced accuracy but not acceptance.

## Claims not supported

- No exact Qwen DFlash speedup is established.
- No evidence shows that lower loss alone improves acceptance.
- No evidence shows that larger or smaller draft capacity alone solves the
  current bottleneck.
- No sealed held-out claim exists for the custom Qwen v27-v31 candidates.

## Current research posture

The next work should maximize information about contiguous-prefix acceptance
and verifier/runtime fidelity while preserving frozen validation and sealed
held-out controls. New remote work requires explicit authorization.

