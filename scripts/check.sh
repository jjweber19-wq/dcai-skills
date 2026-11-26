#!/usr/bin/env bash
# Checks every manifest is valid JSON with one version, and every skill has a
# name and description that match the Agent Skills rules.
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0
manifests=(plugins/dcai/plugin.json plugins/dcai/.claude-plugin/plugin.json plugins/dcai/.cursor-plugin/plugin.json
  plugins/dcai/.antigravity-plugin/plugin.json plugins/dcai/gemini-extension.json .claude-plugin/marketplace.json
  .cursor-plugin/marketplace.json .agents/plugins/marketplace.json)
for f in "${manifests[@]}"; do
  python3 -c 'import json,sys; json.load(open(sys.argv[1]))' "$f" || { echo "Not JSON: $f"; fail=1; }
done
versions=$(grep -ho '"version": "[0-9.]*"' "${manifests[@]}" | sort -u | wc -l)
[[ "$versions" -eq 1 ]] || { echo "Manifests disagree on the version"; fail=1; }
for d in plugins/dcai/skills/*/; do
  name=$(basename "$d"); f="$d/SKILL.md"
  [[ -f "$f" ]] || { echo "Missing $f"; fail=1; continue; }
  head -1 "$f" | grep -qx -- '---' || { echo "$f: no frontmatter"; fail=1; }
  grep -qx "name: $name" "$f" || { echo "$f: name must be $name"; fail=1; }
  [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ && ${#name} -le 64 ]] || { echo "$f: bad name"; fail=1; }
  desc=$(sed -n 's/^description: //p' "$f" | head -1)
  [[ -n "$desc" && ${#desc} -le 1024 ]] || { echo "$f: description missing or over 1024 characters"; fail=1; }
done
[[ $fail -eq 0 ]] && echo "All good."
exit $fail
