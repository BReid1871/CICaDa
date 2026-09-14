#!/usr/bin/env bash
set -euo pipefail

# Stub unit check: a trivial, self-contained assertion with no external
# dependencies, standing in for a real unit test suite.

add() {
  echo $(( "$1" + "$2" ))
}

result=$(add 2 2)
expected=4

if [[ "$result" != "$expected" ]]; then
  echo "unit: expected $expected, got $result"
  exit 1
fi

echo "unit: ok"
