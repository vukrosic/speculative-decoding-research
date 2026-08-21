"""Create an additive three-layer SmolLM DFlash2 bridge initialization."""

from __future__ import annotations

import argparse
import json
import shutil
from dataclasses import replace
from datetime import UTC, datetime
from pathlib import Path

from dflash2_adapter.official_bridge import OfficialSmolLMDFlash2Bridge


EXPECTED_PARAMETERS = 13_738_944


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if args.output.exists():
        raise FileExistsError(f"refusing to overwrite {args.output}")
    working = args.output.with_name(args.output.name + ".building")
    if working.exists():
        raise FileExistsError(f"stale working directory exists: {working}")
    try:
        source = OfficialSmolLMDFlash2Bridge.from_pretrained(
            args.source, device="cpu"
        )
        source_config = source.bridge_config
        if source_config.num_draft_layers != 2 or source_config.block_size != 4:
            raise ValueError("source must be the frozen 2-layer block-3 checkpoint")
        expanded = OfficialSmolLMDFlash2Bridge(
            replace(source_config, num_draft_layers=3)
        )
        source_state = source.state_dict()
        expanded_state = expanded.state_dict()
        copied_shared = 0
        copied_endpoint = 0
        for name, tensor in source_state.items():
            if name.startswith("draft.layers."):
                continue
            if name not in expanded_state or expanded_state[name].shape != tensor.shape:
                raise RuntimeError(f"shared tensor mismatch: {name}")
            expanded_state[name].copy_(tensor)
            copied_shared += tensor.numel()

        for source_layer, destination_layer in {0: 0, 1: 2}.items():
            source_prefix = f"draft.layers.{source_layer}."
            destination_prefix = f"draft.layers.{destination_layer}."
            for name, tensor in source_state.items():
                if not name.startswith(source_prefix):
                    continue
                destination_name = destination_prefix + name[len(source_prefix) :]
                if expanded_state[destination_name].shape != tensor.shape:
                    raise RuntimeError(f"layer tensor mismatch: {name}")
                expanded_state[destination_name].copy_(tensor)
                copied_endpoint += tensor.numel()

        expanded_state["draft.layers.1.self_attn.o_proj.weight"].zero_()
        expanded_state["draft.layers.1.mlp.down_proj.weight"].zero_()
        expanded.load_state_dict(expanded_state, strict=True)
        report = expanded.parameter_report()
        if report["parameters_total"] != EXPECTED_PARAMETERS:
            raise RuntimeError(f"unexpected 3-layer parameter count: {report}")
        expanded.save_pretrained(working)
        receipt = {
            "status": "complete",
            "created_at_utc": datetime.now(UTC).isoformat(),
            "source_checkpoint": str(args.source.resolve()),
            "source_layers": 2,
            "expanded_layers": 3,
            "block_size": source_config.block_size,
            "speculative_tokens": source_config.speculative_tokens,
            "parameter_report": report,
            "capacity_change_only": "num_draft_layers: 2 -> 3",
            "shared_parameters_copied": copied_shared,
            "endpoint_layer_parameters_copied": copied_endpoint,
            "inserted_layers": [1],
            "inserted_layer_initialization": (
                "zero residual branch outputs; exact identity at initialization"
            ),
            "test_sealed": True,
        }
        with (working / "capacity3_initialization_receipt.json").open(
            "w", encoding="utf-8"
        ) as handle:
            json.dump(receipt, handle, indent=2, sort_keys=True)
            handle.write("\n")
        working.rename(args.output)
        print(json.dumps(receipt, indent=2, sort_keys=True), flush=True)
    except Exception:
        shutil.rmtree(working, ignore_errors=True)
        raise


if __name__ == "__main__":
    main()
