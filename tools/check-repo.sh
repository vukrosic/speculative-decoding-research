#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

failed=0

while IFS= read -r -d '' file; do
  size=$(wc -c < "$file")
  if (( size > 1048576 )); then
    echo "ERROR file exceeds 1 MiB review threshold: $file ($size bytes)"
    failed=1
  fi
done < <(find . -path './.git' -prune -o -type f -print0)

for file in experiments/cards/*.md; do
  for heading in \
    '## Observed' \
    '## Interpretation / hypotheses' \
    '## Reproduction' \
    '## Artifacts and receipts'; do
    if ! grep -Fq "$heading" "$file"; then
      echo "ERROR missing '$heading': $file"
      failed=1
    fi
  done
done

for required in AGENTS.md README.md CURRENT-STATE.md results/INDEX.md \
  failures/INDEX.md open-questions/INDEX.md templates/experiment-card.md; do
  if [[ ! -s "$required" ]]; then
    echo "ERROR required file missing or empty: $required"
    failed=1
  fi
done

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git diff --check || failed=1
fi

if (( failed != 0 )); then
  exit 1
fi

echo "Repository checks passed."

