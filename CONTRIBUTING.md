# Contributing research evidence

Read `AGENTS.md` first.

## New experiment

1. Copy `templates/experiment-card.md` to a unique file under
   `experiments/cards/`.
2. Freeze the evaluation contract and define the promotion gate before running.
3. Add compact receipts under `receipts/<experiment-id>/`.
4. Keep large artifacts external and record immutable hashes/locations.
5. Update results, failures, questions, entity metadata, and the daily note.
6. Run `tools/check-repo.sh` before committing.

## Corrections

Do not silently alter old measurements. Add a dated amendment explaining the
original statement, corrected evidence, reason, and affected conclusions.

## Claims

Every speed, acceptance, quality, or exactness statement must link to its scope
and evidence. Approximate, validation-only, confounded, and underpowered results
must say so next to the claim.

