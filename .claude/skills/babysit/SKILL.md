---
name: babysit
description: Repo-specific conventions for driving this repo's PRs to green.
---

# Babysitting PRs

`ci/*.sh` holds this repo's lint/unit/integration/e2e checks, invoked via
the `Makefile` and run in `.github/workflows/ci.yml`. Treat a red check by
finding the root cause in the relevant `ci/*.sh` script or fixture under
`ci/fixtures/`, fixing it, running `make ci` locally to confirm, then
pushing.

## Conventions
- **Merge conflicts**: merge the base branch in (`git merge`), never rebase
  or force-push — regenerate any generated files or lockfiles with the
  project's own tooling before pushing.
- **Autofix posture**: fix small, obvious CI failures (a wrong constant, a
  bad fixture value, a stray lint hit) autonomously, including pushing,
  without asking first. Anything that would change what a check *means*
  (e.g. rewriting an assertion instead of fixing the underlying value) is
  a design change — propose it instead of pushing it.
- **Flakiness**: every `ci/*.sh` script is meant to be deterministic —
  treat a red check as a real failure to root-cause, not a flake, unless
  you've confirmed otherwise (e.g. it also fails identically on a clean
  re-run against unrelated code).
