#!/usr/bin/env python3
"""A dependency-free speculative-decoding control-flow example.

The target follows a deterministic transition rule. The drafter is mostly
right but intentionally makes some wrong proposals so rejection and correction
are visible. This is a teaching example, not a benchmark.
"""

from __future__ import annotations

import argparse
import json
from dataclasses import dataclass


def target_next(token: int, vocab_size: int) -> int:
    return (token + 1) % vocab_size


def drafter_next(token: int, vocab_size: int) -> int:
    # A deterministic, imperfect drafter: every third state proposes a jump.
    step = 2 if token % 3 == 0 else 1
    return (token + step) % vocab_size


@dataclass
class Trace:
    tokens: list[int]
    proposed: int = 0
    accepted: int = 0
    target_calls: int = 0
    rejection_positions: list[int] | None = None

    def __post_init__(self) -> None:
        if self.rejection_positions is None:
            self.rejection_positions = []


def speculative_decode(seed: int, steps: int, block_size: int, vocab_size: int) -> Trace:
    trace = Trace(tokens=[seed])
    while len(trace.tokens) - 1 < steps:
        block: list[int] = []
        state = trace.tokens[-1]
        for _ in range(min(block_size, steps - (len(trace.tokens) - 1))):
            proposal = drafter_next(state, vocab_size)
            block.append(proposal)
            state = proposal

        trace.proposed += len(block)
        trace.target_calls += 1
        state = trace.tokens[-1]
        for offset, proposal in enumerate(block):
            verified = target_next(state, vocab_size)
            if proposal == verified:
                trace.tokens.append(proposal)
                trace.accepted += 1
                state = proposal
                continue

            # Correction emits the target token at the first rejection and
            # discards the rest of the speculative block.
            trace.rejection_positions.append(len(trace.tokens) - 1 + offset)
            trace.tokens.append(verified)
            break
        else:
            continue
    return trace


def target_only(seed: int, steps: int, vocab_size: int) -> list[int]:
    output = [seed]
    for _ in range(steps):
        output.append(target_next(output[-1], vocab_size))
    return output


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--seed", type=int, default=1)
    parser.add_argument("--steps", type=int, default=24)
    parser.add_argument("--block-size", type=int, default=4)
    parser.add_argument("--vocab-size", type=int, default=11)
    args = parser.parse_args()
    if args.steps < 1 or args.block_size < 1 or args.vocab_size < 2:
        parser.error("steps and block-size must be positive; vocab-size must be at least 2")

    trace = speculative_decode(args.seed, args.steps, args.block_size, args.vocab_size)
    target = target_only(args.seed, args.steps, args.vocab_size)
    result = {
        "seed": args.seed,
        "steps": args.steps,
        "block_size": args.block_size,
        "vocab_size": args.vocab_size,
        "tokens": trace.tokens,
        "target_only_tokens": target,
        "target_equivalent": trace.tokens == target,
        "proposed_tokens": trace.proposed,
        "accepted_tokens": trace.accepted,
        "acceptance_rate": trace.accepted / trace.proposed if trace.proposed else 0.0,
        "target_verification_calls": trace.target_calls,
        "rejection_positions": trace.rejection_positions,
    }
    print(json.dumps(result, sort_keys=True))


if __name__ == "__main__":
    main()
