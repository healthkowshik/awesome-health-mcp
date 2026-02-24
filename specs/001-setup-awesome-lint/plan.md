# Implementation Plan: Setup Awesome-Lint

**Branch**: `001-setup-awesome-lint` | **Date**: 2026-02-24 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/001-setup-awesome-lint/spec.md`

## Summary

Add awesome-lint as a pinned dev dependency so maintainers can lint
`README.md` locally with a single command, and add a GitHub Actions
workflow that runs the same lint on every PR touching `README.md` and
on every push to main. Fix any existing README violations so the
linter passes with zero errors and zero suppressions.

## Technical Context

**Language/Version**: Node.js >= 20 (required by awesome-lint v2.2.3)
**Primary Dependencies**: awesome-lint 2.2.3 (pinned exact)
**Storage**: N/A
**Testing**: Manual — `npm run lint` locally; CI validates automatically
**Target Platform**: GitHub Actions `ubuntu-latest` (CI), macOS/Linux (local dev)
**Project Type**: Curated Markdown list (awesome list)
**Performance Goals**: Lint completes in < 10 seconds (SC-001)
**Constraints**: Zero lint violations, zero suppressions (FR-005)
**Scale/Scope**: Single `README.md` file (~60 lines of list entries)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Domain Relevance | N/A | Tooling change, not a list entry |
| II. Entry Quality | N/A | Tooling change, not a list entry |
| III. Consistent Formatting | SUPPORTS | Linter enforces formatting rules automatically |
| IV. Structured Organization | N/A | No section changes |
| V. Simplicity | TENSION | Adds `package.json`, `node_modules`, and a CI workflow — see Complexity Tracking below |

**Gate result**: PASS with justified tension on Principle V.

**Post-Phase-1 re-check**: No new violations introduced. The design
adds exactly three files (`package.json`, `package-lock.json`,
`.github/workflows/awesome-lint.yml`) and modifies `README.md` to
fix violations. No wrapper code, web interfaces, or generated
artifacts beyond what is required.

## Project Structure

### Documentation (this feature)

```text
specs/001-setup-awesome-lint/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```

### Source Code (repository root)

```text
package.json                          # New: awesome-lint dev dependency + lint script
package-lock.json                     # New: generated lockfile (checked in)
.github/
└── workflows/
    └── awesome-lint.yml              # New: CI workflow
CODE_OF_CONDUCT.md                    # New: required by awesome-code-of-conduct rule
README.md                             # Modified: fix lint violations
.gitignore                            # Modified: add node_modules/
```

**Structure Decision**: No `src/` or `tests/` directories. This is a
curated Markdown list, not a software project. The only new files are
the package manifest, lockfile, and CI workflow — the minimum needed
to satisfy the spec requirements.

## Complexity Tracking

> **Filled because Constitution Check has a tension on Principle V.**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| Adding `package.json` + CI workflow (Principle V: Simplicity) | awesome-lint is the community standard for awesome list quality enforcement; it catches formatting, link, and structural violations that are tedious to review manually. The CI workflow prevents regressions from merging. | Running `npx awesome-lint` ad-hoc without a `package.json` is fragile — no version pinning, no reproducible installs, no CI enforcement. Manual review alone does not scale and is error-prone. |
