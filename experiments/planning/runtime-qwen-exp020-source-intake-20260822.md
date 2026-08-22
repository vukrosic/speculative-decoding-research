---
id: RUNTIME-QWEN-EXP020-SOURCE-INTAKE-20260822
date: 2026-08-22
status: planner-packet-read-only-not-executed
scope: recover exact current-65b8 source bytes and marker-operation provenance; no build, model, GPU, patch, or experiment
parent: EXP-20260822-020-qwen-singleton-correction
gate_refs: critic=c305b764...; literature=426c0330...
---

# EXP020 exact source-intake packet

## Decision boundary

The completed current-65b8 phase pair has marker logs and hash references but
the local workspace does not contain the pinned source payloads. A remote
hash-only check can prove that the files exist and identify their bytes, but it
cannot bind a marker to the causal source operation: line text, surrounding
control flow, arguments, and ownership are not recoverable from a SHA-256
value. **Full bytes of both pinned files are mandatory** before a source map
or one-variable runtime candidate can be drafted.

This packet defines a bounded read-only intake against the already-authorized
remote project. It is a design only; no SSH command below has been executed by
this planner lane. The intake is not an experiment and must not launch a
server, load a model, build, use the GPU, mutate the remote checkout, install,
download unrelated data, or access a holdout.

The critic/literature hardening gates are recorded by the orchestrator as
critic `c305b764...` and literature `426c0330...`. This packet carries the
following machine-checkable controls:

```yaml
source_only_transfer: true
max_total_source_bytes: 336437
prohibited_artifact_flags:
  model_files: true
  binary_or_library_files: true
  build_outputs: true
  runtime_or_benchmark_logs: true
  prompts_or_dataset_files: true
  patches_or_modified_source: true
  holdout_artifacts: true
prohibited_operations:
  second_host_or_fallback: true
  install: true
  unrelated_download: true
  build: true
  model_load: true
  server_launch: true
  gpu_use: true
  timing_or_generation: true
```

The only files eligible for transfer are the two pinned source files, whose
expected byte sum is exactly `112689 + 223748 = 336437`. Any partial stream,
extra byte, or unexpected artifact is a terminal failure; partial receipts
must be preserved rather than cleaned up or overwritten.

## Frozen remote identities

- SSH endpoint: `root@125.240.239.50`, port `35738`.
- Project: `/workspace/smollm-eagle3-prototype`.
- Instrumented task root:
  `/workspace/smollm-eagle3-prototype/experiments/pq020-instrumented-runtime-20260822T0546Z`.
- Source root:
  `/workspace/smollm-eagle3-prototype/experiments/pq020-instrumented-runtime-20260822T0546Z/source`.
- Required `common/speculative.cpp`: exactly `112689` bytes,
  SHA-256 `6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0`.
- Required `tools/server/server-context.cpp`: exactly `223748` bytes,
  SHA-256 `c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2`.
- Maximum total source-only transfer: exactly `336437` bytes; the executor
  must enforce both per-file sizes and `total_bytes <= 336437` before accepting
  the intake.
- Existing runtime identity remains informational only:
  `llama-server` `fcbf4b9d...`, `libllama-common` `65b8a862...`, and
  implementation `fd5a9bf6...`. The intake must not rebuild or replace them.

## Exact read-only command sequence (not executed)

The executor must use only the frozen SSH endpoint, with bounded connection
and liveness settings, one metadata session, and one bounded read-only stream
for each source file. No second host, port, tunnel, or fallback is allowed.
The local destination is a new
task-owned receipt directory under
`receipts/EXP-20260822-020-qwen-singleton-correction/source-intake-20260822/`.
The following commands are literal packet content, not an authorization to
run them in this lane.

### 1. Remote metadata/hash preflight

```sh
ssh -o BatchMode=yes -o StrictHostKeyChecking=yes \
  -o ConnectTimeout=10 -o ServerAliveInterval=5 -o ServerAliveCountMax=2 \
  -o ConnectionAttempts=1 -p 35738 \
  root@125.240.239.50 \
  'set -eu
   project=/workspace/smollm-eagle3-prototype
   task="$project/experiments/pq020-instrumented-runtime-20260822T0546Z"
   src="$task/source"
   printf "source_only_transfer=true\n"
   printf "max_total_source_bytes=336437\n"
   printf "model_data_binary_download=false\n"
   printf "install=false build=false server_launch=false model_load=false gpu=false\n"
   printf "remote_mutation=false\n"
   printf "mutation_check=pre\n"
   printf "host="; hostname
   printf "utc="; date -u +%Y-%m-%dT%H:%M:%SZ
   test -d "$project" && test -d "$task" && test -d "$src"
   for rel in common/speculative.cpp tools/server/server-context.cpp; do
     p="$src/$rel"
     case "$rel" in
       common/speculative.cpp)
         expected_bytes=112689
         expected_sha=6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0
         ;;
       tools/server/server-context.cpp)
         expected_bytes=223748
         expected_sha=c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2
         ;;
       *) exit 41 ;;
     esac
     test -f "$p"
     test "$(stat -c %s "$p")" -eq "$expected_bytes"
     test "$(sha256sum "$p" | cut -d " " -f1)" = "$expected_sha"
     stat -c "path=%n bytes=%s mode=%a mtime=%Y" "$p"
     sha256sum "$p"
     case "$rel" in
       common/speculative.cpp)
         test "$(stat -c %s "$p")" -eq 112689
         sha256sum "$p" | grep -F "6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0"
         ;;
       tools/server/server-context.cpp)
         test "$(stat -c %s "$p")" -eq 223748
         sha256sum "$p" | grep -F "c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2"
         ;;
       *)
         printf "unexpected_source_path=%s\n" "$rel" >&2
         exit 1
         ;;
     esac
   done
   pgrep -af "llama-server|benchmark_client_v21.py|pq020" || true
   nvidia-smi --query-gpu=name,memory.used,utilization.gpu --format=csv,noheader,nounits
   df -B1 "$project" /dev/shm'
```

The preflight receipt must preserve stdout/stderr, command text, host/UTC,
remote project/task/source paths, file sizes, full hashes, process listing,
GPU state, and disk state. Hash references alone are a **preflight PASS only**;
they do not close the source gap.

### 2. Full-byte capture after the hash gate

Only if both paths, sizes, and hashes pass may the executor stream the exact
bytes into the local task-owned receipt. This is read-only on the remote host;
it is the one explicitly scoped source-only transfer, not a model/data or
unrelated download. The `.part` files are intentionally retained on failure;
they must never be overwritten or silently accepted.

```sh
set -eu
out="receipts/EXP-20260822-020-qwen-singleton-correction/source-intake-20260822"
mkdir -p "$out/source/common" "$out/source/tools/server"
test ! -e "$out/source/common/speculative.cpp" \
  && test ! -e "$out/source/common/speculative.cpp.part"
test ! -e "$out/source/tools/server/server-context.cpp" \
  && test ! -e "$out/source/tools/server/server-context.cpp.part"
ssh -o BatchMode=yes -o StrictHostKeyChecking=yes \
  -o ConnectTimeout=10 -o ServerAliveInterval=5 -o ServerAliveCountMax=2 \
  -o ConnectionAttempts=1 -p 35738 \
  root@125.240.239.50 \
  'set -eu
   p=/workspace/smollm-eagle3-prototype/experiments/pq020-instrumented-runtime-20260822T0546Z/source/common/speculative.cpp
   test "$(wc -c < "$p")" -eq 112689
   cat "$p"' \
  > "$out/source/common/speculative.cpp.part"
test "$(wc -c < "$out/source/common/speculative.cpp.part")" -eq 112689
test "$(wc -c < "$out/source/common/speculative.cpp.part")" -le 336437
sha256sum "$out/source/common/speculative.cpp.part" | grep -F '6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0'
mv "$out/source/common/speculative.cpp.part" "$out/source/common/speculative.cpp"
ssh -o BatchMode=yes -o StrictHostKeyChecking=yes \
  -o ConnectTimeout=10 -o ServerAliveInterval=5 -o ServerAliveCountMax=2 \
  -o ConnectionAttempts=1 -p 35738 \
  root@125.240.239.50 \
  'set -eu
   p=/workspace/smollm-eagle3-prototype/experiments/pq020-instrumented-runtime-20260822T0546Z/source/tools/server/server-context.cpp
   test "$(wc -c < "$p")" -eq 223748
   cat "$p"' \
  > "$out/source/tools/server/server-context.cpp.part"
test "$(wc -c < "$out/source/tools/server/server-context.cpp.part")" -eq 223748
test "$(wc -c < "$out/source/tools/server/server-context.cpp.part")" -le 336437
sha256sum "$out/source/tools/server/server-context.cpp.part" | grep -F 'c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2'
mv "$out/source/tools/server/server-context.cpp.part" "$out/source/tools/server/server-context.cpp"
bytes_a="$(wc -c < "$out/source/common/speculative.cpp")"
bytes_b="$(wc -c < "$out/source/tools/server/server-context.cpp")"
total_bytes=$((bytes_a + bytes_b))
test "$bytes_a" -eq 112689
test "$bytes_b" -eq 223748
test "$total_bytes" -le 336437
test "$total_bytes" -eq 336437
sha256sum "$out/source/common/speculative.cpp" "$out/source/tools/server/server-context.cpp" > "$out/source/SHA256SUMS.txt"
grep -F '6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0' "$out/source/SHA256SUMS.txt"
grep -F 'c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2' "$out/source/SHA256SUMS.txt"
```

The local hashes and byte counts must exactly equal the frozen values above.
The executor must never use an unverified stream, partial file, terminal copy,
or source path outside the frozen task root. A failed SSH stream leaves its
`.part` file and must produce a partial terminal receipt; it must not be
retried on another host or silently removed.

### 2b. Remote post-transfer no-mutation check

After the local byte and hash gates, run the same frozen host/path check again
and save it as `postflight.json`. Compare its two full hashes and byte counts
to `preflight.json`; any difference is `REMOTE_SOURCE_MUTATION_OR_DRIFT` and
terminalizes the intake. This check is read-only and does not inspect or copy
any other remote artifact.

```sh
ssh -o BatchMode=yes -o StrictHostKeyChecking=yes \
  -o ConnectTimeout=10 -o ServerAliveInterval=5 -o ServerAliveCountMax=2 \
  -o ConnectionAttempts=1 -p 35738 \
  root@125.240.239.50 \
  'set -eu
   project=/workspace/smollm-eagle3-prototype
   task="$project/experiments/pq020-instrumented-runtime-20260822T0546Z"
   src="$task/source"
   printf "source_only_transfer=true\n"
   printf "max_total_source_bytes=336437\n"
   printf "model_data_binary_download=false\n"
   printf "install=false build=false server_launch=false model_load=false gpu=false\n"
   printf "remote_mutation=false\n"
   printf "mutation_check=post\n"
   for rel in common/speculative.cpp tools/server/server-context.cpp; do
     p="$src/$rel"
     test -f "$p"
     stat -c "path=%n bytes=%s mode=%a mtime=%Y" "$p"
     sha256sum "$p"
   done'
```

### 3. Local marker-operation index (CPU/read-only)

After both full-byte hashes pass, inspect the captured files locally only:

```sh
rg -n -C 4 'PQ020_(DRAFT|VERIFY_BATCH_BEGIN|VERIFY_BATCH_ROW|VERIFY_BEGIN|VERIFY_ROW|DRAFT_VECTOR|VERIFY_RESULT|ACCEPTED_VECTOR|MEMORY_AFTER)' \
  "$out/source/common/speculative.cpp" \
  "$out/source/tools/server/server-context.cpp"
nl -ba "$out/source/common/speculative.cpp" | sed -n '1,220p;1680,1745p'
nl -ba "$out/source/tools/server/server-context.cpp" | sed -n '450,515p;3815,3910p;3945,3985p'
```

The index must identify, for every marker, file, line, enclosing function,
condition/branch, logged fields, and whether it is before/after draft,
verification, rollback, or memory commit. The marker names may be absent from
one file; absence must be recorded rather than inferred. The preserved raw log
and parser remain separate evidence and must not be rewritten.

## Required receipt set

The intake is complete only with all of the following additive artifacts:

1. `preflight.json`: literal SSH command, host/UTC, project/task/source paths,
   file `stat` values, full remote hashes, process/GPU/disk state, and no-write
   assertion.
2. `source/common/speculative.cpp` and
   `source/tools/server/server-context.cpp`: exact captured bytes.
3. `source/SHA256SUMS.txt`: local byte counts and hashes, matching the remote
   preflight and frozen values.
4. `marker-index.json` plus `marker-index.md`: deterministic local line map,
   enclosing functions, field/branch semantics, parser/receipt links, and
   explicit UNKNOWN fields.
5. `terminal.md`: PASS or `NO_CANDIDATE_SOURCE_GAP`, hard-stop reason, cleanup
   state, and next action. A manifest hash must cover every receipt file.

## Hard stops

Stop and write `NO_CANDIDATE_SOURCE_GAP` if any of these occur:

- SSH host-key, endpoint, `BatchMode`, project, task-root, or source-root
  mismatch; missing `AGENTS.md`/required remote safety context if the executor
  needs it; or any unexpected remote path.
- Either file is absent, size differs, SHA-256 differs, capture is truncated,
  or the local bytes do not exactly match the remote bytes.
- Any source file is modified, checkout state changes, a build/model/server/
  benchmark process appears, GPU utilization/memory changes unexpectedly, or
  resource/cleanup state is not recorded. Do not kill unrelated infrastructure.
- Marker text, line ownership, enclosing function, logged fields, or branch
  semantics cannot be established from the captured bytes. Do not infer them
  from binary symbols, event logs, historical d07 traces, or generic source.
- The executor attempts a second host, download, install, build, model load,
  server launch, timing run, output generation, or GPU action.

## Reopen and candidate gate

If and only if both exact source files and a complete marker index pass, the
source gap is closed for **read-only provenance mapping**, not for execution.
The next planner action would be a new additive source-map note that binds one
candidate operation to one marker interval and explicitly preserves token
ordering, positions, masks, KV/cache extents, rollback, sampler state, and
serialization. A later one-variable implementation card still requires fresh
critic and literature review, target-only/Q4 correctness and transaction
controls, repeated matched timing, and a separate CEO decision. Source intake
alone never authorizes a patch or GPU run.

If the intake fails, retain the current terminal diagnostic and leave the
program `NO-CANDIDATE`/blocked on the exact source-only artifact. Do not
substitute the `65b8a862...` binary, the historical `d07ed8b4...` trace, or
marker logs for source bytes.

## Planner disposition

**Packet ready; not executed.** Hash-bound inspection is useful for identity
and path validation but is insufficient to bind marker operations. Full exact
source bytes plus a deterministic marker index are mandatory. No remote
connection, source transfer, build, model load, GPU use, rerun, or patch was
performed by this lane.
