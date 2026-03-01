#!/bin/bash
# YOLO Achievement: Merge a pull request without code review
# Usage: bash scripts/yolo.sh
# Run from repo root

set -e

REPO="Lukes-Git-Beginning/achievement-playground"
BRANCH="yolo-achievement"

echo "=== YOLO Achievement ==="

# Create branch with a change
git checkout main
git pull origin main 2>/dev/null || true
git checkout -b "$BRANCH"

echo "YOLO - merged without review $(date)" >> yolo.txt
git add yolo.txt
git commit -m "YOLO achievement - no review needed"
git push origin "$BRANCH"

# Create PR and merge without review
MSYS_NO_PATHCONV=1 gh pr create \
  --repo "$REPO" \
  --title "YOLO - No review needed" \
  --body "Merging without code review for the YOLO achievement." \
  --head "$BRANCH"

sleep 2

MSYS_NO_PATHCONV=1 gh pr merge "$BRANCH" \
  --repo "$REPO" \
  --merge \
  --delete-branch

git checkout main
git pull origin main

echo ""
echo "YOLO achievement should appear within 24 hours!"
