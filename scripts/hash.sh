#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

find . -type f \
  ! -path "./.git/*" \
  ! -name "CHECKSUMS.sha256" \
  -print0 | sort -z | xargs -0 sha256sum > CHECKSUMS.sha256

echo "Updated CHECKSUMS.sha256"
