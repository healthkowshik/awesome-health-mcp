# Quickstart: Setup Awesome-Lint

**Feature**: 001-setup-awesome-lint
**Date**: 2026-02-24

## Prerequisites

- Node.js >= 20 installed
- npm (bundled with Node.js)

## Local Linting

Run from the repository root:

```bash
npm install    # First time only — installs awesome-lint
npm run lint   # Lint README.md
```

A clean run exits with code 0 and no output. Violations are printed
with file path, line number, and rule identifier.

## CI Behavior

The GitHub Actions workflow (`.github/workflows/awesome-lint.yml`)
runs automatically:

- **On pull requests** that modify `README.md` — result appears as a
  status check on the PR.
- **On pushes to main** — result appears as a commit status.

No manual setup is needed after the workflow file is merged.

## Fixing Violations

awesome-lint reports violations in this format:

```
readme.md:12:3 warning Missing Table of Contents awesome-toc
```

Fix the issue in `README.md` and re-run `npm run lint` until the
output is clean.

## Rule Suppression (emergency only)

If a rule cannot be satisfied (e.g., the awesome badge for unofficial
lists), suppress it with an inline HTML comment:

```markdown
<!--lint disable awesome-badge-->
```

The project goal is zero suppressions. Any suppression must be
justified in the PR description.
