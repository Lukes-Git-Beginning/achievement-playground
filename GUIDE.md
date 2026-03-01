# GitHub Achievements Farming Guide

## Account Setup

| Role | Account | Purpose |
|---|---|---|
| Main | `Lukes-Git-Beginning` | Achievements appear here |
| Helper | `Nightline-debug` | Co-author & discussion interaction |

---

## Achievement Overview

| # | Achievement | Tier Goal | Method | Estimated Time |
|---|---|---|---|---|
| 1 | Quickdraw | One-time | Open+close issue | 1 min |
| 2 | YOLO | One-time | Merge PR without review | 2 min |
| 3 | Pair Extraordinaire | Gold (48 PRs) | Co-authored PRs | ~30 min |
| 4 | Pull Shark | Gold (1024 PRs) | Auto-merge PRs | ~5-6 hrs |
| 5 | Galaxy Brain | Gold (32 answers) | Discussions Q&A | ~1 hr (manual) |
| 6 | Public Sponsor | One-time | $1 sponsorship | 2 min |
| 7 | Starstruck | Base (16 stars) | Build useful project | Ongoing |

---

## Step-by-Step Instructions

### Prerequisites
1. `gh` CLI installed and authenticated as `Lukes-Git-Beginning`
2. Repo pushed to GitHub as public
3. Run all scripts from the repo root directory

### Step 1: Enable Discussions (MANUAL)
1. Go to https://github.com/Lukes-Git-Beginning/achievement-playground/settings
2. Scroll to "Features"
3. Check "Discussions"
4. Save

### Step 2: Quickdraw (1 minute)
```bash
bash scripts/quickdraw.sh
```

### Step 3: YOLO (2 minutes)
```bash
bash scripts/yolo.sh
```

### Step 4: Pair Extraordinaire + Pull Shark (combined)
Run 48 co-authored PRs first (counts for BOTH achievements):
```bash
bash scripts/farm-pair-extraordinaire.sh 48
```

### Step 5: Pull Shark (remaining)
After Pair Extraordinaire is done, you need 1024 - 48 = 976 more PRs:
```bash
bash scripts/farm-pull-shark.sh 976
```

**Note:** You can run this in batches if needed:
```bash
bash scripts/farm-pull-shark.sh 100 1    # PRs 1-100
bash scripts/farm-pull-shark.sh 100 101  # PRs 101-200
# ... etc
```

### Step 6: Galaxy Brain (manual, needs 2 browsers)
```bash
bash scripts/farm-galaxy-brain.sh 32
```
Follow the printed instructions. Use two browsers:
- **Browser 1** (Chrome): Logged in as `Lukes-Git-Beginning`
- **Browser 2** (Firefox/Incognito): Logged in as `Nightline-debug`

For each of the 32 iterations:
1. **Nightline-debug**: Create Q&A discussion with a question
2. **Lukes-Git-Beginning**: Reply with an answer
3. **Nightline-debug**: Click checkmark to mark as "Accepted Answer"

### Step 7: Public Sponsor (MANUAL, costs $1+)
1. Go to https://github.com/sponsors
2. Find any developer/project to sponsor
3. Choose $1/month tier
4. Complete sponsorship
5. Achievement unlocked immediately
6. You can cancel the sponsorship next month if you want

---

## Tier Progress Tracker

### Pull Shark
- [ ] Base: 2 merged PRs
- [ ] Bronze: 16 merged PRs
- [ ] Silver: 128 merged PRs
- [ ] Gold: 1024 merged PRs

### Pair Extraordinaire
- [ ] Base: 1 co-authored PR
- [ ] Bronze: 10 co-authored PRs
- [ ] Silver: 24 co-authored PRs
- [ ] Gold: 48 co-authored PRs

### Galaxy Brain
- [ ] Base: 2 accepted answers
- [ ] Bronze: 8 accepted answers
- [ ] Silver: 16 accepted answers
- [ ] Gold: 32 accepted answers

### One-Time Achievements
- [ ] Quickdraw
- [ ] YOLO
- [ ] Public Sponsor

---

## Troubleshooting

**Achievements don't appear:**
- Wait up to 24 hours - GitHub processes achievements in batches
- Check your profile: https://github.com/Lukes-Git-Beginning

**Rate limiting errors:**
- The scripts have built-in pauses (3s between PRs, 30s every 10 PRs)
- If you hit limits, wait 10-15 minutes and resume with the START parameter:
  ```bash
  bash scripts/farm-pull-shark.sh 50 101  # Start from PR #101
  ```

**Git conflicts:**
- Run `git checkout main && git pull origin main` to reset

**Co-Author not recognized:**
- The email must match the GitHub noreply email exactly
- Current: `264815089+Nightline-debug@users.noreply.github.com`

**Discussions not available:**
- Enable in repo Settings -> Features -> Discussions
- The Q&A category must exist (usually created automatically)
