# Experiments

Create cards under `experiments/cards/` using
`templates/experiment-card.md`. IDs use:

`EXP-YYYYMMDD-NNN-short-slug`

Cards are append-oriented. Correct an error with a dated amendment explaining
the change; do not silently rewrite an old conclusion.

Every card links its compact receipts, logs, checkpoint identities, and index
entries. Binary artifacts remain outside Git.

Use [`../queue/INDEX.md`](../queue/INDEX.md) for lifecycle and approval state,
and [`../docs/ORCHESTRATION.md`](../docs/ORCHESTRATION.md) for role handoffs.
A planned card is not execution authorization.
