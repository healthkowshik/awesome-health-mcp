#!/usr/bin/env bash

set -euo pipefail

README_PATH="${1:-README.md}"

if [[ ! -f "$README_PATH" ]]; then
  echo "README not found: $README_PATH" >&2
  exit 1
fi

if ! grep -Eq "MCP_SERVER_BADGE_START|MCP_SERVER_COUNT_START" "$README_PATH"; then
  echo "Badge/count marker not found in $README_PATH" >&2
  exit 1
fi

count="$(grep -Ec '^- \*\*\[[^]]+/[^]]+\]\(https://github\.com/[^)]+\)\*\* — ' "$README_PATH")"
tmp_file="$(mktemp)"
badge_markdown="![MCP servers](https://img.shields.io/badge/MCP%20servers-${count}-2ea44f)"

awk -v badge_markdown="$badge_markdown" '
{
  # Legacy inline format: start and end marker on one line.
  if ($0 ~ /MCP_SERVER_BADGE_START/ && $0 ~ /MCP_SERVER_BADGE_END/) {
    print "<!-- MCP_SERVER_BADGE_START -->"
    print badge_markdown
    print "<!-- MCP_SERVER_BADGE_END -->"
    next
  }

  # Start marker begins a managed badge block.
  if ($0 ~ /MCP_SERVER_BADGE_START/) {
    print "<!-- MCP_SERVER_BADGE_START -->"
    print badge_markdown
    in_badge_block = 1
    next
  }

  # End marker closes a managed badge block.
  if ($0 ~ /MCP_SERVER_BADGE_END/) {
    print "<!-- MCP_SERVER_BADGE_END -->"
    in_badge_block = 0
    next
  }

  # Skip stale lines inside the managed badge block.
  if (in_badge_block == 1) {
    next
  }

  # Legacy count marker format migration.
  if ($0 ~ /MCP_SERVER_COUNT_START/) {
    print "<!-- MCP_SERVER_BADGE_START -->"
    print badge_markdown
    print "<!-- MCP_SERVER_BADGE_END -->"
    next
  }

  print
}
' "$README_PATH" > "$tmp_file"

mv "$tmp_file" "$README_PATH"
echo "Updated MCP server count to $count in $README_PATH"
