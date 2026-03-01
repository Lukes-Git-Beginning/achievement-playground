#!/bin/bash
# Pair Extraordinaire Achievement: Merge PRs with co-authored commits
# Also counts toward Pull Shark!
# Usage: bash scripts/farm-pair-extraordinaire.sh [COUNT]
# Run from repo root
#
# Tiers (Pair Extraordinaire):
#   Base:   1 co-authored merged PR
#   Bronze: 10 co-authored merged PRs
#   Silver: 24 co-authored merged PRs
#   Gold:   48 co-authored merged PRs

set -e

COUNT=${1:-1}
REPO="Lukes-Git-Beginning/achievement-playground"
CO_AUTHOR="Nightline-debug <264815089+Nightline-debug@users.noreply.github.com>"
START=${2:-1}

echo "=== Pair Extraordinaire + Pull Shark Farming ==="
echo "Creating and merging $COUNT co-authored pull requests..."
echo "Co-Author: $CO_AUTHOR"
echo ""

for i in $(seq "$START" $((START + COUNT - 1))); do
  BRANCH="pair-extra-$i"

  echo "--- PR #$i of $COUNT ---"

  # Ensure we're on main and up to date
  git checkout main 2>/dev/null
  git pull origin main 2>/dev/null || true

  # Create branch with a co-authored commit
  git checkout -b "$BRANCH"
  echo "Pair Extraordinaire farming - PR #$i - $(date)" >> pair-farming.txt
  git add pair-farming.txt
  git commit -m "$(cat <<EOF
Pair Extraordinaire #$i

Co-Authored-By: $CO_AUTHOR
EOF
)"
  git push origin "$BRANCH"

  # Create and merge PR
  MSYS_NO_PATHCONV=1 gh pr create \
    --repo "$REPO" \
    --title "Pair Extraordinaire #$i" \
    --body "Co-authored PR for Pair Extraordinaire achievement." \
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

  # Rate limiting pause
  if [ $((i % 10)) -eq 0 ]; then
    echo "Pausing 30s to avoid rate limits..."
    sleep 30
  else
    sleep 3
  fi
done

echo ""
echo "=== Done! Merged $COUNT co-authored PRs ==="
echo "Check your profile in ~24 hours"
echo ""
echo "Pair Extraordinaire tiers:"
echo "  Base (1):    $([ $COUNT -ge 1 ] && echo 'DONE' || echo 'Need more')"
echo "  Bronze (10): $([ $COUNT -ge 10 ] && echo 'DONE' || echo 'Need more')"
echo "  Silver (24): $([ $COUNT -ge 24 ] && echo 'DONE' || echo 'Need more')"
echo "  Gold (48):   $([ $COUNT -ge 48 ] && echo 'DONE' || echo 'Need more')"
echo ""
echo "These PRs also count toward Pull Shark!"
