<!--
  Sync Impact Report
  ==================
  Version change: (none) → 1.0.0 (initial ratification)
  Modified principles: N/A (first version)
  Added sections:
    - Core Principles (5 principles)
    - Curation Standards
    - Contribution Workflow
    - Governance
  Removed sections: N/A
  Templates requiring updates:
    - .specify/templates/plan-template.md — ✅ no update needed
      (Constitution Check section is generic; principles apply at review time)
    - .specify/templates/spec-template.md — ✅ no update needed
      (User story and requirements sections are generic)
    - .specify/templates/tasks-template.md — ✅ no update needed
      (Task phases are generic; no principle-specific task types required)
  Follow-up TODOs: none
-->

# Awesome Health MCP Constitution

## Core Principles

### I. Domain Relevance

Every entry in this list MUST relate to both:

- **Model Context Protocol (MCP)**: The repository MUST implement or
  directly support the MCP specification.
- **Health domain**: The repository MUST target health, healthcare,
  life sciences, biomedical, or clinical use cases.

Entries that satisfy only one criterion MUST NOT be included.
Aggregator or list-of-lists repositories MUST NOT be included.

**Rationale**: A focused scope is the primary value of a curated list.
Diluting it with tangential entries degrades discoverability.

### II. Entry Quality

All listed repositories MUST meet these non-negotiable criteria:

- The GitHub URL MUST resolve to a valid, publicly accessible repository.
- The repository MUST show activity within the last 12 months.
- The repository MUST NOT duplicate an existing entry (same owner/repo
  or same URL).

Entries that fail any criterion MUST be removed or not admitted.

**Rationale**: Linking to dead, abandoned, or duplicate projects wastes
readers' time and erodes trust in the list.

### III. Consistent Formatting

Every entry MUST use this exact format:

```markdown
- **[owner/repo](https://github.com/owner/repo)** — One-line description.
```

Additional formatting rules:

- Entries MUST be sorted alphabetically by `owner/repo` within each section.
- Descriptions MUST be concise, factual, and end with a period.
- No trailing whitespace or extra blank lines between entries.

**Rationale**: Uniform formatting makes the list scannable and diffs
reviewable. Alphabetical order eliminates subjective placement debates.

### IV. Structured Organization

The README MUST contain at most 5 top-level category sections. Sections
MUST be ordered logically, with broad categories before specialized ones.

The badge count at the top of the README MUST always reflect the actual
number of entries. The script `./scripts/update-readme-count.sh` MUST be
run after any entry addition or removal.

**Rationale**: A small number of well-defined sections keeps navigation
simple. An accurate badge count sets correct expectations at a glance.

### V. Simplicity

This project is a curated Markdown list. All changes MUST be minimal
and focused on the list content itself.

- Do not introduce unnecessary tooling, CI pipelines, or automation
  beyond the existing count-update script.
- Do not add wrapper code, web interfaces, or generated artifacts
  unless explicitly justified and approved.
- Prefer manual curation over automated scraping or bulk additions.

**Rationale**: Complexity is the enemy of maintainability for a
community-driven list. Every added mechanism is a future maintenance
burden.

## Curation Standards

Discovery of new entries MAY use external awesome lists, GitHub search,
conference proceedings, or community suggestions. Regardless of source,
each candidate MUST be independently validated against the Core
Principles before inclusion.

Validation checklist for every candidate:

1. Confirm the repository URL resolves (no 404).
2. Confirm MCP relevance (implements or supports MCP).
3. Confirm health-domain relevance.
4. Confirm activity within the last 12 months.
5. Confirm no duplicate exists in the current list.
6. Confirm the entry is not an aggregator or list-of-lists.

Periodic review of existing entries SHOULD occur to remove repositories
that have become inactive or no longer meet quality criteria.

## Contribution Workflow

All changes to the list MUST follow this workflow:

1. **Identify**: Find a candidate repository via discovery channels.
2. **Validate**: Run through the Curation Standards checklist above.
3. **Place**: Select the best-fit existing section (do not create new
   sections without constitutional amendment).
4. **Format**: Write the entry in the exact format from Principle III.
5. **Sort**: Insert alphabetically by `owner/repo`.
6. **Count**: Run `./scripts/update-readme-count.sh` to update the badge.
7. **Submit**: Open a PR with a clear title and the PR checklist from
   `CONTRIBUTING.md` completed.

Section additions or removals require explicit justification and MUST
comply with the 5-section limit (Principle IV).

## Governance

This constitution is the authoritative source of project standards.
It supersedes any conflicting guidance found elsewhere in the repository.

**Amendment procedure**:

1. Propose the change as a GitHub issue or PR with a clear rationale.
2. The amendment MUST document what changed, why, and any migration
   steps required.
3. Update the version number following semantic versioning:
   - **MAJOR**: Principle removal or backward-incompatible redefinition.
   - **MINOR**: New principle or materially expanded guidance.
   - **PATCH**: Clarifications, wording fixes, non-semantic refinements.

**Compliance review**: All PRs and reviews MUST verify adherence to
these principles. Non-compliant entries MUST be corrected before merge.

**Version**: 1.0.0 | **Ratified**: 2026-02-24 | **Last Amended**: 2026-02-24
