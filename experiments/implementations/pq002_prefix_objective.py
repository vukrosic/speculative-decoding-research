"""Objective-only PQ-002 prefix-survival loss.

This module is an additive implementation of the frozen mathematical policy in
``experiments/planning/PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md``.  It
expects already-frozen logits, successor labels, and valid-position masks from
the existing trainer.  It does not create data, alter model architecture,
change optimizer/runtime/evaluator behavior, or access held-out examples.
"""

from __future__ import annotations

import math
from typing import Any, Iterable, Mapping


ALPHA = 0.02
LAMBDA = 1.0
LOG_EPSILON = math.log(1.0e-8)


def _torch() -> Any:
    """Import torch lazily so source inspection works without a GPU runtime."""

    try:
        import torch  # type: ignore
    except ImportError as exc:  # pragma: no cover - exercised on non-training hosts
        raise RuntimeError("PQ-002 implementation requires the pinned torch runtime") from exc
    return torch


def _finite(torch: Any, value: Any, name: str) -> None:
    if not bool(torch.isfinite(value).all().item()):
        raise FloatingPointError(f"non-finite PQ-002 value: {name}")


def prefix_survival_loss(
    logits: Any,
    labels: Any,
    mask: Any,
    *,
    alpha: float = ALPHA,
    lam: float = LAMBDA,
    log_epsilon: float = LOG_EPSILON,
) -> Mapping[str, Any]:
    """Return the frozen CE + cumulative-log prefix objective.

    ``logits`` has shape ``[batch, positions, vocabulary]``.  ``labels`` and
    ``mask`` have shape ``[batch, positions]``.  The caller supplies the
    manifest's EOS-aware mask: EOS is active and all later positions are zero.
    Every reduction is FP32; gradients remain connected to the input logits.
    """

    torch = _torch()
    if logits.ndim != 3 or labels.ndim != 2 or mask.ndim != 2:
        raise ValueError("PQ-002 expects logits[B,T,V], labels[B,T], mask[B,T]")
    if logits.shape[:2] != labels.shape or labels.shape != mask.shape:
        raise ValueError("PQ-002 tensor shapes do not agree")

    logits32 = logits.float()
    labels = labels.to(dtype=torch.long)
    mask_f = mask.to(dtype=torch.float32)
    if bool((labels < 0).any().item()) or bool((labels >= logits32.shape[-1]).any().item()):
        raise ValueError("PQ-002 label is outside the logits vocabulary")
    if bool((mask_f < 0).any().item()) or bool((mask_f > 1).any().item()):
        raise ValueError("PQ-002 mask must contain only zero or one")

    _finite(torch, logits32, "logits")
    ell = torch.log_softmax(logits32, dim=-1)
    _finite(torch, ell, "log_softmax")

    true_ell = ell.gather(dim=-1, index=labels.unsqueeze(-1)).squeeze(-1)
    _finite(torch, true_ell, "true_log_probability")

    # The smoothed CE is evaluated from log probabilities without materializing
    # a vocabulary-sized target distribution.
    hard_ce = -true_ell
    uniform_ce = -ell.mean(dim=-1)
    ce_per_position = (1.0 - alpha) * hard_ce + alpha * uniform_ce

    positions = torch.arange(
        1, logits32.shape[1] + 1, device=logits32.device, dtype=torch.float32
    ).view(1, -1)
    position_weights = mask_f / positions
    normalizer = position_weights.sum(dim=-1)
    active_count = mask_f.sum(dim=-1)
    if bool((normalizer <= 0).any().item()) or bool((active_count <= 0).any().item()):
        raise ValueError("PQ-002 encountered a window with no active positions")

    ce = (position_weights * ce_per_position).sum(dim=-1) / normalizer

    # Prefix survival stays in log space.  The clamp is applied only to the
    # selected true-label log probability, exactly as frozen in the manifest.
    r = torch.clamp(true_ell, min=float(log_epsilon))
    cumulative_log_survival = torch.cumsum(mask_f * r, dim=-1)
    prefix = (mask_f * (-cumulative_log_survival)).sum(dim=-1) / active_count
    total_per_window = ce + float(lam) * prefix
    loss = total_per_window.mean()

    for name, value in (
        ("r", r),
        ("cumulative_log_survival", cumulative_log_survival),
        ("L_ce", ce),
        ("L_prefix", prefix),
        ("L_new", total_per_window),
        ("loss", loss),
    ):
        _finite(torch, value, name)

    return {
        "loss": loss,
        "L_ce": ce,
        "L_prefix": prefix,
        "L_new": total_per_window,
        "true_log_probability": true_ell,
        "clamped_true_log_probability": r,
        "cumulative_log_survival": cumulative_log_survival,
        "active_count": active_count,
    }


def assert_finite_nonzero_gradients(parameters: Iterable[Any]) -> None:
    """Enforce the post-backward finite/nonzero-gradient fit gate."""

    torch = _torch()
    saw_gradient = False
    saw_nonzero = False
    for parameter in parameters:
        gradient = getattr(parameter, "grad", None)
        if gradient is None:
            continue
        saw_gradient = True
        _finite(torch, gradient, "parameter_gradient")
        saw_nonzero = saw_nonzero or bool((gradient != 0).any().item())
    if not saw_gradient or not saw_nonzero:
        raise FloatingPointError("PQ-002 gradient gate found no finite nonzero gradient")


__all__ = [
    "ALPHA",
    "LAMBDA",
    "LOG_EPSILON",
    "assert_finite_nonzero_gradients",
    "prefix_survival_loss",
]
