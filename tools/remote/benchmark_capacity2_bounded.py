"""Bounded timing for the SmolLM one-layer versus two-layer comparison."""

from __future__ import annotations

import argparse
import json
from datetime import UTC, datetime
from pathlib import Path

import torch

from dflash2_adapter.benchmark_capacity5layer_bounded import (
    _load_prefixes,
    read_json,
    run_model,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--trajectories", type=Path, required=True)
    parser.add_argument("--target-snapshot", type=Path, required=True)
    parser.add_argument("--acceptance-receipt", type=Path, required=True)
    parser.add_argument("--one-layer-checkpoint", type=Path, required=True)
    parser.add_argument("--two-layer-checkpoint", type=Path, required=True)
    parser.add_argument("--one-layer-metrics", type=Path, required=True)
    parser.add_argument("--two-layer-metrics", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--repetitions", type=int, default=2)
    parser.add_argument("--max-new-tokens", type=int, default=32)
    parser.add_argument("--seed", type=int, default=20_260_819)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if args.output.exists():
        raise FileExistsError(f"refusing to overwrite {args.output}")
    if args.repetitions != 2 or args.max_new_tokens != 32:
        raise ValueError("bounded comparison freezes repetitions=2 and max_new_tokens=32")
    if not torch.cuda.is_available():
        raise RuntimeError("CUDA is required")

    device = torch.device("cuda")
    acceptance = read_json(args.acceptance_receipt)
    one_metrics = read_json(args.one_layer_metrics)
    two_metrics = read_json(args.two_layer_metrics)
    prefixes = _load_prefixes(args.trajectories, 30, args.seed)
    frozen_runs = acceptance["runs"]["baseline"]
    references = {
        int(run["trajectory_index"]): run["reference_token_ids"]
        for run in frozen_runs
    }
    if [int(prefix["trajectory_index"]) for prefix in prefixes] != [
        int(run["trajectory_index"]) for run in frozen_runs
    ]:
        raise RuntimeError("timing prompt order differs from frozen acceptance receipt")

    one_layer = run_model(
        "one_layer_6520256",
        args.one_layer_checkpoint,
        one_metrics,
        prefixes,
        references,
        args.target_snapshot,
        repetitions=args.repetitions,
        max_new_tokens=args.max_new_tokens,
        device=device,
    )
    two_layer = run_model(
        "two_layer_10129600",
        args.two_layer_checkpoint,
        two_metrics,
        prefixes,
        references,
        args.target_snapshot,
        repetitions=args.repetitions,
        max_new_tokens=args.max_new_tokens,
        device=device,
    )
    one_speed = one_layer["tokens_per_second"]
    two_speed = two_layer["tokens_per_second"]
    one_acceptance = one_layer["acceptance"]["draft_token_acceptance_rate"]
    two_acceptance = two_layer["acceptance"]["draft_token_acceptance_rate"]
    report = {
        "status": "complete",
        "created_at_utc": datetime.now(UTC).isoformat(),
        "target_snapshot": str(args.target_snapshot.resolve()),
        "acceptance_receipt": str(args.acceptance_receipt.resolve()),
        "evaluation": {
            "prompts": len(prefixes),
            "prompt_order_frozen": True,
            "repetitions": args.repetitions,
            "max_new_tokens": args.max_new_tokens,
            "seed": args.seed,
            "exact_guard_enabled": True,
            "target_reference": "frozen target-only outputs in acceptance receipt",
            "heldout_data_used": False,
        },
        "one_layer": one_layer,
        "two_layer": two_layer,
        "comparison": {
            "acceptance_absolute_change": two_acceptance - one_acceptance,
            "acceptance_relative_factor": two_acceptance / one_acceptance,
            "tokens_per_second_absolute_change": two_speed - one_speed,
            "tokens_per_second_relative_factor": two_speed / one_speed,
            "tokens_per_second_relative_change": two_speed / one_speed - 1.0,
            "speed_claim_allowed": one_layer["all_exact"] and two_layer["all_exact"],
        },
        "runtime": {
            "device": "cuda",
            "gpu_name": torch.cuda.get_device_name(device),
            "torch": torch.__version__,
            "torch_cuda": torch.version.cuda,
            "peak_vram_bytes": max(
                one_layer["peak_vram_bytes"], two_layer["peak_vram_bytes"]
            ),
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("x", encoding="utf-8") as handle:
        json.dump(report, handle, indent=2, sort_keys=True)
        handle.write("\n")
    print(json.dumps(report["comparison"], indent=2, sort_keys=True), flush=True)


if __name__ == "__main__":
    main()
