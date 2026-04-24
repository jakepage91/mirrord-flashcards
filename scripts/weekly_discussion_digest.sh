#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_TOKEN:?GITHUB_TOKEN is required}"
: "${GH_REPO:?GH_REPO is required in owner/repo form}"

owner="${GH_REPO%%/*}"
repo="${GH_REPO##*/}"
out_dir="${1:-discussion-digest}"
mkdir -p "$out_dir"
out_file="$out_dir/weekly-discussion-digest.md"

query='query($owner:String!,$name:String!){
  repository(owner:$owner,name:$name){
    discussions(first:100, orderBy:{field:UPDATED_AT,direction:DESC}){
      nodes{
        number
        title
        url
        createdAt
        updatedAt
        isAnswered
        author { login }
      }
    }
  }
}'

json=$(gh api graphql -f query="$query" -F owner="$owner" -F name="$repo")

{
  echo "# Weekly flashcard discussion digest"
  echo
  echo "Generated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "Repository: ${owner}/${repo}"
  echo
  echo "## Discussions with flashcard marker"
  echo
  echo "This report includes discussions whose title contains the marker \`[card:\`."
  echo

  count=$(jq '[.data.repository.discussions.nodes[] | select(.title | test("\\[card:"))] | length' <<<"$json")
  echo "Found: **${count}**"
  echo

  if [[ "$count" -eq 0 ]]; then
    echo "No card-linked discussions found this week."
  else
    jq -r '.data.repository.discussions.nodes[]
      | select(.title | test("\\[card:"))
      | "- [#\(.number) \(.title)](\(.url)) | author: @\(.author.login // "unknown") | updated: \(.updatedAt) | answered: \(.isAnswered)"' <<<"$json"
  fi
} > "$out_file"

echo "Wrote digest to $out_file"
