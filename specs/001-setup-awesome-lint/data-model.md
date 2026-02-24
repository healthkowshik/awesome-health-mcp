# Data Model: Setup Awesome-Lint

**Feature**: 001-setup-awesome-lint
**Date**: 2026-02-24

## Entities

This feature does not introduce domain entities in the traditional
sense. The "data model" consists of configuration files and their
relationships.

### E1: Package Manifest (`package.json`)

| Field | Type | Value | Notes |
|-------|------|-------|-------|
| `private` | boolean | `true` | Prevents accidental npm publish |
| `devDependencies.awesome-lint` | string | `"2.2.3"` | Exact pin, no caret |
| `scripts.lint` | string | `"awesome-lint"` | Single lint command |

**Relationships**: Consumed by `npm ci` in the CI workflow. Read by
contributors running `npm run lint` locally.

### E2: CI Workflow (`.github/workflows/awesome-lint.yml`)

| Field | Value | Notes |
|-------|-------|-------|
| Trigger: pull_request | `paths: ['README.md']` | Only runs when README changes |
| Trigger: push | `branches: ['main']` | Catches direct pushes |
| checkout | `fetch-depth: 0` | Full clone for git-repo-age rule |
| node version | `20` | Minimum required by awesome-lint |
| install | `npm ci` | Deterministic from lockfile |
| lint | `npm run lint` | Reuses the same script as local dev |

**Relationships**: Depends on `package.json` and `package-lock.json`
for `npm ci`. Reports status check on PRs and commit status on pushes.

### E3: README (`README.md`)

Modified to fix lint violations. Expected changes:

| Change | Location |
|--------|----------|
| Add `## Contents` section | After the badge block, before first category |
| Add awesome badge (or suppress rule) | Top of file |
| Add Code of Conduct file reference | Implicit — `awesome-code-of-conduct` rule checks for file existence |

### E4: Code of Conduct (`CODE_OF_CONDUCT.md`)

New file required by the `awesome-code-of-conduct` rule. Standard
Contributor Covenant or similar.

### E5: Gitignore (`.gitignore`)

| Addition | Reason |
|----------|--------|
| `node_modules/` | Exclude npm dependencies from version control |

## State Transitions

N/A — no stateful entities.

## Validation Rules

- `package.json` MUST declare awesome-lint with an exact version (no `^` or `~`).
- `package-lock.json` MUST be checked in (not gitignored).
- CI workflow MUST use `npm ci` (not `npm install`) for reproducibility.
- `README.md` MUST pass `npm run lint` with exit code 0.
