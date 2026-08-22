#!/usr/bin/env bash
set -Eeuo pipefail

run_dir=${1:-}
case "$run_dir" in
    /dev/shm/pq020-independent-v23-*) ;;
    *) echo "usage: $0 /dev/shm/pq020-independent-v23-<run-id>" >&2; exit 64 ;;
esac

workspace=/workspace/smollm-eagle3-prototype
runtime_task=$workspace/experiments/pq020-instrumented-runtime-20260822T0546Z
bin_dir=$runtime_task/build/bin
server=$bin_dir/llama-server
target=$workspace/experiments/qwen38-27b-iq1s-spec-v20-20260820/models/unsloth-qwen38-27b-4ca72078/Qwen3.8-27B-UD-IQ1_S.gguf
draft=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/models/Qwen3.8-27B-DFlash2-Q4_K_M.gguf
client=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/scripts/benchmark_client_v21.py
prompt=$run_dir/validation-acceptance-screen-prompts-v23.jsonl
contract=$run_dir/benchmark-contract-independent-v23-screen-r1.json

server_sha=fcbf4b9d5847f19ad2391af0109b3d0d067de19d0448bb96acc1a1011af20d41
common_sha=65b8a862607e2894f7ec87eb073a74d70e3501b3bbd6bec709dc2a1d8dafca56
server_impl_sha=fd5a9bf6ac5237f0c8821bc66a75e81c7c1b1a24b4ac487a496d4fbe4386a066
sampling_sha=c1b1f6f05561deb597c86a94a3464e4e5e003fd430e51094768873532fc48768
common_source_sha=05bc54a210601550730e024c3820fa89cd1f4382792ccf457faf3853f55f6c43
target_sha=3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887
draft_sha=18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594
client_sha=477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4
prompt_sha=30668abcb12a25a8c6b69f8f54bcf5f8942df3b800c996a52ba28d4e9af1f914
contract_sha=3b0735504fd8153ef32f1d667cf80a44817bb44d8de0a025e138a35395023854

child_pid=
cleanup() {
    if [[ -n "$child_pid" ]] && kill -0 "$child_pid" 2>/dev/null; then
        kill -TERM "$child_pid" 2>/dev/null || true
        for _ in {1..40}; do
            kill -0 "$child_pid" 2>/dev/null || break
            sleep 0.25
        done
        kill -KILL "$child_pid" 2>/dev/null || true
        wait "$child_pid" 2>/dev/null || true
    fi
    child_pid=
}
trap cleanup EXIT INT TERM

assert_sha() {
    local path=$1 expected=$2 observed
    observed=$(sha256sum "$path" | awk '{print $1}')
    [[ "$observed" == "$expected" ]] || { echo "sha256 mismatch: $path" >&2; exit 65; }
}

wait_health() {
    local port=$1
    for _ in {1..240}; do
        curl -fsS "http://127.0.0.1:$port/health" >/dev/null 2>&1 && return 0
        kill -0 "$child_pid" 2>/dev/null || return 1
        sleep 0.5
    done
    return 1
}

[[ -d "$run_dir" ]] || exit 66
assert_sha "$server" "$server_sha"
assert_sha "$bin_dir/libllama-common.so.0.1.2" "$common_sha"
assert_sha "$bin_dir/libllama-server-impl.so" "$server_impl_sha"
assert_sha "$runtime_task/source/common/sampling.cpp" "$sampling_sha"
assert_sha "$runtime_task/source/common/common.cpp" "$common_source_sha"
assert_sha "$target" "$target_sha"
assert_sha "$draft" "$draft_sha"
assert_sha "$client" "$client_sha"
assert_sha "$prompt" "$prompt_sha"
assert_sha "$contract" "$contract_sha"
[[ $(wc -l < "$prompt") -eq 12 ]] || exit 67
[[ $(jq -r 'select(.split != "validation") | .id' "$prompt" | wc -l) -eq 0 ]] || exit 67
mapfile -t prompt_ids < <(jq -r '.id' "$prompt")
expected_ids=(v23-explanation-00005 v23-math-00019 v23-structured-00021 v23-reasoning-00080 v23-explanation-00095 v23-coding-00126 v23-math-00127 v23-instruction-00160 v23-reasoning-00170 v23-structured-00201 v23-instruction-00316 v23-coding-00438)
[[ "${prompt_ids[*]}" == "${expected_ids[*]}" ]] || exit 67
if pgrep -x llama-server >/dev/null 2>&1 || pgrep -f '[b]enchmark_client_v21.py' >/dev/null 2>&1; then exit 68; fi
[[ -z $(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true) ]] || exit 69
shm_free=$(df -B1 --output=avail /dev/shm | tail -1 | tr -d '[:space:]')
(( shm_free >= 1073741824 )) || exit 70

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    hostname
    nvidia-smi --query-gpu=name,memory.total,memory.used,utilization.gpu,temperature.gpu,driver_version --format=csv,noheader
    df -B1 /workspace /dev/shm
    sha256sum "$server" "$bin_dir/libllama-common.so.0.1.2" "$bin_dir/libllama-server-impl.so" \
        "$runtime_task/source/common/sampling.cpp" "$runtime_task/source/common/common.cpp" \
        "$target" "$draft" "$client" "$prompt" "$contract"
} > "$run_dir/preflight.txt"

run_arm() {
    local name=$1 port=$2 mode=$3 corrected=$4
    local -a argv=(
        "$server" -m "$target" --host 127.0.0.1 --port "$port"
        --ctx-size 4096 --parallel 1 --n-gpu-layers all
        --no-context-shift --no-cache-prompt --reasoning off --metrics --perf
        --log-verbosity 3 --log-colors off --log-prefix --log-timestamps
    )
    if [[ "$corrected" == 1 ]]; then
        argv+=( -md "$draft" --spec-type draft-dflash --spec-draft-n-max 1 --spec-draft-ngl all )
    fi
    {
        printf 'cwd=%q\n' "$workspace"
        if [[ "$corrected" == 1 ]]; then
            printf 'env CUDA_VISIBLE_DEVICES=0 PQ020_LOW_MARGIN_TOP2=0.08 LD_LIBRARY_PATH=%q' "$bin_dir"
        else
            printf 'env CUDA_VISIBLE_DEVICES=0 LD_LIBRARY_PATH=%q' "$bin_dir"
        fi
        printf ' %q' "${argv[@]}"
        printf '\n'
    } > "$run_dir/$name-command.txt"

    if [[ "$corrected" == 1 ]]; then
        (cd "$workspace"; exec env CUDA_VISIBLE_DEVICES=0 PQ020_LOW_MARGIN_TOP2=0.08 LD_LIBRARY_PATH="$bin_dir" "${argv[@]}") > "$run_dir/$name-server.log" 2>&1 &
    else
        (cd "$workspace"; exec env CUDA_VISIBLE_DEVICES=0 LD_LIBRARY_PATH="$bin_dir" "${argv[@]}") > "$run_dir/$name-server.log" 2>&1 &
    fi
    child_pid=$!
    wait_health "$port" || { tail -100 "$run_dir/$name-server.log" >&2 || true; exit 71; }
    (cd "$workspace"; /usr/bin/python3 "$client" --mode "$mode" --base-url "http://127.0.0.1:$port" \
        --contract "$contract" --prompts "$prompt" --output "$run_dir/$name.json" \
        --repetition 1 --wait-seconds 300) > "$run_dir/$name-client.log" 2>&1
    cleanup
    sleep 2
}

run_arm target 8108 target 0

jq -e --slurpfile contract "$contract" --arg p "$prompt_sha" --arg c "$contract_sha" '
    .mode == "target" and .prompt_manifest_sha256 == $p and .contract_sha256 == $c and
    .summary.requests == 12 and .summary.completion_tokens == 625 and (.runs | length) == 12 and
    (([.runs[] | {key:.prompt_id,value:.assistant_message_sha256}] | from_entries) == $contract[0].expected_target_outputs)
' "$run_dir/target.json" >/dev/null

run_arm corrected_q4_n1 8109 dflash2 1
grep -F 'PQ020_LOW_MARGIN_TOP2 ' "$run_dir/corrected_q4_n1-server.log" > "$run_dir/override-events.log" || true

projections_match=$(jq -s '
    def projection: [.runs[] | {prompt_id,assistant_message_sha256,completion_tokens,finish_reason}] | sort_by(.prompt_id);
    (.[0] | projection) == (.[1] | projection)
' "$run_dir/target.json" "$run_dir/corrected_q4_n1.json")

jq -n --slurpfile target "$run_dir/target.json" --slurpfile q4 "$run_dir/corrected_q4_n1.json" \
    --argjson projections_match "$projections_match" \
    --argjson override_rows "$(wc -l < "$run_dir/override-events.log")" \
    --arg override_sha "$(sha256sum "$run_dir/override-events.log" | awk '{print $1}')" '
    def indexed($runs): reduce $runs[] as $r ({}; .[$r.prompt_id] = $r);
    (indexed($target[0].runs)) as $t |
    (indexed($q4[0].runs)) as $q |
    ($t | keys | map({
        prompt_id:.,
        target_sha256:$t[.].assistant_message_sha256,
        corrected_q4_sha256:$q[.].assistant_message_sha256,
        target_completion_tokens:$t[.].completion_tokens,
        corrected_q4_completion_tokens:$q[.].completion_tokens,
        target_finish_reason:$t[.].finish_reason,
        corrected_q4_finish_reason:$q[.].finish_reason,
        full_projection_match:($t[.].assistant_message_sha256 == $q[.].assistant_message_sha256 and $t[.].completion_tokens == $q[.].completion_tokens and $t[.].finish_reason == $q[.].finish_reason)
    })) as $per_prompt |
    {
        status:(if $projections_match then "completed_pass" else "completed_negative" end),
        evidence_class:"no-retuning independent public-v23 output screen; timing diagnostic only",
        all_12_target_projections_match:$projections_match,
        matching_prompts:([$per_prompt[] | select(.full_projection_match)] | length),
        mismatching_prompt_ids:[$per_prompt[] | select(.full_projection_match|not) | .prompt_id],
        per_prompt:$per_prompt,
        target_summary:$target[0].summary,
        corrected_q4_summary:$q4[0].summary,
        diagnostic_speed_change_percent:(($q4[0].summary.aggregate_request_tokens_per_second / $target[0].summary.aggregate_request_tokens_per_second - 1) * 100),
        override_events:$override_rows,
        override_log_sha256:$override_sha,
        threshold_retuned:false,
        heldout_used:false,
        claim_boundary:"independent public validation only; not a held-out or general losslessness guarantee"
    }
' > "$run_dir/summary.json"

[[ -z $(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true) ]] || exit 72
{
    date -u +%Y-%m-%dT%H:%M:%SZ
    nvidia-smi --query-gpu=name,memory.used,utilization.gpu,temperature.gpu --format=csv,noheader
    ps -eo pid,comm,args | grep -E 'llama-server|benchmark_client_v21.py' | grep -v grep || true
    df -B1 /workspace /dev/shm
} > "$run_dir/cleanup.txt"
sha256sum "$run_dir"/* > "$run_dir/SHA256SUMS.txt"
