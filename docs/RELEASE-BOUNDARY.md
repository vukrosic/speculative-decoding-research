# Public release boundary

The repository contains both a public research kit and an internal lab record.
The public surface should be understandable without access to a private GPU
host or local filesystem.

## Safe public surface

Publish the root README, its `assets/speculative-decoding-hero.png` visual,
`QUICKSTART.md`, `examples/`, `methods/`, public paper and literature notes,
sanitized result summaries, templates, and the methodology documentation.
Keep model/data artifacts external and provide generic reproduction
instructions.

## Internal-only material

Before publishing the full archive, review or exclude:

- `governance/` and `daily/` operational records;
- raw receipts and logs that contain private host details;
- experiment cards with SSH commands or private runtime paths;
- `docs/REPOSITORY-LOCATIONS.md`;
- any file containing usernames, IP addresses, access ports, tokens, or local
  absolute paths.

The scientific result itself should remain publishable after those operational
details are removed: retain the model/runtime version, artifact hashes,
metrics, scope, limitations, and a generic reproduction recipe.

## Release checklist

- [ ] Replace private paths and hostnames with placeholders.
- [ ] Confirm no credentials or access tokens are present.
- [ ] Add or verify a license and citation file.
- [ ] Run the toy example from a clean checkout.
- [ ] Run `tools/check-repo.sh`.
- [ ] Re-read every headline result and confirm its receipt and evidence scope.
