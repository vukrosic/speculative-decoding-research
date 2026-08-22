#!/usr/bin/env bash
set -Eeuo pipefail

run_dir=${1:-}
case "$run_dir" in
    /dev/shm/pq020-sampler-margin-*) ;;
    *) echo "usage: $0 /dev/shm/pq020-sampler-margin-<run-id>" >&2; exit 64 ;;
esac

workspace=/workspace/smollm-eagle3-prototype
runtime_task=$workspace/experiments/pq020-instrumented-runtime-20260822T0546Z
bin_dir=$runtime_task/build/bin
server=$bin_dir/llama-server
target=$workspace/experiments/qwen38-27b-iq1s-spec-v20-20260820/models/unsloth-qwen38-27b-4ca72078/Qwen3.8-27B-UD-IQ1_S.gguf
draft=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/models/Qwen3.8-27B-DFlash2-Q4_K_M.gguf
client=$workspace/experiments/qwen38-27b-iq1s-dflash2-v21-20260820/scripts/benchmark_client_v21.py
prompt=$run_dir/source-prompts-v20.jsonl
contract=$run_dir/benchmark-contract-six-prompt-raw-margin-r1.json
port=8104

server_sha=fcbf4b9d5847f19ad2391af0109b3d0d067de19d0448bb96acc1a1011af20d41
common_sha=1bbaf7b59c8572b490db0522684139eaf9c1e4722dcc5e3876cc44c350b34009
server_impl_sha=fd5a9bf6ac5237f0c8821bc66a75e81c7c1b1a24b4ac487a496d4fbe4386a066
sampling_sha=66b7975d081cbd561327d331b805dc47af39d6de5216c3aa0da2e985742e05fd
target_sha=3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887
draft_sha=18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594
client_sha=477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4
prompt_sha=77a9b5703756102bc088891419a6b85f45bd6a26118c4daded334dec91db8514
contract_sha=49de56c5e4249962753507fd2568e01502fc88cf7fce5e5371ca3c4aeea27d6b

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

[[ -d "$run_dir" ]] || exit 66
assert_sha "$server" "$server_sha"
assert_sha "$bin_dir/libllama-common.so.0.1.2" "$common_sha"
assert_sha "$bin_dir/libllama-server-impl.so" "$server_impl_sha"
assert_sha "$runtime_task/source/common/sampling.cpp" "$sampling_sha"
assert_sha "$target" "$target_sha"
assert_sha "$draft" "$draft_sha"
assert_sha "$client" "$client_sha"
assert_sha "$prompt" "$prompt_sha"
assert_sha "$contract" "$contract_sha"

[[ $(wc -l < "$prompt") -eq 6 ]] || exit 67
mapfile -t prompt_ids < <(jq -r '.id' "$prompt")
expected_ids=(code_python_debug code_rust_parser math_modular logic_schedule technical_explain structured_extract)
[[ "${prompt_ids[*]}" == "${expected_ids[*]}" ]] || exit 67
if pgrep -x llama-server >/dev/null 2>&1 || pgrep -f '[b]enchmark_client_v21.py' >/dev/null 2>&1; then
    exit 68
fi
[[ -z $(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true) ]] || exit 69

argv=(
    "$server" -m "$target"
    --host 127.0.0.1 --port "$port"
    --ctx-size 4096 --parallel 1 --n-gpu-layers all
    --no-context-shift --no-cache-prompt --reasoning off --metrics --perf
    --log-verbosity 5 --log-colors off --log-prefix --log-timestamps
    -md "$draft" --spec-type draft-dflash --spec-draft-n-max 1 --spec-draft-ngl all
)

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    hostname
    nvidia-smi --query-gpu=name,memory.total,memory.used,utilization.gpu,temperature.gpu,driver_version --format=csv,noheader
    df -B1 /workspace /dev/shm
    sha256sum "$server" "$bin_dir/libllama-common.so.0.1.2" "$bin_dir/libllama-server-impl.so" \
        "$runtime_task/source/common/sampling.cpp" "$target" "$draft" "$client" "$prompt" "$contract"
    printf 'env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1 PQ020_TRACE=1 LD_LIBRARY_PATH=%q' "$bin_dir"
    printf ' %q' "${argv[@]}"
    printf '\n'
} > "$run_dir/preflight-and-command.txt"

(
    cd "$workspace"
    exec env CUDA_VISIBLE_DEVICES=0 LLAMA_TRACE=1 PQ020_TRACE=1 LD_LIBRARY_PATH="$bin_dir" "${argv[@]}"
) > "$run_dir/q4-server.log" 2>&1 &
child_pid=$!

healthy=0
for _ in {1..240}; do
    if curl -fsS "http://127.0.0.1:$port/health" >/dev/null 2>&1; then healthy=1; break; fi
    kill -0 "$child_pid" 2>/dev/null || break
    sleep 0.5
done
[[ "$healthy" -eq 1 ]] || { tail -100 "$run_dir/q4-server.log" >&2 || true; exit 70; }

(
    cd "$workspace"
    /usr/bin/python3 "$client" --mode dflash2 --base-url "http://127.0.0.1:$port" \
        --contract "$contract" --prompts "$prompt" --output "$run_dir/q4-client.json" \
        --repetition 1 --wait-seconds 300
) > "$run_dir/q4-client.log" 2>&1

cleanup
sleep 2

jq -e --arg p "$prompt_sha" --arg c "$contract_sha" '
    .prompt_manifest_sha256 == $p and .contract_sha256 == $c and
    .summary.requests == 6 and .summary.completion_tokens == 227 and
    (.runs | length) == 6 and
    ([.runs[] | select(.prompt_id == "code_python_debug" and .assistant_message_sha256 == "1d5020bfedee4bbc2c878d7d3805bf76ccd2e85dfc90817c4b3422af75122646" and .completion_tokens == 64 and .finish_reason == "length")] | length) == 1 and
    ([.runs[] | select(.prompt_id == "code_rust_parser" and .assistant_message_sha256 == "fdfb48a6f578bdd44760d881c8d96817c3e7965aee0a9c897eea4d22e21ba16d" and .completion_tokens == 64 and .finish_reason == "length")] | length) == 1 and
    ([.runs[] | select(.prompt_id == "math_modular" and .assistant_message_sha256 == "4798d4b5ad3fa59b7957a4f29e4358fae499eab7c3904109c8cc0734a9814190" and .completion_tokens == 1 and .finish_reason == "stop")] | length) == 1 and
    ([.runs[] | select(.prompt_id == "logic_schedule" and .assistant_message_sha256 == "820f59857a44016e4d87c883bf94005743882576b0273087dbaf29a0d258b2b1" and .completion_tokens == 64 and .finish_reason == "length")] | length) == 1 and
    ([.runs[] | select(.prompt_id == "technical_explain" and .assistant_message_sha256 == "4798d4b5ad3fa59b7957a4f29e4358fae499eab7c3904109c8cc0734a9814190" and .completion_tokens == 1 and .finish_reason == "stop")] | length) == 1 and
    ([.runs[] | select(.prompt_id == "structured_extract" and .assistant_message_sha256 == "9fbd13bad069245acc783e0fcca69b534ced18a30ab4c56e8e1546da52c6e699" and .completion_tokens == 33 and .finish_reason == "stop")] | length) == 1
' "$run_dir/q4-client.json" >/dev/null

grep -F 'PQ020_SAMPLER_ROW ' "$run_dir/q4-server.log" > "$run_dir/sampler-margin.log"
[[ $(wc -l < "$run_dir/sampler-margin.log") -gt 0 ]] || exit 71
grep -F 'PQ020_RAW_LOGITS ' "$run_dir/q4-server.log" > "$run_dir/raw-logits.log"
[[ $(wc -l < "$run_dir/raw-logits.log") -gt 0 ]] || exit 71
[[ -z $(nvidia-smi --query-compute-apps=pid --format=csv,noheader,nounits 2>/dev/null | sed '/^[[:space:]]*$/d' || true) ]] || exit 72

jq -n \
    --arg status completed_sampler_margin_trace \
    --argjson outputs "$(jq -c '[.runs[] | {prompt_id,assistant_message_sha256,completion_tokens,finish_reason}]' "$run_dir/q4-client.json")" \
    --argjson summary "$(jq -c '.summary' "$run_dir/q4-client.json")" \
    --arg server_log_sha "$(sha256sum "$run_dir/q4-server.log" | awk '{print $1}')" \
    --arg margin_log_sha "$(sha256sum "$run_dir/sampler-margin.log" | awk '{print $1}')" \
    --argjson margin_rows "$(wc -l < "$run_dir/sampler-margin.log")" \
    --arg raw_log_sha "$(sha256sum "$run_dir/raw-logits.log" | awk '{print $1}')" \
    --argjson raw_rows "$(wc -l < "$run_dir/raw-logits.log")" \
    '{status:$status,evidence_class:"six-public-prompt raw pre-chain sampler-margin diagnostic only",outputs:$outputs,summary:$summary,server_log_sha256:$server_log_sha,sampler_margin_log_sha256:$margin_log_sha,sampler_margin_rows:$margin_rows,raw_logits_log_sha256:$raw_log_sha,raw_logits_rows:$raw_rows,heldout_used:false}' \
    > "$run_dir/summary.json"

{
    date -u +%Y-%m-%dT%H:%M:%SZ
    nvidia-smi --query-gpu=name,memory.used,utilization.gpu,temperature.gpu --format=csv,noheader
    ps -eo pid,comm,args | grep -E 'llama-server|benchmark_client_v21.py' | grep -v grep || true
    df -B1 /workspace /dev/shm
} > "$run_dir/cleanup.txt"
sha256sum "$run_dir"/* > "$run_dir/SHA256SUMS.txt"
