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
badge_line="> <!-- MCP_SERVER_BADGE_START -->![MCP servers](https://img.shields.io/badge/MCP%20servers-${count}-2ea44f)<!-- MCP_SERVER_BADGE_END -->"

awk -v badge_line="$badge_line" '
{
  if ($0 ~ /MCP_SERVER_BADGE_START/ || $0 ~ /MCP_SERVER_COUNT_START/) {
    print badge_line
    next
  }
  print
}
' "$README_PATH" > "$tmp_file"

mv "$tmp_file" "$README_PATH"
echo "Updated MCP server count to $count in $README_PATH"
