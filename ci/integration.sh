#!/usr/bin/env bash
set -euo pipefail

# Stub integration check: one "component" writes a value to a shared
# fixture, another "component" reads it back — standing in for a real
# integration test between two parts of a system.
cd "$(git rev-parse --show-toplevel)"

fixture="ci/fixtures/greeting.txt"
expected="hello-from-fixture"

actual=$(tr -d '[:space:]' < "$fixture")

if [[ "$actual" != "$expected" ]]; then
  echo "integration: expected '$expected' from $fixture, got '$actual'"
  exit 1
fi

echo "integration: ok"
