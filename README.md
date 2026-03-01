# Achievement Playground

A mock repository for farming GitHub profile achievements.

## Achievements Targeted

| Achievement | Target Tier | Script |
|---|---|---|
| Quickdraw | One-time | `scripts/quickdraw.sh` |
| YOLO | One-time | `scripts/yolo.sh` |
| Pull Shark | Gold (1024 PRs) | `scripts/farm-pull-shark.sh` |
| Pair Extraordinaire | Gold (48 PRs) | `scripts/farm-pair-extraordinaire.sh` |
| Galaxy Brain | Gold (32 answers) | `scripts/farm-galaxy-brain.sh` |

## Usage

See [GUIDE.md](GUIDE.md) for full instructions.

```bash
# One-time achievements
bash scripts/quickdraw.sh
bash scripts/yolo.sh

# Farming (run from repo root)
bash scripts/farm-pair-extraordinaire.sh 48
bash scripts/farm-pull-shark.sh 976
```
