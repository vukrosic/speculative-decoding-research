# Repository locations

Keep these two locations distinct in every experiment card, command, receipt,
and handoff.

## MacBook research repository

- Checkout:
  `/Users/vukrosic/Documents/Codex/2026-08-20/connect-to-my-gpu-box-and/speculative-decoding-research`
- GitHub remote:
  [vukrosic/speculative-decoding-research](https://github.com/vukrosic/speculative-decoding-research)
- Purpose: compact research knowledge base, experiment cards, metadata,
  prompts, indexes, daily notes, and small receipts.
- Storage rule: do not store model weights, datasets, checkpoints, feature
  tensors, build trees, environments, or large logs here.

## Remote GPU project

- Project checkout: `/workspace/smollm-eagle3-prototype`
- Host: authorized remote RTX 3060 environment; connection details are not
  stored in this repository.
- Purpose: experiment execution, model/runtime artifacts, training data, and
  large logs/checkpoints that are referenced from the MacBook repository by
  immutable path/identity/hash.
- Persistence: remote storage and host lifecycle must be reverified for each
  authorized run.

## Naming convention

Experiment cards and receipts live in the MacBook repository. Commands that run
on the GPU must show the remote working directory explicitly and link back to
the corresponding MacBook card. Never describe a remote artifact path as if it
were a local checkout path.

