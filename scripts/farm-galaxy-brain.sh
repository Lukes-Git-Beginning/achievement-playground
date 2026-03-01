#!/bin/bash
# Galaxy Brain Achievement: Get accepted answers in GitHub Discussions
# Usage: bash scripts/farm-galaxy-brain.sh [COUNT]
# Run from repo root
#
# IMPORTANT: This requires TWO accounts!
#   - Nightline-debug asks questions
#   - Lukes-Git-Beginning answers them
#   - Nightline-debug marks answers as accepted
#
# This script helps create discussions and answers via the API.
# You'll need to switch accounts for some steps.
#
# Tiers:
#   Base:   2 accepted answers
#   Bronze: 8 accepted answers
#   Silver: 16 accepted answers
#   Gold:   32 accepted answers
#
# PREREQUISITE: Enable Discussions in repo Settings -> Features -> Discussions

set -e

COUNT=${1:-2}
REPO="Lukes-Git-Beginning/achievement-playground"
OWNER="Lukes-Git-Beginning"
REPO_NAME="achievement-playground"

echo "=== Galaxy Brain Achievement Helper ==="
echo "Target: $COUNT accepted answers"
echo ""
echo "PREREQUISITES:"
echo "  1. GitHub Discussions must be enabled in repo settings"
echo "  2. You need access to the Nightline-debug account"
echo ""

# Get the repository ID for GraphQL
REPO_ID=$(MSYS_NO_PATHCONV=1 gh api graphql -f query='
  query {
    repository(owner: "'"$OWNER"'", name: "'"$REPO_NAME"'") {
      id
    }
  }
' --jq '.data.repository.id' 2>/dev/null)

if [ -z "$REPO_ID" ]; then
  echo "ERROR: Could not get repository ID."
  echo "Make sure Discussions are enabled in the repo settings first!"
  exit 1
fi

echo "Repository ID: $REPO_ID"

# Get the General discussion category ID
CATEGORY_ID=$(MSYS_NO_PATHCONV=1 gh api graphql -f query='
  query {
    repository(owner: "'"$OWNER"'", name: "'"$REPO_NAME"'") {
      discussionCategories(first: 10) {
        nodes {
          id
          name
        }
      }
    }
  }
' --jq '.data.repository.discussionCategories.nodes[] | select(.name == "Q&A") | .id' 2>/dev/null)

if [ -z "$CATEGORY_ID" ]; then
  echo ""
  echo "ERROR: No 'Q&A' discussion category found."
  echo ""
  echo "MANUAL STEPS REQUIRED:"
  echo "  1. Go to: https://github.com/$REPO/settings"
  echo "  2. Enable 'Discussions' under Features"
  echo "  3. The 'Q&A' category should be created automatically"
  echo "  4. Re-run this script"
  exit 1
fi

echo "Q&A Category ID: $CATEGORY_ID"
echo ""
echo "================================================================"
echo "MANUAL WORKFLOW (repeat $COUNT times):"
echo "================================================================"
echo ""
echo "For each iteration:"
echo ""
echo "  STEP 1 - Switch to Nightline-debug account:"
echo "    gh auth login  (login as Nightline-debug)"
echo "    OR use a different browser/incognito"
echo ""
echo "  STEP 2 - Create a question (as Nightline-debug):"
echo "    Go to: https://github.com/$REPO/discussions/new?category=q-a"
echo "    Title: 'Question #N'"
echo "    Body: 'How do I do X?'"
echo ""
echo "  STEP 3 - Switch back to Lukes-Git-Beginning:"
echo "    gh auth login  (login as Lukes-Git-Beginning)"
echo "    OR use your main browser"
echo ""
echo "  STEP 4 - Answer the question (as Lukes-Git-Beginning):"
echo "    Go to the discussion and write an answer"
echo ""
echo "  STEP 5 - Switch to Nightline-debug again:"
echo "    Mark the answer as 'Accepted Answer'"
echo "    (Click the checkmark next to the answer)"
echo ""
echo "  STEP 6 - Repeat for next question"
echo ""
echo "================================================================"
echo ""
echo "TIP: Use two different browsers (e.g., Chrome + Firefox)"
echo "     to stay logged in with both accounts simultaneously."
echo ""
echo "Tier progress needed:"
echo "  Base (2):    $([ $COUNT -ge 2 ] && echo 'Will reach' || echo "Need $((2 - COUNT)) more")"
echo "  Bronze (8):  $([ $COUNT -ge 8 ] && echo 'Will reach' || echo "Need $((8 - COUNT)) more")"
echo "  Silver (16): $([ $COUNT -ge 16 ] && echo 'Will reach' || echo "Need $((16 - COUNT)) more")"
echo "  Gold (32):   $([ $COUNT -ge 32 ] && echo 'Will reach' || echo "Need $((32 - COUNT)) more")"
