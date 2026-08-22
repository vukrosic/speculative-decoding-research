#!/usr/bin/env bash
set -Eeuo pipefail

run_dir=${1:-}
case "$run_dir" in
    /dev/shm/pq020-corrected-speed-gate-*) ;;
    *) echo "usage: $0 /dev/shm/pq020-corrected-speed-gate-<run-id>" >&2; exit 64 ;;
esac

workspace=/workspace/smollm-eagle3-prototype
runtime_task=$workspace/experiments/pq020-instrumented-runtime-20260822T0546Z
bin_dir=$runtime_task/build/bin
server=$bin_dir/llama-server
target=$workspace/experiments/qwen38-27b-iq1s-spec-v20-20260820/models/unsloth-qwen38-27b-4ca72078/Qwen3.8-27B-UD-IQ1_S.gguf
draft=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/models/Qwen3.8-27B-DFlash2-Q4_K_M.gguf
client=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/scripts/benchmark_client_v21.py
prompt=$run_dir/source-prompts-v20.jsonl
contract=$run_dir/benchmark-contract-corrected-speed-gate-r1.json

server_sha=fcbf4b9d5847f19ad2391af0109b3d0d067de19d0448bb96acc1a1011af20d41
common_sha=65b8a862607e2894f7ec87eb073a74d70e3501b3bbd6bec709dc2a1d8dafca56
server_impl_sha=fd5a9bf6ac5237f0c8821bc66a75e81c7c1b1a24b4ac487a496d4fbe4386a066
sampling_sha=c1b1f6f05561deb597c86a94a3464e4e5e003fd430e51094768873532fc48768
common_source_sha=05bc54a210601550730e024c3820fa89cd1f4382792ccf457faf3853f55f6c43
target_sha=3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887
draft_sha=18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594
client_sha=477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4
prompt_sha=77a9b5703756102bc088891419a6b85f45bd6a26118c4daded334dec91db8514
contract_sha=df4d1251082d196cde229d215201dc18041cb6f42586cea272b541a9ba235140

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

assert_client_output() {
    local path=$1 mode=$2
    jq -e --arg p "$prompt_sha" --arg c "$contract_sha" --arg mode "$mode" '
        .prompt_manifest_sha256 == $p and .contract_sha256 == $c and .mode == $mode and
        .summary.requests == 6 and .summary.completion_tokens == 227 and (.runs | length) == 6 and
        ([.runs[] | select(.prompt_id == "code_python_debug" and .assistant_message_sha256 == "0f76b6ae57040714633aa638719e0c2a9b3c594cc2ff0ce4bafc75cabee56a6c" and .completion_tokens == 64 and .finish_reason == "length")] | length) == 1 and
        ([.runs[] | select(.prompt_id == "code_rust_parser" and .assistant_message_sha256 == "fdfb48a6f578bdd44760d881c8d96817c3e7965aee0a9c897eea4d22e21ba16d" and .completion_tokens == 64 and .finish_reason == "length")] | length) == 1 and
        ([.runs[] | select(.prompt_id == "math_modular" and .assistant_message_sha256 == "4798d4b5ad3fa59b7957a4f29e4358fae499eab7c3904109c8cc0734a9814190" and .completion_tokens == 1 and .finish_reason == "stop")] | length) == 1 and
        ([.runs[] | select(.prompt_id == "logic_schedule" and .assistant_message_sha256 == "820f59857a44016e4d87c883bf94005743882576b0273087dbaf29a0d258b2b1" and .completion_tokens == 64 and .finish_reason == "length")] | length) == 1 and
        ([.runs[] | select(.prompt_id == "technical_explain" and .assistant_message_sha256 == "4798d4b5ad3fa59b7957a4f29e4358fae499eab7c3904109c8cc0734a9814190" and .completion_tokens == 1 and .finish_reason == "stop")] | length) == 1 and
        ([.runs[] | select(.prompt_id == "structured_extract" and .assistant_message_sha256 == "9fbd13bad069245acc783e0fcca69b534ced18a30ab4c56e8e1546da52c6e699" and .completion_tokens == 33 and .finish_reason == "stop")] | length) == 1
    ' "$path" >/dev/null
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
[[ $(wc -l < "$prompt") -eq 6 ]] || exit 67
mapfile -t prompt_ids < <(jq -r '.id' "$prompt")
expected_ids=(code_python_debug code_rust_parser math_modular logic_schedule technical_explain structured_extract)
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
    grep -E '^LLAMA_(BUILD_UI|USE_PREBUILT_UI):' "$runtime_task/build/CMakeCache.txt"
} > "$run_dir/preflight.txt"

run_arm() {
    local name=$1 port=$2 mode=$3 corrected=$4
    local -a argv=(
        "$server" -m "$target"
        --host 127.0.0.1 --port "$port"
        --ctx-size 4096 --parallel 1 --n-gpu-layers all
        --no-context-shift --no-cache-prompt --reasoning off --metrics --perf
        --log-verbosity 3 --log-colors off --log-prefix --log-timestamps
    )
    if [[ "$corrected" == 1 ]]; then
        argv+=(
            -md "$draft" --spec-type draft-dflash
            --spec-draft-n-max 1 --spec-draft-ngl all
        )
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
        (
            cd "$workspace"
            exec env CUDA_VISIBLE_DEVICES=0 PQ020_LOW_MARGIN_TOP2=0.08 LD_LIBRARY_PATH="$bin_dir" "${argv[@]}"
        ) > "$run_dir/$name-server.log" 2>&1 &
    else
        (
            cd "$workspace"
            exec env CUDA_VISIBLE_DEVICES=0 LD_LIBRARY_PATH="$bin_dir" "${argv[@]}"
        ) > "$run_dir/$name-server.log" 2>&1 &
    fi
    child_pid=$!
    wait_health "$port" || { tail -100 "$run_dir/$name-server.log" >&2 || true; exit 71; }

    local label repetition output
    for label in warmup r1 r2 r3; do
        case "$label" in
            warmup) repetition=0 ;;
            r1) repetition=1 ;;
            r2) repetition=2 ;;
            r3) repetition=3 ;;
        esac
        output=$run_dir/$name-$label.json
        (
            cd "$workspace"
            /usr/bin/python3 "$client" --mode "$mode" --base-url "http://127.0.0.1:$port" \
                --contract "$contract" --prompts "$prompt" --output "$output" \
                --repetition "$repetition" --wait-seconds 300
        ) > "$run_dir/$name-$label.log" 2>&1
        assert_client_output "$output" "$mode"
        if [[ "$corrected" == 1 ]]; then
            jq -e '.summary.draft_accepted_tokens == 103 and .summary.draft_proposed_tokens == 118' "$output" >/dev/null
        fi
    done

    cleanup
    sleep 2
}

run_arm target 8106 target 0
run_arm corrected_q4_n1 8107 dflash2 1

grep -F 'PQ020_LOW_MARGIN_TOP2 ' "$run_dir/corrected_q4_n1-server.log" > "$run_dir/override-events.log"
[[ $(wc -l < "$run_dir/override-events.log") -eq 4 ]] || exit 72
[[ $(grep -Fc 'draft=471 replacement=90563 margin=0.0684490204' "$run_dir/override-events.log") -eq 4 ]] || exit 72
[[ -z $(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true) ]] || exit 73

target_tps=$(jq -s '[.[].summary.aggregate_request_tokens_per_second]' "$run_dir/target-r1.json" "$run_dir/target-r2.json" "$run_dir/target-r3.json")
corrected_tps=$(jq -s '[.[].summary.aggregate_request_tokens_per_second]' "$run_dir/corrected_q4_n1-r1.json" "$run_dir/corrected_q4_n1-r2.json" "$run_dir/corrected_q4_n1-r3.json")

jq -n --arg status completed_corrected_speed_gate \
    --argjson target_tps "$target_tps" --argjson corrected_tps "$corrected_tps" \
    --argjson q4_warmup "$(jq -c '.summary' "$run_dir/corrected_q4_n1-warmup.json")" \
    --argjson target_warmup "$(jq -c '.summary' "$run_dir/target-warmup.json")" \
    --arg override_sha "$(sha256sum "$run_dir/override-events.log" | awk '{print $1}')" '
    def mean: add / length;
    def sample_sd:
        (mean) as $m | if length < 2 then 0 else
            (map((. - $m) * (. - $m)) | add / (length - 1) | sqrt)
        end;
    ($target_tps | mean) as $target_mean |
    ($corrected_tps | mean) as $corrected_mean |
    {
        status: $status,
        evidence_class: "matched six-public-prompt cache-off output-hash and timing gate",
        target_only: {warmup:$target_warmup,timed_tps:$target_tps,mean_tps:$target_mean,sd_tps:($target_tps|sample_sd)},
        corrected_q4_n1: {warmup:$q4_warmup,timed_tps:$corrected_tps,mean_tps:$corrected_mean,sd_tps:($corrected_tps|sample_sd),accepted:103,proposed:118,override_events:4},
        speedup_percent:(($corrected_mean / $target_mean - 1) * 100),
        all_runs_match_six_target_output_hashes:true,
        completion_tokens_per_run:227,
        override_log_sha256:$override_sha,
        promotion_gate_percent:5,
        promotion_gate_passed:(($corrected_mean / $target_mean - 1) * 100 >= 5),
        heldout_used:false,
        claim_boundary:"local public-validation result for this exact tuple; not a general exactness or speed guarantee"
    }
' > "$run_dir/summary.json"
jq -e '.promotion_gate_passed == true' "$run_dir/summary.json" >/dev/null

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    nvidia-smi --query-gpu=name,memory.used,utilization.gpu,temperature.gpu --format=csv,noheader
    ps -eo pid,comm,args | grep -E 'llama-server|benchmark_client_v21.py' | grep -v grep || true
    df -B1 /workspace /dev/shm
} > "$run_dir/cleanup.txt"
sha256sum "$run_dir"/* > "$run_dir/SHA256SUMS.txt"
