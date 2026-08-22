---
id: CRITIQUE-QWEN-EXP020-SOURCE-INTAKE-GATE-20260822
date: 2026-08-22
kind: preflight critique of read-only provenance intake
verdict: CONDITIONAL PASS FOR SOURCE-ONLY INTAKE; NO EXECUTION AUTHORIZATION
---

# Scope decision

The packet is correctly scoped as a read-only provenance intake, not an
experiment. Streaming the two exact pinned source files into a task-owned
local receipt is admissible as a **source-only transfer** needed to close the
source-map gap. It must not be described or expanded into a general download.
The allowed payload is exactly:

- `common/speculative.cpp`, 112,689 bytes, SHA `6a24e473...`;
- `tools/server/server-context.cpp`, 223,748 bytes, SHA `c060c9f5...`.

The combined maximum is 336,437 bytes. No model/GGUF, dataset, checkpoint,
binary/library, build output, archive, package, repository clone, dependency,
or unrelated artifact may cross the host boundary. No install, build, server,
benchmark, model load, timing, output generation, holdout access, or GPU action
is in scope. This critique does not authorize the intake to execute.

## Gates that pass on paper

- The remote endpoint, project, task root, and source root are frozen to one
  authorized host and one existing checkout.
- The metadata preflight is read-only (`test`, `stat`, `sha256sum`, `pgrep`,
  `nvidia-smi`, and `df`) and has no write, kill, build, or model command.
- The two `cat` streams name exact absolute source paths and write only to a
  new local task-owned receipt directory. They do not mutate the remote
  checkout.
- Local `wc -c`/`sha256sum` checks, the marker index, and all source mapping
  are CPU/read-only. Existing raw logs and parser receipts remain immutable.
- The receipt contract requires remote stdout/stderr, literal commands,
  host/UTC, file stats/hashes, process/GPU/disk state, captured bytes, local
  hashes, marker index, terminal disposition, and a manifest hash.

## Required amendments before any handoff

1. **Bound the transport.** Add literal SSH connection/liveness limits (for
   example `ConnectTimeout`, `ServerAliveInterval`, and
   `ServerAliveCountMax`) to every SSH invocation. Keep `BatchMode=yes`,
   `StrictHostKeyChecking=yes`, the one frozen host, and no `ProxyJump` or
   fallback endpoint. Record the exact command text actually used.
2. **Make the byte boundary machine-checkable.** Before capture, assert the
   two remote `stat` sizes and expected hashes; after each stream, assert the
   local size is exactly 112,689 or 223,748 and hash matches. Refuse any
   recursive copy, glob, archive, compression, or path supplied by an
   environment variable. A partial stream is a hard stop; do not retry into
   the same receipt without a new terminal record.
3. **Separate source transfer from prohibited downloads.** The terminal note
   must say `source_only_transfer=true`, list both exact relative paths and
   total bytes, and state `model_data_binary_download=false`,
   `install=false`, `build=false`, `gpu=false`, and `remote_mutation=false`.
   A generic “download” label is insufficient because it could hide a model
   or dependency transfer.
4. **Prove no remote mutation.** Preserve pre/post checkout identity and
   task-root/source-root metadata without running `git checkout`, `git pull`,
   `touch`, `sed -i`, `cp` into the remote tree, cleanup, or process kills.
   If `pgrep` finds unrelated infrastructure, record it and stop; never kill
   it. The source stream may be read while the remote tree is otherwise idle
   only if this is recorded; a source mtime/hash change is a hard stop.
5. **Keep local analysis separate.** Run `rg`/`nl` only against the captured
   local bytes after both hash gates pass. The marker index must bind every
   marker to file/line/function/branch/fields and preserve UNKNOWN for absent
   markers; it must not infer source semantics from ELF symbols or logs.

## Exact stop conditions

Stop with `NO_CANDIDATE_SOURCE_GAP` on host-key/endpoint/path mismatch,
timeout or partial stream, size/hash mismatch, unexpected process/GPU/resource
state, any remote write or second host, any non-source artifact transfer, or
incomplete marker ownership. Preserve partial files as evidence in a distinct
terminal receipt; do not overwrite them or silently retry.

## Gate verdict

**CONDITIONAL PASS for the narrowly defined source-only intake; NOT
EXECUTION-READY and no authorization from this critique.** After the planner
adds bounded SSH timeouts, an explicit 336,437-byte maximum, and the
source-only/prohibited-artifact assertions above, the CEO may review a
read-only handoff. Even a complete source intake closes only provenance
mapping. It does not authorize a patch, build, model load, GPU run, timing
screen, or speed/exactness claim. Until then, preserve the existing
`NO_CANDIDATE_SOURCE_GAP` disposition.

Sources: `experiments/planning/runtime-qwen-exp020-source-intake-20260822.md`,
`receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/source-map-audit-20260822.json`,
and the current-65b8 phase-pair receipts.
