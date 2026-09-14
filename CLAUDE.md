# CICaDa

An agent-driven CI/CD loop: an agent plans, implements, and opens a PR;
CI checks it; an agent drives it to green; a human does final review. `ci/`
holds this repo's lint/unit/integration/e2e checks — replace them with the
project's real checks when adopting this pattern elsewhere.

## The loop

1. A task is handed to a Claude Code session.
2. The agent explores, drafts a plan, and gets it approved before writing
   any code. The plan should call out security and accessibility
   implications of the change, not just functional ones.
3. The agent implements the change and opens a PR (using
   `.github/pull_request_template.md`), filling in the template's
   Security & accessibility section.
4. `.github/workflows/ci.yml` runs four checks on the PR: `lint`, `unit`,
   `integration`, `e2e` — each just a thin wrapper (see `Makefile`) around
   a script in `ci/`.
5. A Claude Code session subscribes to the PR's activity and watches CI.
   When a check goes red, it root-causes and fixes it, pushing until every
   check is green. `.claude/skills/babysit/SKILL.md` has the repo-specific
   rules for that loop (merge conventions, autofix posture).
6. A human does the final review — requesting changes or merging.

## Security & accessibility

Every plan and PR addresses these alongside functional correctness:

- **Security**: new inputs, auth/permission checks, secrets handling, and
  injection risk (SQL/command/XSS) — flag anything touching the OWASP Top
  10.
- **Accessibility**: for any UI change — semantic markup, keyboard
  navigation, color contrast, ARIA labels.

If a change touches neither, say so explicitly in the PR rather than
omitting the section.

## Running checks locally

```
make ci             # run everything: lint, unit, integration, e2e
make lint
make test-unit
make test-integration
make test-e2e
```

## Layout

- `ci/*.sh` — the four check scripts (currently placeholder examples in
  this repo), each self-contained and deterministic (see
  `.claude/skills/babysit/SKILL.md` for how to treat a failure).
- `ci/fixtures/` — data the integration check reads.
- `Makefile` — the single command interface used identically by a human
  and by `.github/workflows/ci.yml`.
