# AGENTS.md

## Guidelines

Follow the below guidelines while planning, doing research as well as contributing to this repository.

### Scope and minimum acceptance criteria

- This project is to curate a list of awesome Model Context Protocol (MCP) servers for health.
- Minimum acceptance criteria for an item to be listed is that it should be related to both Model Context Protocol (MCP) and Health.

### Sectioning guidelines

- Organize the README into sections so it is easy to scan.
- Do not use more than 5 sections total.
- Prefer fewer sections when possible (merge closely related sections instead of creating many small ones).
- Example: If two sections are both about research data access, combine them into one.

### Section ordering guidelines

- Keep section order stable and intentional.
- Prefer broad-to-specific flow (general clinical/research categories first, specialized categories later).
- Example: A clinical interoperability section should generally appear before a specialized genomics section.

### Entry ordering guidelines

- Sort entries alphabetically by `owner/repo` within each section.
- Example order: `alpha/repo`, `bravo/repo`, `charlie/repo`.

### Listing format

- Use exactly this format:

```markdown
- **[anthropics/healthcare](https://github.com/anthropics/healthcare)** — MCP marketplace of healthcare skills and plugins for Claude (FHIR, clinical workflows, PubMed, CMS, NPI).
```

### URL validity and legitimacy

- Before including a URL, check if the link exists and the page is legit.
- Example valid: https://github.com/anthropics/healthcare
- Example invalid: https://github.com/Kartha-AI/agentcare-mcp (GitHub 404)

### Activity and maintenance

- Prefer repositories that are actively maintained.
- As a default rule, do not include repositories whose last update was more than 12 months ago.
- Example: If a repo was last pushed over a year ago, skip it.

### No duplicates

- Do not include a repository if it already exists anywhere in the README.
- Before adding a new item, scan all sections for the same `owner/repo` and URL.
- Example: If `wso2/fhir-mcp-server` already exists in one section, do not add it again in another.

### Avoid listing lists

- Pages like https://github.com/modelcontextprotocol/servers are lists themselves. Avoid listing such pages which are large lists themselves.
- The idea with this project, awesome health MCP is to list down individual items, not link to other lists.

### Using other awesome lists as input

- External awesome lists can be used only as discovery sources.
- Each candidate must still be independently validated against all rules in this file before adding.
- Example: Find candidates in another list, but add only the individual repos that pass URL, activity, relevance, and duplicate checks.
