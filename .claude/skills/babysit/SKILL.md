---
name: babysit
description: Repo-specific conventions for driving CICaDa PRs to green.
---

# Babysitting CICaDa PRs

CICaDa has no application code — `ci/*.sh` are stand-ins for real
lint/unit/integration/e2e suites, invoked via the `Makefile` and run in
`.github/workflows/ci.yml`. Treat a red check exactly like a real one: find
the root cause in the relevant `ci/*.sh` script or fixture under
`ci/fixtures/`, fix it, run `make ci` locally to confirm, then push.

## Conventions
- **Merge conflicts**: merge the base branch in (`git merge`), never rebase
  or force-push — there is no generated/lockfile output in this repo to
  regenerate.
- **Autofix posture**: this repo exists to exercise the autofix loop, so
  fix small, obvious CI failures (a wrong constant, a bad fixture value,
  a stray whitespace lint hit) autonomously, including pushing, without
  asking first. Anything that would change what a check *means* (e.g.
  rewriting `ci/e2e.sh`'s assertion instead of fixing the underlying
  value) is a design change — propose it instead of pushing it.
- **No flakiness by design**: every `ci/*.sh` script is deterministic. A
  red check here is never a flake — always root-cause it.
