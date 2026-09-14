#!/usr/bin/env bash
set -euo pipefail

# Stub lint check: fail if any tracked file has trailing whitespace.
cd "$(git rev-parse --show-toplevel)"

offenders=$(git grep -Il ' $' -- . ':!ci/*.sh' 2>/dev/null || true)

if [[ -n "$offenders" ]]; then
  echo "lint: trailing whitespace found in:"
  echo "$offenders"
  exit 1
fi

echo "lint: ok"
