"""Deterministic synthetic gate for the PQ-002 objective artifact.

This is a CPU/GPU-neutral correctness smoke test. It never loads a model,
opens data, touches a remote host, or accesses held-out examples.
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path

import torch

from pq002_prefix_objective import prefix_survival_loss


ROOT = Path(__file__).resolve().parent
SOURCE = ROOT / "PQ-20260821-002-prefix-objective.py"


def main() -> None:
    source_text = SOURCE.read_text(encoding="utf-8")
    assert "torch.exp" not in source_text
    assert "probability_product" not in source_text

    torch.manual_seed(42)
    labels = torch.tensor([[2, 3, 4, 5], [6, 7, 8, 9]], dtype=torch.long)
    # EOS is represented by an active position; later positions are inactive.
    mask = torch.tensor([[1, 1, 0, 0], [1, 1, 1, 0]], dtype=torch.float32)
    logits = torch.randn(2, 4, 11, dtype=torch.float32, requires_grad=True)

    first = prefix_survival_loss(logits, labels, mask)
    first["loss"].backward()
    assert torch.isfinite(logits.grad).all().item()
    assert (logits.grad != 0).any().item()

    logits_repeat = logits.detach().clone().requires_grad_(True)
    second = prefix_survival_loss(logits_repeat, labels, mask)
    assert torch.equal(first["loss"].detach(), second["loss"].detach())

    masked_changed = logits.detach().clone()
    masked_changed[0, 2:, :] += 1000.0
    masked_changed[1, 3:, :] -= 1000.0
    masked_result = prefix_survival_loss(masked_changed, labels, mask)
    assert torch.allclose(first["loss"].detach(), masked_result["loss"].detach())

    try:
        prefix_survival_loss(logits.detach(), labels, torch.zeros_like(mask))
    except ValueError as exc:
        all_inactive_rejected = "no active positions" in str(exc)
    else:  # pragma: no cover - gate failure path
        all_inactive_rejected = False
    assert all_inactive_rejected

    result = {
        "status": "pass",
        "seed": 42,
        "device": str(logits.device),
        "dtype": str(logits.dtype),
        "finite_loss": bool(torch.isfinite(first["loss"]).item()),
        "finite_gradients": bool(torch.isfinite(logits.grad).all().item()),
        "nonzero_gradient": bool((logits.grad != 0).any().item()),
        "deterministic_repeat": True,
        "masked_positions_ignored": True,
        "eos_then_masked_positions": True,
        "all_inactive_rejected": all_inactive_rejected,
        "source_sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
    }
    print(json.dumps(result, sort_keys=True))


if __name__ == "__main__":
    main()
