# Feature Specification: Setup Awesome-Lint

**Feature Branch**: `001-setup-awesome-lint`
**Created**: 2026-02-24
**Status**: Draft
**Input**: User description: "Setup awesome-lint in this repository"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Run Linting Locally (Priority: P1)

A maintainer editing `README.md` wants to verify the list conforms to
awesome-list standards before committing. They run a single command
from the repository root and receive a pass/fail report with
actionable error messages pointing to specific lines.

**Why this priority**: Local linting is the foundation — every other
workflow (CI, pre-commit) depends on the linter being configured and
runnable in the repository.

**Independent Test**: Run the lint command on the current `README.md`
and confirm it produces output indicating pass or listing violations.

**Acceptance Scenarios**:

1. **Given** a maintainer is in the repo root with Node.js installed,
   **When** they run the lint command,
   **Then** awesome-lint executes against `README.md` and prints
   results to the terminal.
2. **Given** `README.md` contains a formatting violation (e.g.,
   missing description on a list item),
   **When** the lint command runs,
   **Then** the output identifies the violation with a file path
   and line number.
3. **Given** `README.md` passes all checks,
   **When** the lint command runs,
   **Then** the command exits with code 0 and prints no errors.

---

### User Story 2 - Automated CI Linting (Priority: P2)

A contributor opens a pull request that modifies `README.md`, or a
maintainer pushes directly to the main branch. In both cases a CI
check automatically runs awesome-lint and reports pass/fail,
preventing formatting or quality violations from persisting.

**Why this priority**: Automated enforcement is the primary value of
integrating a linter — it catches issues without relying on manual
review, whether changes arrive via PR or direct push.

**Independent Test**: Open a PR with a deliberately malformed entry
and confirm the CI check fails. Fix the entry and confirm the check
passes. Push a clean commit to main and confirm it passes.

**Acceptance Scenarios**:

1. **Given** a PR modifies `README.md`,
   **When** the CI pipeline runs,
   **Then** awesome-lint executes and the check status is reported
   on the PR.
2. **Given** a PR introduces a linting violation,
   **When** the CI check completes,
   **Then** the PR shows a failing status check with the violation
   details visible in the CI log.
3. **Given** a PR with a clean `README.md`,
   **When** the CI check completes,
   **Then** the PR shows a passing status check.
4. **Given** a maintainer pushes a commit to main,
   **When** the CI pipeline runs,
   **Then** awesome-lint executes and the result is visible as a
   commit status.

---

### Edge Cases

- What happens when Node.js is not installed? The lint command MUST
  print a clear error message indicating the dependency requirement.
- What happens when `README.md` is deleted or renamed? The linter
  MUST report a missing-file error rather than silently passing.
- What happens when awesome-lint itself has a breaking update? The
  dependency version MUST be pinned to avoid unexpected failures.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The repository MUST include awesome-lint as a
  development dependency with a pinned version.
- **FR-002**: A convenience script or npm script MUST allow running
  the linter via a single command from the repository root.
- **FR-003**: A GitHub Actions workflow MUST run awesome-lint on
  every pull request that modifies `README.md` and on every push
  to the main branch.
- **FR-004**: The CI workflow MUST report pass/fail as a GitHub
  status check on pull requests and as a commit status on pushes
  to main.
- **FR-005**: The current `README.md` MUST pass all default
  awesome-lint rules with zero violations. Any existing violations
  MUST be fixed in the README itself. The sole permitted exception
  is the `awesome-badge` rule, which may be suppressed because this
  list is not part of the official awesome directory.
- **FR-006**: The linter configuration MUST be checked into the
  repository so all contributors use the same rules.

### Key Entities

- **Linter configuration**: The `package.json` (or equivalent) that
  declares awesome-lint as a dependency and defines the lint script.
- **CI workflow**: The GitHub Actions workflow file that triggers
  linting on pull requests.
- **README fixes**: Any modifications to `README.md` needed to pass
  all default awesome-lint rules without suppressions.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A maintainer can lint `README.md` by running a single
  command from the repository root, with results displayed in under
  10 seconds.
- **SC-002**: Every pull request that modifies `README.md` receives
  an automated lint check result within 2 minutes of opening.
- **SC-003**: The current `README.md` passes the linter with zero
  errors using all default rules and no suppressions.
- **SC-004**: A deliberately malformed entry introduced in a test PR
  is caught by the CI lint check before merge.

## Clarifications

### Session 2026-02-24

- Q: Should User Story 3 (Suppress Intentional Deviations) and FR-005
  be removed from scope? → A: Remove US3 and FR-005 entirely. README
  must pass all default rules. Fix any violations in README.
- Q: Should the CI workflow also run on direct pushes to main? → A:
  Yes. Run on both PRs and pushes to main for full coverage.

## Assumptions

- Node.js (and npm/npx) is available in the GitHub Actions runner
  environment (standard for `ubuntu-latest` images).
- The project does not currently have a `package.json`; one will be
  created to manage the awesome-lint dependency.
- awesome-lint's `npx` mode is suitable for CI; a local install via
  `package.json` is preferred for reproducibility and version pinning.
- Contributors are expected to have Node.js installed locally for
  running the linter before submitting PRs (documented in
  CONTRIBUTING.md).
