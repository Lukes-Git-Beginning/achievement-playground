#!/bin/bash
# Pull Shark Achievement: Merge multiple pull requests
# Usage: bash scripts/farm-pull-shark.sh [COUNT]
# Run from repo root
#
# Tiers:
#   Base:   2 merged PRs
#   Bronze: 16 merged PRs
#   Silver: 128 merged PRs
#   Gold:   1024 merged PRs

set -e

COUNT=${1:-2}
REPO="Lukes-Git-Beginning/achievement-playground"
START=${2:-1}

echo "=== Pull Shark Farming ==="
echo "Creating and merging $COUNT pull requests..."
echo ""

for i in $(seq "$START" $((START + COUNT - 1))); do
  BRANCH="pull-shark-$i"

  echo "--- PR #$i of $COUNT ---"

  # Ensure we're on main and up to date
  git checkout main 2>/dev/null
  git pull origin main 2>/dev/null || true

  # Create branch with a unique change
  git checkout -b "$BRANCH"
  echo "Pull Shark farming - PR #$i - $(date)" >> farming.txt
  git add farming.txt
  git commit -m "Pull Shark #$i"
  git push origin "$BRANCH"

  # Create and merge PR
  MSYS_NO_PATHCONV=1 gh pr create \
    --repo "$REPO" \
    --title "Pull Shark #$i" \
    --body "Automated PR for Pull Shark achievement." \
    --head "$BRANCH"

  sleep 2

  MSYS_NO_PATHCONV=1 gh pr merge "$BRANCH" \
    --repo "$REPO" \
    --merge \
    --delete-branch

  # Cleanup local branch
  git checkout main
  git pull origin main
  git branch -d "$BRANCH" 2>/dev/null || true

  echo "PR #$i merged successfully!"

  # Rate limiting pause - avoid GitHub API limits
  if [ $((i % 10)) -eq 0 ]; then
    echo "Pausing 30s to avoid rate limits..."
    sleep 30
  else
    sleep 3
  fi
done

echo ""
echo "=== Done! Merged $COUNT PRs ==="
echo "Pull Shark progress: check your profile in ~24 hours"
echo ""
echo "Tier progress:"
echo "  Base (2):    $([ $COUNT -ge 2 ] && echo 'DONE' || echo 'Need more')"
echo "  Bronze (16): $([ $COUNT -ge 16 ] && echo 'DONE' || echo 'Need more')"
echo "  Silver (128):$([ $COUNT -ge 128 ] && echo 'DONE' || echo 'Need more')"
echo "  Gold (1024): $([ $COUNT -ge 1024 ] && echo 'DONE' || echo 'Need more')"
