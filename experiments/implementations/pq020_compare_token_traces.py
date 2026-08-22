#!/usr/bin/env python3
"""Compare PQ020 target-only and instrumented Q4 token traces.

The script is deliberately log-only: it does not load a model, invoke a
runtime, or infer missing verifier state.  It binds emitted tokens to the
instrumented verifier cycle that produced them and writes one deterministic
JSON receipt.
"""

from __future__ import annotations

import argparse
import collections
import hashlib
import json
import re
from pathlib import Path
from typing import Any


NEXT_TOKEN_RE = re.compile(r"next token:\s+(-?\d+)(?:\s+'(.*))?$")
MARKER_RE = re.compile(r"PQ020_([A-Z_]+)(?:\s+(.*))?$")
KEY_VALUE_RE = re.compile(r"([A-Za-z_][A-Za-z0-9_]*)=(-?\d+|[^\s]+)")


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def parse_key_values(payload: str) -> dict[str, Any]:
    result: dict[str, Any] = {}
    for key, raw_value in KEY_VALUE_RE.findall(payload):
        try:
            result[key] = int(raw_value)
        except ValueError:
            result[key] = raw_value
    return result


def parse_target(path: Path) -> list[dict[str, Any]]:
    tokens: list[dict[str, Any]] = []
    for line_number, line in enumerate(path.read_text(errors="replace").splitlines(), 1):
        match = NEXT_TOKEN_RE.search(line)
        if not match:
            continue
        piece_tail = match.group(2)
        tokens.append(
            {
                "index_zero_based": len(tokens),
                "index_one_based": len(tokens) + 1,
                "token": int(match.group(1)),
                "piece_log_tail": piece_tail,
                "line": line_number,
            }
        )
    return tokens


def parse_q4(path: Path) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    cycles: list[dict[str, Any]] = []
    emitted: list[dict[str, Any]] = []
    pending: collections.deque[dict[str, Any]] = collections.deque()
    current: dict[str, Any] | None = None

    for line_number, line in enumerate(path.read_text(errors="replace").splitlines(), 1):
        marker_match = MARKER_RE.search(line)
        if marker_match:
            marker = marker_match.group(1)
            values = parse_key_values(marker_match.group(2) or "")
            if marker == "VERIFY_BATCH_BEGIN":
                current = {
                    "cycle_one_based": len(cycles) + 1,
                    "batch_begin": values,
                    "batch_rows": [],
                    "draft_vector": [],
                    "verify_rows": [],
                    "accepted_vector": [],
                    "line_begin": line_number,
                }
                cycles.append(current)
            elif current is not None:
                if marker == "VERIFY_BATCH_ROW":
                    current["batch_rows"].append(values)
                elif marker == "VERIFY_BEGIN":
                    current["verify_begin"] = values
                elif marker == "VERIFY_ROW":
                    current["verify_rows"].append(values)
                elif marker == "DRAFT_VECTOR":
                    current["draft_vector"].append(values)
                elif marker == "VERIFY_RESULT":
                    current["verify_result"] = values
                elif marker == "ACCEPTED_VECTOR":
                    accepted = {
                        **values,
                        "cycle_one_based": current["cycle_one_based"],
                        "marker_line": line_number,
                    }
                    current["accepted_vector"].append(accepted)
                    verify_result = current.get("verify_result", {})
                    # Full-context rollback records a provisional correction,
                    # restores the checkpoint, and verifies that correction in
                    # a replay cycle before emitting anything. Do not bind the
                    # provisional marker to the later replay output.
                    if not (
                        verify_result.get("use_ckpt") == 1
                        and verify_result.get("n_rollback", 0) > 0
                    ):
                        pending.append(accepted)
                elif marker == "MEMORY_AFTER":
                    current["memory_after"] = values

        next_match = NEXT_TOKEN_RE.search(line)
        if not next_match:
            continue
        token = int(next_match.group(1))
        piece_tail = next_match.group(2)
        if pending:
            source = pending.popleft()
            if source.get("token") != token:
                raise RuntimeError(
                    "accepted-vector/output mismatch at line "
                    f"{line_number}: marker={source.get('token')} emitted={token}"
                )
            source_role = source.get("role")
            cycle_one_based = source.get("cycle_one_based")
            source_marker_line = source.get("marker_line")
        else:
            source_role = "initial_target_sample"
            cycle_one_based = None
            source_marker_line = None
        emitted.append(
            {
                "index_zero_based": len(emitted),
                "index_one_based": len(emitted) + 1,
                "token": token,
                "piece_log_tail": piece_tail,
                "line": line_number,
                "source_role": source_role,
                "cycle_one_based": cycle_one_based,
                "source_marker_line": source_marker_line,
            }
        )

    if pending:
        raise RuntimeError(f"{len(pending)} accepted-vector entries were never emitted")
    return emitted, cycles


def compact_cycle(cycle: dict[str, Any]) -> dict[str, Any]:
    batch_rows = cycle.get("batch_rows", [])
    sampled_rows = [row for row in batch_rows if row.get("role") == "sampled"]
    draft_rows = [row for row in batch_rows if row.get("role") == "draft"]
    result = cycle.get("verify_result", {})
    accepted = cycle.get("accepted_vector", [])
    return {
        "cycle_one_based": cycle["cycle_one_based"],
        "sampled_token": sampled_rows[0].get("token") if sampled_rows else None,
        "sampled_position": sampled_rows[0].get("pos") if sampled_rows else None,
        "draft_tokens": [row.get("token") for row in draft_rows],
        "draft_positions": [row.get("pos") for row in draft_rows],
        "accepted_size": result.get("accepted_size"),
        "accepted_draft": result.get("accepted_draft"),
        "n_rollback": result.get("n_rollback"),
        "can_rollback": result.get("can_rollback"),
        "use_ckpt": result.get("use_ckpt"),
        "accepted_vector": [
            {"ord": row.get("ord"), "role": row.get("role"), "token": row.get("token")}
            for row in accepted
        ],
        "correction_token": next(
            (row.get("token") for row in accepted if row.get("role") == "correction"), None
        ),
        "verify_begin": cycle.get("verify_begin"),
        "memory_after": cycle.get("memory_after"),
        "line_begin": cycle.get("line_begin"),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--target-log", type=Path, required=True)
    parser.add_argument("--q4-log", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--expected-tokens", type=int, default=64)
    args = parser.parse_args()

    target = parse_target(args.target_log)
    q4, cycles_raw = parse_q4(args.q4_log)
    if len(target) != args.expected_tokens or len(q4) != args.expected_tokens:
        raise RuntimeError(
            f"unexpected token counts target={len(target)} q4={len(q4)} "
            f"expected={args.expected_tokens}"
        )

    target_ids = [row["token"] for row in target]
    q4_ids = [row["token"] for row in q4]
    differences = [index for index, pair in enumerate(zip(target_ids, q4_ids)) if pair[0] != pair[1]]
    first_difference = differences[0] if differences else None
    cycles = [compact_cycle(cycle) for cycle in cycles_raw]
    cycle_by_id = {cycle["cycle_one_based"]: cycle for cycle in cycles}
    rejection_cycles = [cycle for cycle in cycles if cycle.get("accepted_draft") == 0]

    divergence: dict[str, Any] | None = None
    context: list[dict[str, Any]] = []
    if first_difference is not None:
        target_row = target[first_difference]
        q4_row = q4[first_difference]
        cycle = cycle_by_id.get(q4_row.get("cycle_one_based"))
        divergence = {
            "index_zero_based": first_difference,
            "index_one_based": first_difference + 1,
            "target": target_row,
            "q4": q4_row,
            "q4_cycle": cycle,
            "target_token_matches_q4_sampled": bool(
                cycle and target_row["token"] == cycle.get("sampled_token")
            ),
            "target_token_matches_q4_draft": bool(
                cycle and target_row["token"] in cycle.get("draft_tokens", [])
            ),
            "target_token_matches_q4_correction": bool(
                cycle and target_row["token"] == cycle.get("correction_token")
            ),
        }
        start = max(0, first_difference - 5)
        stop = min(len(target), first_difference + 6)
        for index in range(start, stop):
            context.append(
                {
                    "index_zero_based": index,
                    "index_one_based": index + 1,
                    "target_token": target[index]["token"],
                    "target_piece_log_tail": target[index].get("piece_log_tail"),
                    "q4_token": q4[index]["token"],
                    "q4_piece_log_tail": q4[index].get("piece_log_tail"),
                    "equal": target[index]["token"] == q4[index]["token"],
                    "q4_source_role": q4[index].get("source_role"),
                    "q4_cycle_one_based": q4[index].get("cycle_one_based"),
                }
            )

    output = {
        "schema": "pq020-token-divergence-analysis-v1",
        "scope": "log_only_no_model_no_runtime",
        "inputs": {
            "target_log": str(args.target_log.resolve()),
            "target_log_sha256": sha256_file(args.target_log),
            "q4_log": str(args.q4_log.resolve()),
            "q4_log_sha256": sha256_file(args.q4_log),
        },
        "counts": {
            "target_tokens": len(target),
            "q4_tokens": len(q4),
            "q4_cycles": len(cycles),
            "q4_rejection_cycles": len(rejection_cycles),
            "different_same_index_tokens": len(differences),
            "common_prefix_tokens": first_difference if first_difference is not None else len(target),
        },
        "target_token_ids": target_ids,
        "q4_token_ids": q4_ids,
        "first_divergence": divergence,
        "divergence_context": context,
        "difference_indices_zero_based": differences,
        "rejection_cycles": rejection_cycles,
        "all_cycles": cycles,
        "assertions": {
            "expected_token_count_passed": len(target) == len(q4) == args.expected_tokens,
            "accepted_vectors_map_exactly_to_emitted_q4_tokens": True,
            "instrumented_cycle_count_is_35": len(cycles) == 35,
            "instrumented_rejection_count_is_7": len(rejection_cycles) == 7,
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    if args.output.exists():
        raise FileExistsError(f"refusing to overwrite {args.output}")
    args.output.write_text(json.dumps(output, indent=2, sort_keys=True) + "\n")
    print(json.dumps({"output": str(args.output), "counts": output["counts"], "first": divergence}, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
