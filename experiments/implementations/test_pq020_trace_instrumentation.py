#!/usr/bin/env python3
"""Static guard for the EXP-020 trace-only llama.cpp patch."""

from pathlib import Path


ROOT = Path(__file__).resolve().parent
PATCH = ROOT / "PQ-20260822-020-TRACE-INSTRUMENTATION.patch"


def main() -> None:
    text = PATCH.read_text(encoding="utf-8")
    required = (
        'std::getenv("PQ020_TRACE")',
        "PQ020_DRAFT seq=",
        "PQ020_VERIFY_BATCH_ROW",
        "PQ020_VERIFY_BEGIN",
        "PQ020_VERIFY_ROW",
        "PQ020_VERIFY_RESULT",
        "PQ020_ACCEPTED_VECTOR",
        "PQ020_MEMORY_AFTER",
    )
    for marker in required:
        assert marker in text, marker

    added = [line[1:] for line in text.splitlines() if line.startswith("+") and not line.startswith("+++")]
    removed = [line[1:] for line in text.splitlines() if line.startswith("-") and not line.startswith("---")]

    # Instrumentation may add includes, one env gate, local observations, and logs.
    # It must not remove or replace any decoding statement.
    assert not removed, removed
    forbidden_added = (
        "common_sampler_accept(",
        "common_sampler_sample_and_accept_n(",
        "llama_memory_seq_rm(",
        "slot.mem.seq_rm(",
        "common_speculative_accept(",
        "slot.sampled =",
        "slot.spec_draft =",
    )
    for fragment in forbidden_added:
        assert not any(fragment in line for line in added), fragment

    assert text.count("PQ020_TRACE") == 2
    print("PASS: EXP-020 patch is additive, env-gated trace instrumentation")


if __name__ == "__main__":
    main()
