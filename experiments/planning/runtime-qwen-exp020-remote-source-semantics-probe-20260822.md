---
id: RUNTIME-QWEN-EXP020-REMOTE-SOURCE-SEMANTICS-PROBE-20260822
date: 2026-08-22
status: planner-packet-no-transfer-not-executed
scope: bounded remote-only marker/source-semantics inspection; no source transfer, build, model, binary, GPU, or experiment
parent: EXP-20260822-020-qwen-singleton-correction
gate_refs: critic=42427490ab4b8e430cd3d6e52c60052ab67f63ee072c765f9b3d1559c3da8f7f; literature=2f8df83f158e8b9933020cf3a7b0491bdf8a01f207c3273d90b426e74ac03f8d
---

# EXP020 remote-only source-semantics probe

## Purpose and limits

The local EXP020 phase logs contain marker events, but the exact source files
are absent locally. This packet requests only pre/post hash and stat metadata
plus exact marker hits and bounded numbered context from the frozen remote
source paths. It never streams or copies a full source file, model, dataset,
binary, library, log, or other artifact. The remote command performs no source
write and creates no remote temporary file.

The snippets may help locate marker ownership and nearby control/branch text,
but they cannot establish complete source provenance. The observed remote
hashes are not independently reproduced locally, and snippets are not a
full-source receipt. This probe cannot authorize a patch, rebuild, model run,
GPU run, speed claim, exactness claim, or verifier change.

## Frozen controls

- Host: root@125.240.239.50, port 35738; no alternate host, port, tunnel, or
  fallback.
- Project: /workspace/smollm-eagle3-prototype.
- Source root:
  /workspace/smollm-eagle3-prototype/experiments/pq020-instrumented-runtime-20260822T0546Z/source.
- common/speculative.cpp: expected 112689 bytes, SHA-256
  6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0.
- tools/server/server-context.cpp: expected 223748 bytes, SHA-256
  c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2.
- source_only_transfer=false; full_source_transfer=false;
  snippet_only_output=true.
- Hard output cap: 65536 bytes of remote stdout total. A cap failure is
  terminal; never truncate and treat the result as complete.
- Prohibited artifacts/operations: model, dataset/prompt, binary/library,
  build output, runtime log, patch, install, unrelated download, source write,
  model/server launch, timing/generation, GPU use, holdout access, second host,
  and fallback connection.

## One bounded SSH command (design only; not executed)

The executor captures stdout/stderr as `.part` text under a new task-owned
local receipt directory and promotes them only after both caps and the empty
stderr gate pass. Only marker/context text and metadata are transferred; no
source-file payload is emitted. ConnectTimeout, ServerAlive bounds, and one
connection attempt bound the session.

~~~sh
set -eu
export LC_ALL=C
umask 077
out="receipts/EXP-20260822-020-qwen-singleton-correction/remote-source-semantics-20260822"
mkdir -p "$out"
test ! -e "$out/stdout.txt" && test ! -e "$out/stderr.txt" && test ! -e "$out/stdout.txt.part" && test ! -e "$out/stderr.txt.part" && test ! -e "$out/partial-terminal.md"
write_partial() {
  status="$1"
  if test ! -e "$out/partial-terminal.md"; then
    stdout_path="$out/stdout.txt.part"; test -e "$stdout_path" || stdout_path="$out/stdout.txt"
    stderr_path="$out/stderr.txt.part"; test -e "$stderr_path" || stderr_path="$out/stderr.txt"
    stdout_bytes=$(wc -c < "$stdout_path" 2>/dev/null || printf 0)
    stderr_bytes=$(wc -c < "$stderr_path" 2>/dev/null || printf 0)
    stdout_cap=false; test "$stdout_bytes" -le 65536 && stdout_cap=true
    stderr_cap=false; test "$stderr_bytes" -le 65536 && stderr_cap=true
    printf "%s\n" "status=$status" "stdout_bytes=$stdout_bytes" "stderr_bytes=$stderr_bytes" "stdout_cap=$stdout_cap" "stderr_cap=$stderr_cap" "preserve=stdout.txt.part,stderr.txt.part" > "$out/partial-terminal.md"
  fi
}
trap 'write_partial INTERRUPTED; exit 130' HUP INT TERM

if ! ssh -q -T -o BatchMode=yes -o StrictHostKeyChecking=yes \
  -o ConnectTimeout=10 -o ServerAliveInterval=5 -o ServerAliveCountMax=2 \
  -o ConnectionAttempts=1 -p 35738 root@125.240.239.50 '
  set -eu
  export LC_ALL=C
  umask 077
  project=/workspace/smollm-eagle3-prototype
  task="$project/experiments/pq020-instrumented-runtime-20260822T0546Z"
  src="$task/source"
  max_output=65536
  marker_re="PQ020_(DRAFT|VERIFY_BATCH_BEGIN|VERIFY_BATCH_ROW|VERIFY_BEGIN|VERIFY_ROW|DRAFT_VECTOR|VERIFY_RESULT|ACCEPTED_VECTOR|MEMORY_AFTER)"
  marker_list="PQ020_DRAFT PQ020_VERIFY_BATCH_BEGIN PQ020_VERIFY_BATCH_ROW PQ020_VERIFY_BEGIN PQ020_VERIFY_ROW PQ020_DRAFT_VECTOR PQ020_VERIFY_RESULT PQ020_ACCEPTED_VECTOR PQ020_MEMORY_AFTER"
  test -d "$project" && test -d "$task" && test -d "$src"
  process_pattern="(^|/)(llama-[s]erver|benchmark_client_v21[.]py|pq020_[r]un)"
  pre_process_snapshot=$(pgrep -af "$process_pattern" || true)
  if test -n "$pre_process_snapshot"; then
    printf "status=UNEXPECTED_PROCESS\nprocess_snapshot=%s\n" "$pre_process_snapshot" >&2
    exit 31
  fi
  gpu=$(nvidia-smi --query-gpu=name,memory.used,utilization.gpu --format=csv,noheader,nounits)
  test -n "$gpu"
  gpu_identity=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)
  gpu_row_count=$(printf "%s\n" "$gpu_identity" | wc -l | tr -d " ")
  test "$gpu_row_count" -eq 1
  gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  test -n "$gpu_util"
  pre_gpu_util_ok=true
  for util in $gpu_util; do
    case "$util" in 0|0.0|0.00) ;; *) pre_gpu_util_ok=false ;; esac
  done
  test "$pre_gpu_util_ok" = true
  compute_apps=$(nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv,noheader,nounits)
  test -z "$compute_apps"
  rg_path=$(command -v rg)
  test -x "$rg_path"
  rg_version=$("$rg_path" --version | head -n 1)

  make_meta() {
    rel="$1"; expected_bytes="$2"; expected_sha="$3"; p="$src/$rel"
    test -f "$p"
    bytes=$(stat -c %s "$p")
    mtime=$(stat -c %Y "$p")
    sha=$(sha256sum "$p" | awk "{print \$1}")
    test "$bytes" -eq "$expected_bytes"
    test "$sha" = "$expected_sha"
    printf "%s|bytes=%s|mtime=%s|sha256=%s|path=%s\n" \
      "$rel" "$bytes" "$mtime" "$sha" "$p"
  }

  context_for() {
    rel="$1"; p="$src/$rel"
    for marker in $marker_list; do
      set +e
      marker_hits=$("$rg_path" -n --no-heading --color=never -F "$marker" "$p")
      marker_rc=$?
      set -e
      test "$marker_rc" -eq 0 || test "$marker_rc" -eq 1
      marker_count=0
      if test "$marker_rc" -eq 0; then
        marker_count=$(printf "%s\n" "$marker_hits" | wc -l | tr -d " ")
      fi
      marker_present=false
      test "$marker_count" -gt 0 && marker_present=true
      printf "marker_presence[%s][%s]|present=%s|count=%s|context_complete=UNKNOWN\n" \
        "$rel" "$marker" "$marker_present" "$marker_count"
    done
    set +e
    hits=$("$rg_path" -n --no-heading --color=never "$marker_re" "$p")
    hits_rc=$?
    set -e
    test "$hits_rc" -eq 0 || test "$hits_rc" -eq 1
    printf "marker_hits[%s]\n%s\n" "$rel" "$hits"
    if test -n "$hits"; then
      printf "%s\n" "$hits" | cut -d: -f1 | while read -r line; do
        start=$((line > 4 ? line - 4 : 1)); end=$((line + 4))
        printf "context[%s:%s-%s]\n" "$rel" "$start" "$end"
        nl -ba "$p" | sed -n "${start},${end}p"
      done
    fi
  }

  pre_a=$(make_meta common/speculative.cpp 112689 6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0)
  pre_b=$(make_meta tools/server/server-context.cpp 223748 c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2)
  snippets="$(context_for common/speculative.cpp; context_for tools/server/server-context.cpp)"
  post_a=$(make_meta common/speculative.cpp 112689 6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0)
  post_b=$(make_meta tools/server/server-context.cpp 223748 c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2)
  test "$pre_a" = "$post_a" && test "$pre_b" = "$post_b"
  post_process_snapshot=$(pgrep -af "$process_pattern" || true)
  if test -n "$post_process_snapshot"; then
    printf "status=UNEXPECTED_POST_PROCESS\nprocess_snapshot=%s\n" "$post_process_snapshot" >&2
    exit 32
  fi
  post_gpu=$(nvidia-smi --query-gpu=name,memory.used,utilization.gpu --format=csv,noheader,nounits)
  test -n "$post_gpu"
  post_gpu_identity=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)
  post_gpu_row_count=$(printf "%s\n" "$post_gpu_identity" | wc -l | tr -d " ")
  test "$post_gpu_row_count" -eq 1
  test "$post_gpu_identity" = "$gpu_identity"
  test "$post_gpu_row_count" -eq "$gpu_row_count"
  post_gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  test -n "$post_gpu_util"
  post_gpu_util_ok=true
  for util in $post_gpu_util; do
    case "$util" in 0|0.0|0.00) ;; *) post_gpu_util_ok=false ;; esac
  done
  test "$post_gpu_util_ok" = true
  post_compute_apps=$(nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv,noheader,nounits)
  test -z "$post_compute_apps"

  set +e
  aggregate_hits=$("$rg_path" -n --no-heading --color=never "$marker_re" "$src/common/speculative.cpp" "$src/tools/server/server-context.cpp")
  aggregate_rc=$?
  set -e
  test "$aggregate_rc" -eq 0 || test "$aggregate_rc" -eq 1
  aggregate_marker_count=0
  if test "$aggregate_rc" -eq 0; then
    aggregate_marker_count=$(printf "%s\n" "$aggregate_hits" | wc -l | tr -d " ")
  fi
  test "$aggregate_marker_count" -gt 0 || { printf "status=NO_MARKER_HITS\n" >&2; exit 33; }

  payload=$(printf "status=PASS_SNIPPET_ONLY\ncontext_only_transfer=true\nsource_only_transfer=false\nsource_file_bytes_transferred=false\nfull_source_transfer=false\nmodel_data_binary_download=false\ninstall=false\nbuild=false\ngpu=false\nremote_mutation=false\nmax_output_bytes=65536\nrg_version=%s\ngpu=%s\ngpu_util=%s\ncompute_apps=%s\npre=%s\npre=%s\npost=%s\npost=%s\npost_gpu=%s\npost_gpu_util=%s\npost_compute_apps=%s\npost_active=%s\n%s\n" \
    "$rg_version" "$gpu" "$gpu_util" "$compute_apps" "$pre_a" "$pre_b" "$post_a" "$post_b" "$post_gpu" "$post_gpu_util" "$post_compute_apps" "$post_process_snapshot" "$snippets")
  output_bytes=$(printf "%s" "$payload" | wc -c)
  test "$output_bytes" -le "$max_output"
  printf "%s" "$payload"
' > "$out/stdout.txt.part" 2> "$out/stderr.txt.part"; then
  write_partial REMOTE_COMMAND_FAILED
  exit 1
fi

stdout_bytes=$(wc -c < "$out/stdout.txt.part")
stderr_bytes=$(wc -c < "$out/stderr.txt.part")
if test "$stdout_bytes" -gt 65536 || test "$stderr_bytes" -gt 65536; then
  write_partial LOCAL_RECEIPT_CAP_FAILURE
  exit 1
fi
if test -s "$out/stderr.txt.part"; then
  write_partial REMOTE_STDERR_NONEMPTY
  exit 1
fi
mv "$out/stdout.txt.part" "$out/stdout.txt"
mv "$out/stderr.txt.part" "$out/stderr.txt"
trap - HUP INT TERM
~~~ 

The remote make_meta function machine-checks both expected paths, byte counts,
and full-file SHA values before snippets are emitted. The second make_meta pass
is the remote pinned-path post-read mutation check; it does not claim whole-tree
immutability. The local shell enforces 65,536-byte stdout and stderr caps
before promoting `.part` files, records the `rg` version and empty compute-app
state, and preserves both channels plus a non-overwritten terminal note on
every failure or interruption. No remote cat, cp, redirection, temp file, or
source write occurs.

## Required local receipts

- stdout.txt: bounded marker/context text and pre/post metadata only, promoted
  from a checked `.part` file.
- stderr.txt: must be empty and no larger than 65,536 bytes on PASS; preserve its
  `.part` file and byte count on failure.
- partial-terminal.md on any SSH, cap, JSON/text, process, GPU, or metadata
  failure; never delete or overwrite partial output.
- terminal.md: final PASS_SNIPPET_ONLY or NO_CANDIDATE_SOURCE_GAP, exact stop
  reason, host/path/hash/stat metadata, and cleanup state.
- marker-index.json/md: per-file/per-marker `present`, `count`, and
  `context_complete` fields; missing, duplicated, truncated, or ambiguous
  contexts are explicit `UNKNOWN`/`NO_CANDIDATE_SOURCE_GAP`, never a pass.
- SHA256SUMS.txt: hashes of text receipts only. It must not claim a locally
  reproduced full-source hash or complete provenance.

## Hard stops and claim boundary

The nine expected marker families are `PQ020_DRAFT`,
`PQ020_VERIFY_BATCH_BEGIN`, `PQ020_VERIFY_BATCH_ROW`, `PQ020_VERIFY_BEGIN`,
`PQ020_VERIFY_ROW`, `PQ020_DRAFT_VECTOR`, `PQ020_VERIFY_RESULT`,
`PQ020_ACCEPTED_VECTOR`, and `PQ020_MEMORY_AFTER`. For each file/family, a
zero-hit record is `present=false,count=0`; if both files have zero hits, the
terminal disposition is `NO_CANDIDATE_SOURCE_GAP`. A count greater than one
is retained as separate numbered hits and is `UNKNOWN` until the local index
proves each context unambiguous. `context_complete` is true only when the
returned bounded window contains the marker line and enough surrounding text
to identify the requested field/branch; otherwise it is `UNKNOWN` and cannot
support a PASS for that marker. A family present in one file but absent in the
other is not an error by itself; record the absence explicitly.

Stop closed if host/path/port changes, SSH exceeds timeout/liveness bounds, any
fallback is attempted, `rg` is absent/fails, either file is absent or its
expected size/hash fails, pre/post pinned-path metadata differs, stdout or
stderr exceeds 65,536 bytes, stderr is nonempty, all marker hits are absent,
per-marker presence/count/context fields cannot be recorded, marker or context
extraction is ambiguous, a compute application or experiment process/GPU use is
observed, or any remote write/build/model/data/binary/artifact action occurs.
Preserve all partial receipts.

A PASS reports only bounded marker line hits and nearby numbered context from
the hash-checked remote files. It cannot establish complete full-source
provenance, independently reproduce full-source hashes, prove token/state
semantics, or authorize a patch, build, rerun, or GPU experiment. A later
source-map card would still require complete source provenance plus critic and
literature review, exactness/state controls, and a separate CEO decision.

## Planner disposition

**Packet ready; not executed.** This is the smallest literal-no-download
continuation: one frozen host/session, metadata and snippets only, hard output
cap, pre/post mutation checks, and no remote source writes. It does not close
the full-source gap or authorize any causal intervention.
