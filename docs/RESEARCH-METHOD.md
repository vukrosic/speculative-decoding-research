# Research method

## One experiment, one causal question

Each card should identify one intended change and everything held fixed. If
several variables change, label the result bundled or confounded and avoid a
causal claim.

## Freeze before optimizing

Freeze target, drafter parent, tokenizer, prompt IDs, split hashes, evaluator,
seed, decoding settings, runtime, and hardware contract before comparison.
Keep the final held-out set sealed until a checkpoint is selected.

## Promotion gates

A typical training promotion sequence is:

1. shapes and exact parameter count;
2. finite forward, loss, backward, optimizer step, and relevant gradients;
3. bounded fit or learning check;
4. source-disjoint validation loss and accuracy;
5. fixed validation acceptance;
6. quality and correctness contract;
7. sealed held-out evaluation once;
8. matched end-to-end speed only after the correctness gate.

## Metrics are not interchangeable

- Loss measures probability assigned to labels.
- Accuracy measures exact teacher-forced token hits.
- Acceptance measures tokens surviving autoregressive verification.
- Quality measures task behavior or distribution fidelity.
- Speed measures the complete serving path, including proposal, verification,
  rejection/correction, caches, scheduling, and synchronization.
- Exactness measures equality under a defined oracle and decoding contract.

Report each separately.

## Failure is a result

A negative experiment must retain its card, metrics, failing invariant, logs or
receipt links, and the next discriminating question. Never delete or relabel a
failure after a later success.

## Daily synthesis

Every active research day ends with:

- what was observed;
- what changed in beliefs;
- what remains unknown;
- what was rejected and why;
- the best current setup;
- exact next experiments, ordered by expected information gain;
- cleanup, artifact, and receipt status.

