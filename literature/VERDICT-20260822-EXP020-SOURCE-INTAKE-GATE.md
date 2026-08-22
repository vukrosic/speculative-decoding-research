---
date: 2026-08-22
kind: literature/evidence gate
scope: EXP020 exact current-65b8 source-byte intake
status: conditional read-only provenance PASS; no execution in literature lane
---

# Gate for exact source-byte intake

## Admissibility under the no-download boundary

The packet is well-scoped as a bounded artifact-recovery design: it reads two
named files from the already-authorized instrumented task root, does not mutate
the remote checkout, and forbids model/data/package downloads, installs,
builds, model loads, GPU use, and inference. Exact bytes are necessary because
SHA-256 references alone cannot reveal marker line ownership, surrounding
control flow, logged fields, or branch semantics.

The proposed `ssh ... cat > local receipt` is nevertheless a remote-to-local
file transfer. It must not be treated as a generic download or silently
executed by the literature lane. It is admissible only if the CEO/executor
records it as a narrowly bounded, read-only source-evidence intake within the
existing repository scope. If the standing no-download policy is interpreted
to prohibit any remote-to-local transfer, this packet is **BLOCKED** and needs
separate user authorization; no substitute or hash-only inference is allowed.

## What the intake can bind

If admitted and complete, full-byte hashes plus the deterministic marker index
can bind each `PQ020_*` marker to an exact file, line, enclosing function,
condition/branch, logged fields, and pre/post draft, verification, rollback, or
memory-commit operation. That closes source provenance for the current 65b8
phase diagnostic. It does not, by itself, prove that an interval is causal,
that a phase dominates end-to-end serving cost, or that verifier state is
correct. Logs, token transactions, and interval accounting remain separate
evidence; d07 traces and generic source cannot fill gaps.

## Fail-closed requirements

Stop with `NO_CANDIDATE_SOURCE_GAP` if any of the following occurs:

- host key/endpoint, project/task/source root, file path, byte count, or full
  SHA differs from the frozen identities;
- a stream is truncated/partial, local and remote hashes disagree, or any
  source file changes during intake;
- a second host/path is touched, a package/model/data download or install is
  attempted, or any build, server, model, benchmark, GPU, holdout, or remote
  mutation occurs;
- competing processes, unexpected GPU/resource state, or cleanup evidence is
  missing; or
- marker text, line ownership, enclosing function, branch, logged fields, or
  semantics remain ambiguous. Record `UNKNOWN`; do not infer from ELF symbols,
  d07 history, or event names alone.

Completion requires additive preflight, exact source files, local/remote
`SHA256SUMS`, deterministic marker-index JSON/Markdown, terminal disposition,
and manifest hashes. A complete intake is a provenance pass only; any runtime
candidate still needs a new planner, critic, literature review, correctness
controls, and separate CEO decision. No GPU/source patch/rerun is authorized.

Sources: `experiments/planning/runtime-qwen-exp020-source-intake-20260822.md`,
the current-65b8 phase-pair/source-map audit, and governance's no-download and
CEO approval boundaries.

