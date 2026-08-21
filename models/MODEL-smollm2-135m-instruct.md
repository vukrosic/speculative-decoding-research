---
id: MODEL-smollm2-135m-instruct
kind: target
status: available-external
---

# SmolLM2-135M-Instruct target

- Parameter count: 134,515,008.
- Vocabulary: 49,152.
- Checkpoint: existing pinned remote snapshot; path/hash not copied into this
  knowledge repository and should be backfilled from the experiment receipt.
- Precision/runtime: frozen target weights under the remote PyTorch bridge.
- Known behavior: BF16 block verification may differ from repeated singleton
  execution; exact experiments retained a singleton replay guard.
- Related experiments:
  [EXP-20260819-001](../experiments/cards/EXP-20260819-001-smollm-onpolicy20k.md),
  [EXP-20260819-002](../experiments/cards/EXP-20260819-002-smollm-capacity35m.md).
- Last verified in recorded evidence: 2026-08-19.

