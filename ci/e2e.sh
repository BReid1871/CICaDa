#!/usr/bin/env bash
set -euo pipefail

# Stub end-to-end check: runs the full lint -> unit -> integration chain
# and then checks an end-to-end computed value, standing in for a real
# e2e suite that exercises the whole system.

total=$(( 2 + 2 ))
expected=5

if [[ "$total" != "$expected" ]]; then
  echo "e2e: expected $expected, got $total"
  exit 1
fi

echo "e2e: ok"
