# Contributing research and examples

Read `AGENTS.md` first.

Start small. A runnable example, a useful note, or a failed experiment is a
valid contribution. You do not need to adopt a framework or create a new
abstraction before trying an idea.

Never commit credentials, private hostnames/IPs, personal absolute paths, or
large model/data artifacts. Use placeholders in public examples and keep
machine-specific details in a private receipt.

## New experiment

1. Copy `templates/experiment-card.md` to a unique file under
   `experiments/cards/`.
2. State the question and what changed. Freeze the evaluation contract and
   define the promotion gate before a serious comparison.
3. Add compact receipts under `receipts/<experiment-id>/`.
4. Keep large artifacts external and record immutable hashes/locations.
5. Update results, failures, questions, entity metadata, and the daily note.
6. Run `tools/check-repo.sh` before committing. For a public release, also run
   `tools/check-public-release.sh` and review `docs/RELEASE-BOUNDARY.md`.

## Corrections

Do not silently alter old measurements. Add a dated amendment explaining the
original statement, corrected evidence, reason, and affected conclusions.

## Claims

Every speed, acceptance, quality, or exactness statement must link to its scope
and evidence. Approximate, validation-only, confounded, and underpowered results
must say so next to the claim.
