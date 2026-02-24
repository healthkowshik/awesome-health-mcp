# Tasks: Setup Awesome-Lint

**Input**: Design documents from `/specs/001-setup-awesome-lint/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: No automated tests — validation is via `npm run lint` (exit code 0).

**Organization**: Tasks grouped by user story for independent implementation.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Initialize Node.js project with awesome-lint dependency

- [x] T001 [P] Add `node_modules/` entry to `.gitignore`
- [x] T002 [P] Create `package.json` with awesome-lint 2.2.3 (exact pin), `private: true`, and `lint` script at repository root
- [x] T003 Run `npm install` to generate `package-lock.json` at repository root (depends on T002)

**Checkpoint**: `npm run lint` is runnable (may report violations — that's expected)

---

## Phase 2: User Story 1 — Run Linting Locally (Priority: P1) MVP

**Goal**: A maintainer can run a single command from the repo root to
lint `README.md` and get a pass/fail report with actionable messages.

**Independent Test**: Run `npm run lint` — must exit with code 0 and
print no errors.

### Implementation for User Story 1

- [x] T004 [US1] Run `npm run lint` and record all current violations in `README.md`
- [x] T005 [P] [US1] Create `CODE_OF_CONDUCT.md` at repository root (Contributor Covenant v2.1 — required by `awesome-code-of-conduct` rule)
- [x] T006 [P] [US1] Fix `README.md` — add `## Contents` section with links to each category (required by `awesome-toc` rule) and fix any other lint violations found in T004
- [x] T007 [US1] Handle `awesome-badge` rule in `README.md` — add suppression `<!--lint disable awesome-badge-->` with comment explaining this list is not yet on the official awesome directory (research decision R4)
- [x] T008 [US1] Verify `npm run lint` exits with code 0 and zero errors (depends on T005, T006, T007)

**Checkpoint**: User Story 1 complete — local linting works, README passes all rules

---

## Phase 3: User Story 2 — Automated CI Linting (Priority: P2)

**Goal**: Every PR modifying `README.md` and every push to main
automatically runs awesome-lint, reporting pass/fail as a status check.

**Independent Test**: Push the workflow to a branch, open a PR
modifying `README.md`, and confirm the lint check appears on the PR.

### Implementation for User Story 2

- [x] T009 [US2] Create GitHub Actions workflow in `.github/workflows/awesome-lint.yml` with: triggers (`pull_request` paths `README.md` + `push` branches `main`), `actions/checkout` with `fetch-depth: 0`, `actions/setup-node` with Node.js 20, `npm ci`, `npm run lint`
- [x] T010 [US2] Verify workflow YAML is syntactically valid and action versions are pinned

**Checkpoint**: User Story 2 complete — CI enforces linting on PRs and pushes to main

---

## Phase 4: Polish & Cross-Cutting Concerns

**Purpose**: End-to-end validation and cleanup

- [x] T011 Run quickstart.md validation: clean clone simulation (`rm -rf node_modules && npm install && npm run lint`) passes with exit code 0

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately
- **User Story 1 (Phase 2)**: Depends on Setup (T003 must complete)
- **User Story 2 (Phase 3)**: Depends on Setup (T003 must complete) — can run in parallel with US1
- **Polish (Phase 4)**: Depends on US1 and US2 being complete

### User Story Dependencies

- **User Story 1 (P1)**: Depends on Setup only. No dependency on US2.
- **User Story 2 (P2)**: Depends on Setup only. No dependency on US1 (workflow references the same `npm run lint` from Setup). However, the workflow will only pass in CI after US1 fixes the README.

### Within Each User Story

- **US1**: T004 (identify violations) → T005, T006, T007 in parallel (fix violations) → T008 (verify)
- **US2**: T009 (create workflow) → T010 (validate)

### Parallel Opportunities

- T001 and T002 can run in parallel (different files)
- T005, T006, and T007 can run in parallel (different files, all informed by T004)
- US2 Phase 3 (T009) can start as soon as Setup completes, in parallel with US1 work

---

## Parallel Example: User Story 1

```text
# After T004 identifies violations, fix all three in parallel:
Task: "Create CODE_OF_CONDUCT.md at repository root"
Task: "Fix README.md — add Contents section and fix violations"
Task: "Handle awesome-badge rule in README.md"
```

## Parallel Example: Setup

```text
# Both can run simultaneously:
Task: "Add node_modules/ to .gitignore"
Task: "Create package.json with awesome-lint dependency"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001–T003)
2. Complete Phase 2: User Story 1 (T004–T008)
3. **STOP and VALIDATE**: `npm run lint` exits 0
4. Ready to use locally

### Incremental Delivery

1. Setup → Foundation ready (T001–T003)
2. Add User Story 1 → Local linting works (T004–T008) → MVP!
3. Add User Story 2 → CI enforcement active (T009–T010)
4. Polish → Full validation (T011)

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story
- No automated test suite — validation is `npm run lint` exit code 0
- The `awesome-badge` rule suppression (T007) is the sole exception to zero-suppressions per research decision R4
- Commit after each phase checkpoint
