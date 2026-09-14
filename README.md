# CICaDa

An agent-driven CI/CD loop: an agent plans and implements a change, opens a
PR, GitHub Actions runs the checks, and an agent watches the PR and fixes
failures until it's green for human review. See [CLAUDE.md](CLAUDE.md) for
the full loop and layout.