#!/usr/bin/env bash
set -Eeuo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: $0 /dev/shm/pq020-rs-axis-<run-id>" >&2
    exit 64
fi

run_dir=$1
case "$run_dir" in
    /dev/shm/pq020-rs-axis-*) ;;
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
contract=$run_dir/benchmark-contract-n-rs-axis-r1.json

server_sha=fcbf4b9d5847f19ad2391af0109b3d0d067de19d0448bb96acc1a1011af20d41
common_sha=03c6f8777d10033598adde9888b008bd74082000eca7a579692e4b3c729b43bb
server_impl_sha=fd5a9bf6ac5237f0c8821bc66a75e81c7c1b1a24b4ac487a496d4fbe4386a066
common_source_sha=05bc54a210601550730e024c3820fa89cd1f4382792ccf457faf3853f55f6c43
target_sha=3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887
draft_sha=18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594
client_sha=477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4
prompt_sha=374eea10112daeac6cd6d9499230abd6ac68cfebf7804c14e96bb71a7223b7d5
contract_sha=3f444c000f67e5e3bf43ac05d7372c57e726d1bde9e851ebe8cb7c2cb600aa31

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
assert_sha "$runtime_task/source/common/common.cpp" "$common_source_sha"
assert_sha "$target" "$target_sha"
assert_sha "$draft" "$draft_sha"
assert_sha "$client" "$client_sha"
assert_sha "$prompt" "$prompt_sha"
assert_sha "$contract" "$contract_sha"

[[ $(wc -l < "$prompt") -eq 1 ]] || exit 68
[[ $(jq -r '.id' "$prompt") == code_python_debug ]] || exit 68

if pgrep -x llama-server >/dev/null 2>&1 || pgrep -f '[b]enchmark_client_v21.py' >/dev/null 2>&1; then
    echo "competing task process detected" >&2
    exit 69
fi
gpu_pids=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true)
[[ -z "$gpu_pids" ]] || { echo "GPU is not idle: $gpu_pids" >&2; exit 70; }
shm_free=$(df -B1 --output=avail /dev/shm | tail -1 | tr -d '[:space:]')
(( shm_free >= 1073741824 )) || exit 71

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    hostname
    nvidia-smi --query-gpu=name,memory.total,memory.used,utilization.gpu,temperature.gpu,driver_version --format=csv,noheader
    df -B1 /workspace /dev/shm
    sha256sum "$server" "$bin_dir/libllama-common.so.0.1.2" "$bin_dir/libllama-server-impl.so" \
        "$runtime_task/source/common/common.cpp" "$target" "$draft" "$client" "$prompt" "$contract"
    grep -E '^LLAMA_(BUILD_UI|USE_PREBUILT_UI):' "$runtime_task/build/CMakeCache.txt"
} > "$run_dir/preflight.txt"

wait_health() {
    local port=$1
    for _ in {1..240}; do
        if curl -fsS "http://127.0.0.1:$port/health" >/dev/null 2>&1; then
            return 0
        fi
        kill -0 "$child_pid" 2>/dev/null || return 1
        sleep 0.5
    done
    return 1
}

run_arm() {
    local name=$1 port=$2 force_n_rs=$3 mode=$4 use_draft=$5
    local -a argv=(
        "$server"
        -m "$target"
        --host 127.0.0.1 --port "$port"
        --ctx-size 4096 --parallel 1
        --n-gpu-layers all
        --no-context-shift --no-cache-prompt
        --reasoning off --metrics --perf
        --log-verbosity 5 --log-colors off --log-prefix --log-timestamps
    )
    if [[ "$use_draft" == 1 ]]; then
        argv+=(
            -md "$draft"
            --spec-type draft-dflash
            --spec-draft-n-max 1
            --spec-draft-ngl all
        )
    fi

    {
        printf 'cwd=%q\n' "$workspace"
        printf 'env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1 PQ020_TRACE=1 PQ020_FORCE_N_RS_SEQ=%q LD_LIBRARY_PATH=%q' "$force_n_rs" "$bin_dir"
        printf ' %q' "${argv[@]}"
        printf '\n'
        printf '/usr/bin/python3 %q --mode %q --base-url %q --contract %q --prompts %q --output %q --repetition 1 --wait-seconds 300\n' \
            "$client" "$mode" "http://127.0.0.1:$port" "$contract" "$prompt" "$run_dir/$name-client.json"
    } > "$run_dir/$name-command.txt"

    (
        cd "$workspace"
        exec env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1 PQ020_TRACE=1 \
            PQ020_FORCE_N_RS_SEQ="$force_n_rs" LD_LIBRARY_PATH="$bin_dir" "${argv[@]}"
    ) > "$run_dir/$name-server.log" 2>&1 &
    child_pid=$!

    if ! wait_health "$port"; then
        echo "$name server failed health check" >&2
        tail -100 "$run_dir/$name-server.log" >&2 || true
        exit 72
    fi

    (
        cd "$workspace"
        /usr/bin/python3 "$client" \
            --mode "$mode" \
            --base-url "http://127.0.0.1:$port" \
            --contract "$contract" \
            --prompts "$prompt" \
            --output "$run_dir/$name-client.json" \
            --repetition 1 \
            --wait-seconds 300
    ) > "$run_dir/$name-client.log" 2>&1

    cleanup
    sleep 2

    jq -e --arg prompt_sha "$prompt_sha" --arg contract_sha "$contract_sha" '
        .prompt_manifest_sha256 == $prompt_sha and
        .contract_sha256 == $contract_sha and
        .summary.requests == 1 and
        .summary.completion_tokens == 64 and
        (.runs | length) == 1 and
        .runs[0].prompt_id == "code_python_debug" and
        .runs[0].completion_tokens == 64 and
        .runs[0].finish_reason == "length"
    ' "$run_dir/$name-client.json" >/dev/null

    grep -E "n_rs_seq[[:space:]]+=[[:space:]]+$force_n_rs" "$run_dir/$name-server.log" >/dev/null
}

run_arm target_n_rs_1 8102 1 target 0
run_arm q4_n1_n_rs_0 8103 0 dflash2 1

gpu_after=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true)
[[ -z "$gpu_after" ]] || exit 73

jq -n \
    --arg status completed_n_rs_axis_diagnostic \
    --arg target_output "$(jq -r '.runs[0].assistant_message_sha256' "$run_dir/target_n_rs_1-client.json")" \
    --arg q4_output "$(jq -r '.runs[0].assistant_message_sha256' "$run_dir/q4_n1_n_rs_0-client.json")" \
    --argjson target_summary "$(jq -c '.summary' "$run_dir/target_n_rs_1-client.json")" \
    --argjson q4_summary "$(jq -c '.summary' "$run_dir/q4_n1_n_rs_0-client.json")" \
    --arg target_log_sha "$(sha256sum "$run_dir/target_n_rs_1-server.log" | awk '{print $1}')" \
    --arg q4_log_sha "$(sha256sum "$run_dir/q4_n1_n_rs_0-server.log" | awk '{print $1}')" \
    '{
        status: $status,
        evidence_class: "two-arm one-prompt recurrent-state causal diagnostic; timing is not promotion evidence",
        target_n_rs_1: {output_sha256: $target_output, summary: $target_summary, server_log_sha256: $target_log_sha},
        q4_n1_n_rs_0: {output_sha256: $q4_output, summary: $q4_summary, server_log_sha256: $q4_log_sha},
        heldout_used: false,
        runtime_or_source_edit: true,
        edit_class: "strict environment override of target recurrent-state snapshot count only"
    }' > "$run_dir/summary.json"

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    nvidia-smi --query-gpu=name,memory.used,utilization.gpu,temperature.gpu --format=csv,noheader
    ps -eo pid,comm,args | grep -E 'llama-server|benchmark_client_v21.py' | grep -v grep || true
    df -B1 /workspace /dev/shm
} > "$run_dir/cleanup.txt"

sha256sum "$run_dir"/* > "$run_dir/SHA256SUMS.txt"
