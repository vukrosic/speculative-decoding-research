# Agent rules

Read this file completely before doing anything in this repository. Then read
the nearest nested `AGENTS.md`, if one exists, before changing files below it.

## Authorization and scope

- Do not start SSH sessions, remote GPU work, downloads, installs, training,
  generation, evaluation, publishing, or paid work without explicit current
  authorization from the user.
- A planning, documentation, review, or indexing request authorizes local,
  non-destructive documentation work only.
- Never infer that an old authorization still applies after a stop, pause, or
  scope change.
- Preserve existing files and experiment records. Create additive, uniquely
  named artifacts. Never rewrite history to make a failed result disappear.

## Evidence discipline

- Freeze evaluation prompts, datasets, splits, seeds, decoding settings,
  target checkpoints, evaluator code, and baseline receipts before comparing
  candidates.
- Keep untouched test and exactness guards sealed until model selection.
- Separate these evidence classes in every report:
  1. teacher-forced loss;
  2. teacher-forced token accuracy;
  3. autoregressive draft acceptance;
  4. task or output quality;
  5. end-to-end latency and throughput;
  6. exact target-equivalence or losslessness.
- Never infer acceptance from loss, quality from acceptance, or speed from
  draft latency alone.
- Never claim a speedup without a matched end-to-end baseline, repeated timing,
  output counts, hardware/runtime versions, and the applicable correctness
  gate.
- Never use the words `exact`, `lossless`, `equivalent`, or `bit-identical`
  unless the relevant test actually passed and its receipt is linked.
- Distinguish observed facts from hypotheses and interpretations. Label unknown
  values as `unknown`; never fill gaps from memory as if measured.
- Include negative controls for exactness/verifier work when practical.

## Version and provenance requirements

Record, at minimum:

- target and drafter names, immutable checkpoint hashes, quantization, and
  parameter counts;
- GPU model, VRAM, driver, CUDA/ROCm, CPU, RAM, and power settings when relevant;
- runtime, framework, compiler, kernel/backend, and source commit;
- tokenizer, dataset/split hashes, evaluator commit/hash, seed, and generation
  settings;
- command, working directory, environment identity, timestamps, logs, metrics,
  peak VRAM, wall time, process cleanup, and final device state.

## Repository storage policy

- This repository is a compact knowledge and experiment-control plane, not an
  artifact warehouse.
- Never commit model weights, checkpoints, GGUFs, datasets, feature tensors,
  hidden states, binary traces, profiler captures, full generated corpora,
  build trees, environments, or large logs.
- Prefer Markdown, small JSON/YAML receipts, hashes, manifests, summaries, and
  immutable external artifact URIs.
- Keep large artifacts in approved external/local storage and record: URI or
  path, SHA-256, byte size, producer experiment, retention status, and access
  notes. A local path is not proof that the artifact still exists.
- Before committing any file larger than 1 MiB, justify it in the experiment
  card. Files larger than 5 MiB require explicit user approval.
- Do not add Git LFS unless the user explicitly authorizes it.
- Never delete external artifacts merely because this repo references them.

## Experiment workflow

1. Create an experiment card from `templates/experiment-card.md` before the
   first mutating action.
2. State the question, frozen controls, single intended change, promotion gate,
   stop conditions, and artifact budget.
3. Run the smallest construction/correctness/fit gate appropriate to risk.
4. Append phase notes while work happens; do not wait until the end to record
   failures or decisions.
5. Store compact receipts under `receipts/<experiment-id>/` and link them from
   the card.
6. End every terminal experiment with a receipt covering outputs, hashes,
   measurements, failures, cleanup, and final hardware/process state.
7. Update `results/INDEX.md`, `failures/INDEX.md` when applicable,
   `open-questions/INDEX.md`, and the current daily note.

## Reporting language

Use two explicit sections:

- `Observed`: direct measurements and verified state.
- `Interpretation / hypotheses`: explanations, implications, and proposed next
  tests.

If a result is approximate, confounded, validation-only, or underpowered, say
so next to the metric—not only in a footnote.

