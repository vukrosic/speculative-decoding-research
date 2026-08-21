#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

failed=0

if rg -n '125\.240\.239\.50|root@|/Users/[A-Za-z0-9._-]+|/workspace/' \
  README.md QUICKSTART.md examples methods docs/RELEASE-BOUNDARY.md \
  LICENSE CITATION.cff >/tmp/specdec-public-audit.$$ 2>/dev/null; then
  echo "ERROR private operational path or host found in the public surface:"
  cat /tmp/specdec-public-audit.$$
  failed=1
fi
rm -f /tmp/specdec-public-audit.$$

if rg -n 'NEEDS USER APPROVAL' README.md QUICKSTART.md examples methods docs/RELEASE-BOUNDARY.md 2>/dev/null; then
  echo "ERROR legacy approval wording found in the public surface"
  failed=1
fi

if [[ ! -s LICENSE || ! -s CITATION.cff || ! -s QUICKSTART.md ]]; then
  echo "ERROR public release is missing LICENSE, CITATION.cff, or QUICKSTART.md"
  failed=1
fi

if (( failed != 0 )); then
  exit 1
fi

echo "Public release checks passed."
