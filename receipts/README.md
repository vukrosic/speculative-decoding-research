# Receipts

Store only compact receipts. Use
`receipts/<experiment-id>/<timestamp>-<kind>.json` and link each file from the
experiment card.

A terminal receipt records:

- status and timestamps;
- exact command/environment;
- input and output hashes;
- direct measurements;
- failed gates and negative controls;
- owned-process cleanup;
- final GPU/process state;
- whether held-out data was touched.

Large logs and artifacts stay external and are referenced by immutable identity.

