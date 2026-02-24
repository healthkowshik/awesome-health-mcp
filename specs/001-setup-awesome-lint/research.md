# Research: Setup Awesome-Lint

**Feature**: 001-setup-awesome-lint
**Date**: 2026-02-24

## R1: awesome-lint Version and Compatibility

**Decision**: Use awesome-lint v2.2.3 (latest stable, published
2025-01-30) with an exact pin in `package.json`.

**Rationale**: Exact pinning (`"awesome-lint": "2.2.3"`) prevents
automatic minor/patch updates from introducing new rules or changing
behavior, which would cause unexpected CI failures. The lockfile
(`package-lock.json`) further locks the full dependency tree (~70
transitive dependencies).

**Alternatives considered**:
- Caret range (`^2.2.3`): Rejected — allows automatic updates that
  could break CI without notice.
- `npx awesome-lint` without `package.json`: Rejected — no version
  pinning, non-reproducible across environments.

## R2: CI Workflow Design

**Decision**: Single GitHub Actions workflow file
(`.github/workflows/awesome-lint.yml`) that triggers on PRs touching
`README.md` and on pushes to `main`.

**Rationale**: GitHub Actions is the project's hosting platform and
provides native status check integration. A single workflow file keeps
the CI footprint minimal.

**Key implementation details**:
- Use `actions/checkout` with `fetch-depth: 0` (full clone). The
  `awesome-git-repo-age` rule requires git history to verify the
  repository is not brand new. Shallow clones cause this rule to fail.
- Use `actions/setup-node` to install Node.js 20.
- Run `npm ci` (not `npm install`) for deterministic installs from the
  lockfile.
- Trigger: `pull_request` with `paths: ['README.md']` + `push` to
  `main` branch.

**Alternatives considered**:
- Pre-commit hook via husky: Rejected — adds complexity, requires
  Node.js locally, and doesn't protect the main branch from direct
  pushes.
- Separate workflows for PR and push: Rejected — a single workflow
  with multiple triggers is simpler and sufficient.

## R3: README Violations to Fix

**Decision**: Fix all violations directly in `README.md` rather than
suppressing rules.

**Anticipated violations** (based on awesome-lint's default rules):

| Rule | Violation | Fix |
|------|-----------|-----|
| `awesome-toc` | No Table of Contents section | Add a `## Contents` section with links to each category |
| `awesome-badge` | No awesome badge at the top | Add the standard awesome badge (or suppress if not on the official awesome list — see R4) |
| `awesome-code-of-conduct` | No Code of Conduct file | Add a `CODE_OF_CONDUCT.md` file |
| `awesome-git-repo-age` | May flag if repo is very new | Use `fetch-depth: 0` in CI (see R2) |
| `awesome-no-ci-badge` | N/A — no CI badge present | No action needed |

**Rationale**: The spec explicitly requires zero suppressions (FR-005).
Fixing violations in the README preserves the standard awesome-list
format and passes all default rules.

## R4: Awesome Badge Requirement

**Decision**: The `awesome-badge` rule requires a badge linking to the
awesome list directory. If this project is not (yet) on the official
awesome list, this rule may need to be suppressed with an inline
comment — this would be the sole exception to the zero-suppression
goal.

**Rationale**: The awesome badge is meant for lists that are officially
part of the sindresorhus/awesome collection. Adding a badge that links
nowhere would be misleading. If suppression is needed, it will be the
minimal `<!--lint disable awesome-badge-->` directive.

**Action**: Run `awesome-lint` locally against the current README to
determine the exact set of violations. Adjust this plan based on
actual output.

## R5: .gitignore Updates

**Decision**: Add `node_modules/` to `.gitignore`.

**Rationale**: The `npm install` command creates a `node_modules/`
directory that should never be committed. The existing `.gitignore`
only contains `.claude/settings.local.json`.
