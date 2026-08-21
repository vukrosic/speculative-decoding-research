# Quickstart

This repository does not require a framework or a model for the first example.
Run the toy speculative-decoding loop with the Python standard library:

```bash
python3 examples/toy_speculative_decoding.py --steps 24 --block-size 4
```

The command prints JSON containing:

- the generated token sequence;
- proposed and accepted token counts;
- the first rejection positions;
- target verification calls; and
- whether the speculative output matches a target-only replay.

The toy target and drafter are deliberately tiny. The example demonstrates
the control flow, not GPU performance.

## Add an experiment

For a new idea, create a folder or card under `experiments/` and record:

1. the question and the one thing you changed;
2. the command and environment used;
3. the target/drafter/runtime identities when available;
4. the baseline and metrics;
5. what happened, including failures and uncertainty.

The templates under `templates/` are optional starting points. Large models,
datasets, checkpoints, and profiler files stay outside Git; record their
location and SHA-256 in a small receipt instead.

## Read a real result

Start with the Qwen v30 screen:

```text
literature/HANDOFF-20260821-V30-RESULT.md
receipts/EXP-20260821-004-v30-rerun-20260821/summary.json
```

It shows why acceptance, exactness, and end-to-end speed must be reported
separately. The result is intentionally preserved as a negative/approximate
screen rather than promoted as a general speedup.

## Optional GPU work

GPU commands are model- and runtime-specific. Use the relevant experiment card
and receipt schema, keep the target-only baseline beside the speculative run,
and never treat a queue entry as permission to execute. Do not put credentials,
private hostnames, or local filesystem paths in a public issue or pull request.
