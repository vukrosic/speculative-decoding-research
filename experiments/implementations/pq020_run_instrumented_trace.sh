#!/usr/bin/env bash
set -Eeuo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: $0 /dev/shm/pq020-instrumented-trace-<run-id>" >&2
    exit 64
fi

run_dir=$1
case "$run_dir" in
    /dev/shm/pq020-instrumented-trace-*) ;;
    *) echo "refusing non-task-owned run directory: $run_dir" >&2; exit 65 ;;
esac

workspace=/workspace/smollm-eagle3-prototype
runtime_task=$workspace/experiments/pq020-instrumented-runtime-20260822T0546Z
bin_dir=$runtime_task/build/bin
server=$bin_dir/llama-server
target=$workspace/experiments/qwen38-27b-iq1s-spec-v20-20260820/models/unsloth-qwen38-27b-4ca72078/Qwen3.8-27B-UD-IQ1_S.gguf
draft=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/models/Qwen3.8-27B-DFlash2-Q4_K_M.gguf
client=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/scripts/benchmark_client_v21.py
prompt=$run_dir/code-python-debug-v20-one.jsonl
contract=$run_dir/benchmark-contract-q4-n1-instrumented-trace.json
port=8101

server_sha=fcbf4b9d5847f19ad2391af0109b3d0d067de19d0448bb96acc1a1011af20d41
common_sha=d07ed8b4c22e9c6c8fe20caf9ebcb87d64090b8fa7c67f74cc197f094d50348a
server_impl_sha=fd5a9bf6ac5237f0c8821bc66a75e81c7c1b1a24b4ac487a496d4fbe4386a066
target_sha=3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887
draft_sha=18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594
client_sha=477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4
prompt_sha=374eea10112daeac6cd6d9499230abd6ac68cfebf7804c14e96bb71a7223b7d5
contract_sha=c6057a11ddb0dd39df359200cd04396a860eee446e9eed84973fd7b824c0b211
expected_output=1d5020bfedee4bbc2c878d7d3805bf76ccd2e85dfc90817c4b3422af75122646

child_pid=
cleanup() {
    if [[ -n "$child_pid" ]] && kill -0 "$child_pid" 2>/dev/null; then
        kill -TERM "$child_pid" 2>/dev/null || true
        for _ in {1..40}; do
            kill -0 "$child_pid" 2>/dev/null || break
            sleep 0.25
        done
        if kill -0 "$child_pid" 2>/dev/null; then
            kill -KILL "$child_pid" 2>/dev/null || true
        fi
        wait "$child_pid" 2>/dev/null || true
    fi
    child_pid=
}
trap cleanup EXIT INT TERM

assert_sha() {
    local path=$1 expected=$2 observed
    observed=$(sha256sum "$path" | awk '{print $1}')
    [[ "$observed" == "$expected" ]] || { echo "sha256 mismatch: $path" >&2; exit 66; }
}

[[ -d "$run_dir" ]] || { echo "run directory must be staged" >&2; exit 67; }
assert_sha "$server" "$server_sha"
assert_sha "$bin_dir/libllama-common.so.0.1.2" "$common_sha"
assert_sha "$bin_dir/libllama-server-impl.so" "$server_impl_sha"
assert_sha "$target" "$target_sha"
assert_sha "$draft" "$draft_sha"
assert_sha "$client" "$client_sha"
assert_sha "$prompt" "$prompt_sha"
assert_sha "$contract" "$contract_sha"

[[ $(wc -l < "$prompt") -eq 1 ]] || exit 68
[[ $(jq -r '.id' "$prompt") == code_python_debug ]] || exit 68
[[ $(jq -r '.instrumented_runtime.llama_server_sha256' "$contract") == "$server_sha" ]] || exit 69

if pgrep -x llama-server >/dev/null 2>&1 || pgrep -f '[b]enchmark_client_v21.py' >/dev/null 2>&1; then
    echo "competing task process detected" >&2
    exit 70
fi
gpu_pids=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true)
[[ -z "$gpu_pids" ]] || { echo "GPU is not idle: $gpu_pids" >&2; exit 71; }
shm_free=$(df -B1 --output=avail /dev/shm | tail -1 | tr -d '[:space:]')
(( shm_free >= 1073741824 )) || exit 72

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    hostname
    nvidia-smi --query-gpu=name,memory.total,memory.used,utilization.gpu,temperature.gpu,driver_version --format=csv,noheader
    df -B1 /workspace /dev/shm
    sha256sum "$server" "$bin_dir/libllama-common.so.0.1.2" "$bin_dir/libllama-server-impl.so" "$target" "$draft" "$client" "$prompt" "$contract"
    grep -E '^LLAMA_(BUILD_UI|USE_PREBUILT_UI):' "$runtime_task/build/CMakeCache.txt"
} > "$run_dir/preflight.txt"

wait_health() {
    for _ in {1..240}; do
        if curl -fsS "http://127.0.0.1:$port/health" >/dev/null 2>&1; then
            return 0
        fi
        kill -0 "$child_pid" 2>/dev/null || return 1
        sleep 0.5
    done
    return 1
}

argv=(
    "$server"
    -m "$target"
    --host 127.0.0.1 --port "$port"
    --ctx-size 4096 --parallel 1
    --n-gpu-layers all
    --no-context-shift --no-cache-prompt
    --reasoning off --metrics --perf
    --log-verbosity 5 --log-colors off --log-prefix --log-timestamps
    -md "$draft"
    --spec-type draft-dflash
    --spec-draft-n-max 1
    --spec-draft-ngl all
)

{
    printf 'cwd=%q\n' "$workspace"
    printf 'env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1 PQ020_TRACE=1 LD_LIBRARY_PATH=%q' "$bin_dir"
    printf ' %q' "${argv[@]}"
    printf '\n'
    printf '/usr/bin/python3 %q --mode dflash2 --base-url %q --contract %q --prompts %q --output %q --repetition 1 --wait-seconds 300\n' \
        "$client" "http://127.0.0.1:$port" "$contract" "$prompt" "$run_dir/q4-client.json"
} > "$run_dir/q4-command.txt"

(
    cd "$workspace"
    exec env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1 PQ020_TRACE=1 LD_LIBRARY_PATH="$bin_dir" "${argv[@]}"
) > "$run_dir/q4-server.log" 2>&1 &
child_pid=$!

if ! wait_health; then
    echo "instrumented server failed health check" >&2
    tail -100 "$run_dir/q4-server.log" >&2 || true
    exit 73
fi

(
    cd "$workspace"
    /usr/bin/python3 "$client" \
        --mode dflash2 \
        --base-url "http://127.0.0.1:$port" \
        --contract "$contract" \
        --prompts "$prompt" \
        --output "$run_dir/q4-client.json" \
        --repetition 1 \
        --wait-seconds 300
) > "$run_dir/q4-client.log" 2>&1

cleanup
sleep 2

jq -e --arg prompt_sha "$prompt_sha" --arg contract_sha "$contract_sha" --arg output_sha "$expected_output" '
    .prompt_manifest_sha256 == $prompt_sha and
    .contract_sha256 == $contract_sha and
    .summary.requests == 1 and
    .summary.completion_tokens == 64 and
    (.runs | length) == 1 and
    .runs[0].prompt_id == "code_python_debug" and
    .runs[0].assistant_message_sha256 == $output_sha and
    .runs[0].completion_tokens == 64 and
    .runs[0].finish_reason == "length"
' "$run_dir/q4-client.json" >/dev/null

grep -F 'PQ020_' "$run_dir/q4-server.log" > "$run_dir/q4-instrumentation.log"
draft_events=$(grep -c 'PQ020_DRAFT_VECTOR ' "$run_dir/q4-instrumentation.log")
verify_begins=$(grep -c 'PQ020_VERIFY_BEGIN ' "$run_dir/q4-instrumentation.log")
verify_results=$(grep -c 'PQ020_VERIFY_RESULT ' "$run_dir/q4-instrumentation.log")
memory_afters=$(grep -c 'PQ020_MEMORY_AFTER ' "$run_dir/q4-instrumentation.log")
zero_accepts=$(grep -c 'PQ020_VERIFY_RESULT accepted_size=1 accepted_draft=0' "$run_dir/q4-instrumentation.log")
accepted_vector_rows=$(grep -c 'PQ020_ACCEPTED_VECTOR ' "$run_dir/q4-instrumentation.log")

[[ "$draft_events" -eq 35 ]] || exit 74
[[ "$verify_begins" -eq 35 ]] || exit 75
[[ "$verify_results" -eq 35 ]] || exit 76
[[ "$memory_afters" -eq 35 ]] || exit 77
[[ "$zero_accepts" -eq 7 ]] || exit 78
[[ "$accepted_vector_rows" -eq 63 ]] || exit 79

gpu_after=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true)
[[ -z "$gpu_after" ]] || exit 80

jq -n \
    --arg status completed_instrumented_diagnostic \
    --arg output_sha "$(jq -r '.runs[0].assistant_message_sha256' "$run_dir/q4-client.json")" \
    --argjson q4_summary "$(jq -c '.summary' "$run_dir/q4-client.json")" \
    --arg server_log_sha "$(sha256sum "$run_dir/q4-server.log" | awk '{print $1}')" \
    --arg instrumentation_sha "$(sha256sum "$run_dir/q4-instrumentation.log" | awk '{print $1}')" \
    --argjson draft_events "$draft_events" \
    --argjson verify_begins "$verify_begins" \
    --argjson verify_results "$verify_results" \
    --argjson memory_afters "$memory_afters" \
    --argjson zero_accepts "$zero_accepts" \
    --argjson accepted_vector_rows "$accepted_vector_rows" \
    '{
        status: $status,
        evidence_class: "instrumented one-prompt diagnostic; timing is not promotion evidence",
        q4_output_sha256: $output_sha,
        q4_summary: $q4_summary,
        event_counts: {
            draft_events: $draft_events,
            verify_begins: $verify_begins,
            verify_results: $verify_results,
            memory_afters: $memory_afters,
            zero_accepts: $zero_accepts,
            accepted_vector_rows: $accepted_vector_rows
        },
        q4_server_log_sha256: $server_log_sha,
        q4_instrumentation_log_sha256: $instrumentation_sha,
        heldout_used: false,
        runtime_or_source_edit: true,
        edit_class: "environment-gated trace logging only"
    }' > "$run_dir/summary.json"

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    nvidia-smi --query-gpu=name,memory.used,utilization.gpu,temperature.gpu --format=csv,noheader
    ps -eo pid,comm,args | grep -E 'llama-server|benchmark_client_v21.py' | grep -v grep || true
    df -B1 /workspace /dev/shm
} > "$run_dir/cleanup.txt"

sha256sum "$run_dir"/* > "$run_dir/SHA256SUMS.txt"
