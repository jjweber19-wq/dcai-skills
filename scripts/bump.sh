#!/usr/bin/env bash
# Sets one version in every plugin manifest: ./scripts/bump.sh 0.2.0
set -euo pipefail
cd "$(dirname "$0")/.."
[[ $# -eq 1 && "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Usage: $0 X.Y.Z" >&2; exit 1; }
for f in plugins/dcai/plugin.json plugins/dcai/.claude-plugin/plugin.json \
         plugins/dcai/.cursor-plugin/plugin.json plugins/dcai/.antigravity-plugin/plugin.json \
         plugins/dcai/gemini-extension.json .claude-plugin/marketplace.json; do
  sed -i.bak -E "s/\"version\": \"[0-9]+\.[0-9]+\.[0-9]+\"/\"version\": \"$1\"/" "$f" && rm "$f.bak"
done
echo "Every manifest now says $1."
