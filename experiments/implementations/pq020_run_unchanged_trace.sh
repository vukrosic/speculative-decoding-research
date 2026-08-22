#!/usr/bin/env bash
set -Eeuo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: $0 /absolute/task-owned-run-dir" >&2
    exit 64
fi

run_dir=$1
case "$run_dir" in
    /dev/shm/pq020-verifier-trace-*) ;;
    *) echo "refusing non-task-owned run directory: $run_dir" >&2; exit 65 ;;
esac

workspace=/workspace/smollm-eagle3-prototype
runtime_root=$workspace/experiments/qwen38-27b-iq1s-spec-v20-20260820/runtime/llama-dflash2-pr27342-5ecbe1ac
server=$runtime_root/build-v21-cuda/bin/llama-server
target=$workspace/experiments/qwen38-27b-iq1s-spec-v20-20260820/models/unsloth-qwen38-27b-4ca72078/Qwen3.8-27B-UD-IQ1_S.gguf
draft=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/models/Qwen3.8-27B-DFlash2-Q4_K_M.gguf
client=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/scripts/benchmark_client_v21.py
prompt=$run_dir/code-python-debug-v20-one.jsonl
contract=$run_dir/benchmark-contract-q4-n1-code-python-trace.json
port=8100

server_sha=78ccd846f70b6d632eb290c33be0b02f818c91b21fb0c126926c901cca5eb0d6
target_sha=3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887
draft_sha=18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594
client_sha=477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4
prompt_sha=374eea10112daeac6cd6d9499230abd6ac68cfebf7804c14e96bb71a7223b7d5
contract_sha=0dfb10cbeffb68fc8da950a0c033bbb3ac399eabe2f8cc07594566f66c730e52

expected_target_output=0f76b6ae57040714633aa638719e0c2a9b3c594cc2ff0ce4bafc75cabee56a6c
expected_q4_output=1d5020bfedee4bbc2c878d7d3805bf76ccd2e85dfc90817c4b3422af75122646

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
    local path=$1
    local expected=$2
    local observed
    observed=$(sha256sum "$path" | awk '{print $1}')
    if [[ "$observed" != "$expected" ]]; then
        echo "sha256 mismatch: $path expected=$expected observed=$observed" >&2
        exit 66
    fi
}

if [[ ! -d "$run_dir" ]]; then
    echo "run directory must be staged before execution: $run_dir" >&2
    exit 67
fi

assert_sha "$server" "$server_sha"
assert_sha "$target" "$target_sha"
assert_sha "$draft" "$draft_sha"
assert_sha "$client" "$client_sha"
assert_sha "$prompt" "$prompt_sha"
assert_sha "$contract" "$contract_sha"

if [[ $(wc -l < "$prompt") -ne 1 ]] || [[ $(jq -r '.id' "$prompt") != code_python_debug ]]; then
    echo "prompt manifest schema mismatch" >&2
    exit 68
fi

if pgrep -x llama-server >/dev/null 2>&1 || pgrep -f '[b]enchmark_client_v21.py' >/dev/null 2>&1; then
    echo "competing task process detected" >&2
    exit 69
fi

gpu_pids=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true)
if [[ -n "$gpu_pids" ]]; then
    echo "GPU is not idle: $gpu_pids" >&2
    exit 70
fi

shm_free=$(df -B1 --output=avail /dev/shm | tail -1 | tr -d '[:space:]')
if (( shm_free < 1073741824 )); then
    echo "insufficient /dev/shm reserve: $shm_free" >&2
    exit 71
fi

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    hostname
    nvidia-smi --query-gpu=name,memory.total,memory.used,utilization.gpu,temperature.gpu,driver_version --format=csv,noheader
    df -B1 /workspace /dev/shm
    sha256sum "$server" "$target" "$draft" "$client" "$prompt" "$contract"
    git -C "$runtime_root" rev-parse HEAD
    git -C "$runtime_root" status --short
} > "$run_dir/preflight.txt"

wait_health() {
    for _ in {1..240}; do
        if curl -fsS "http://127.0.0.1:$port/health" >/dev/null 2>&1; then
            return 0
        fi
        if ! kill -0 "$child_pid" 2>/dev/null; then
            return 1
        fi
        sleep 0.5
    done
    return 1
}

run_arm() {
    local arm=$1
    local mode=$2
    local output=$run_dir/$arm-client.json
    local server_log=$run_dir/$arm-server.log
    local command_file=$run_dir/$arm-command.txt

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
    if [[ "$mode" == dflash2 ]]; then
        argv+=(
            -md "$draft"
            --spec-type draft-dflash
            --spec-draft-n-max 1
            --spec-draft-ngl all
        )
    fi

    {
        printf 'cwd=%q\n' "$workspace"
        printf 'env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1'
        printf ' %q' "${argv[@]}"
        printf '\n'
        printf '/usr/bin/python3 %q --mode %q --base-url %q --contract %q --prompts %q --output %q --repetition 1 --wait-seconds 300\n' \
            "$client" "$mode" "http://127.0.0.1:$port" "$contract" "$prompt" "$output"
    } > "$command_file"

    (
        cd "$workspace"
        exec env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1 "${argv[@]}"
    ) > "$server_log" 2>&1 &
    child_pid=$!

    if ! wait_health; then
        echo "$arm server failed health check" >&2
        tail -100 "$server_log" >&2 || true
        exit 72
    fi

    (
        cd "$workspace"
        /usr/bin/python3 "$client" \
            --mode "$mode" \
            --base-url "http://127.0.0.1:$port" \
            --contract "$contract" \
            --prompts "$prompt" \
            --output "$output" \
            --repetition 1 \
            --wait-seconds 300
    ) > "$run_dir/$arm-client.log" 2>&1

    cleanup

    local expected_output
    if [[ "$arm" == target ]]; then
        expected_output=$expected_target_output
    else
        expected_output=$expected_q4_output
    fi

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
    ' "$output" >/dev/null
}

run_arm target target
run_arm q4 dflash2

grep -E "generate_draft|accepted [[:space:]]*[0-9]+/[[:space:]]*[0-9]+ draft tokens|add accepted tokens|created speculative checkpoint|restoring speculative checkpoint|LLAMA_TRACE" \
    "$run_dir/q4-server.log" > "$run_dir/q4-trace-key-lines.txt" || true

jq -n \
    --arg status completed_diagnostic \
    --arg target_output "$(jq -r '.runs[0].assistant_message_sha256' "$run_dir/target-client.json")" \
    --arg q4_output "$(jq -r '.runs[0].assistant_message_sha256' "$run_dir/q4-client.json")" \
    --argjson target_summary "$(jq -c '.summary' "$run_dir/target-client.json")" \
    --argjson q4_summary "$(jq -c '.summary' "$run_dir/q4-client.json")" \
    --arg trace_sha "$(sha256sum "$run_dir/q4-server.log" | awk '{print $1}')" \
    --arg key_lines_sha "$(sha256sum "$run_dir/q4-trace-key-lines.txt" | awk '{print $1}')" \
    '{
        status: $status,
        evidence_class: "integrated diagnostic; timings not promotion evidence",
        target_output_sha256: $target_output,
        q4_output_sha256: $q4_output,
        target_summary: $target_summary,
        q4_summary: $q4_summary,
        q4_server_log_sha256: $trace_sha,
        q4_trace_key_lines_sha256: $key_lines_sha,
        heldout_used: false,
        runtime_or_source_edit: false
    }' > "$run_dir/summary.json"

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    nvidia-smi --query-gpu=name,memory.used,utilization.gpu,temperature.gpu --format=csv,noheader
    ps -eo pid,comm,args | grep -E 'llama-server|benchmark_client_v21.py' | grep -v grep || true
    df -B1 /workspace /dev/shm
} > "$run_dir/cleanup.txt"

sha256sum "$run_dir"/* > "$run_dir/SHA256SUMS.txt"

