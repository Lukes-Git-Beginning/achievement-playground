#!/bin/bash
# Quickdraw Achievement: Close an issue within 5 minutes of opening it
# Usage: bash scripts/quickdraw.sh
# Run from repo root

set -e

REPO="Lukes-Git-Beginning/achievement-playground"

echo "=== Quickdraw Achievement ==="
echo "Opening and immediately closing an issue..."

# Create issue and capture the number
ISSUE_URL=$(MSYS_NO_PATHCONV=1 gh issue create \
  --repo "$REPO" \
  --title "Quickdraw Achievement" \
  --body "This issue was created and closed quickly for the Quickdraw achievement." \
  2>&1)

ISSUE_NUM=$(echo "$ISSUE_URL" | grep -oP '\d+$')

echo "Created issue #$ISSUE_NUM"

# Close it immediately
MSYS_NO_PATHCONV=1 gh issue close "$ISSUE_NUM" --repo "$REPO"

echo "Closed issue #$ISSUE_NUM"
echo ""
echo "Quickdraw achievement should appear within 24 hours!"
