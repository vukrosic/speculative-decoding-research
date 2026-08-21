# Repository locations (internal operations note)

This file is intentionally generic. It is safe to keep in the public tree and
does not contain hostnames, usernames, credentials, or personal filesystem
paths.

## Local research repository

Use the checkout containing this file as `RESEARCH_REPO_ROOT`. Keep model
weights, datasets, checkpoints, feature tensors, environments, and large logs
outside Git; record a generic artifact URI or a redacted local reference in a
receipt.

## Remote execution project

Use an authorized remote checkout as `REMOTE_PROJECT_ROOT`. Connection details
belong in the operator's private environment, never in a public card, issue,
receipt, or example. Record only the runtime version, hardware identity,
artifact hashes, and a redacted command shape in public research notes.

## Naming convention

Experiment cards and compact receipts live in the research repository. A
remote command must identify its working directory privately and link back to
the corresponding experiment card. Never publish access details as part of a
scientific result.
