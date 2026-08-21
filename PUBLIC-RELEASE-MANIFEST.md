# Public release manifest

This file defines the first public release surface without deleting the richer
internal lab archive.

## Include

- `README.md`, `QUICKSTART.md`, `LICENSE`, `CITATION.cff`, and the README
  visual asset at `assets/speculative-decoding-hero.png`;
- `examples/`, `methods/`, `templates/`;
- sanitized `docs/`, `papers/`, `literature/`, `models/`, `drafters/`,
  `runtimes/`, `hardware/`, `results/`, `failures/`, and `open-questions/`;
- selected experiment summaries and small receipts after the privacy audit;
- `CONTRIBUTING.md`, `AGENTS.md`, and the public check scripts.

## Review or exclude before publishing

- `governance/` and `daily/` internal coordination records;
- raw `receipts/` and logs with machine-specific paths or operational details;
- experiment cards containing private SSH commands or host information;
- `docs/REPOSITORY-LOCATIONS.md` and any unredacted remote setup note;
- model, dataset, checkpoint, feature, environment, and profiler artifacts.

The excluded material remains useful locally. It is not required for the
public toy example or for understanding the scientific conclusions.

Run:

```bash
tools/check-public-release.sh
tools/check-repo.sh
```

before creating a public tag. The release is not a claim that every historical
experiment is independently reproducible; each result retains its own scope,
limitations, and receipt status.
