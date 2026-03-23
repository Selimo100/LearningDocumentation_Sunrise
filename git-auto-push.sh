#!/bin/bash
set -euo pipefail

# === CONFIG ===
REPO_DIR="/Users/selina/Library/Mobile Documents/iCloud~md~obsidian/Documents/ICloud_Vault/Sunrise/Lernjournal"
BRANCH="main"
LOG_FILE="/Users/selina/git-auto-push.log"

# === RUN ===
{
  echo "----- $(date +'%Y-%m-%d %H:%M:%S') -----"

  cd "$REPO_DIR"

  if ! command -v git >/dev/null 2>&1; then
    echo "Error: git not found in PATH. PATH=$PATH"
    exit 1
  fi

  if [ ! -d .git ]; then
    echo "Error: $REPO_DIR is not a Git repository."
    exit 1
  fi

  if [[ -n "$(git status --porcelain)" ]]; then
    echo "Changes detected."
    git add -A

    if git diff --cached --quiet; then
      echo "Nothing staged after add -A. Skipping."
      exit 0
    fi

    COMMIT_MESSAGE="Daily commit: $(date +'%Y-%m-%d %H:%M:%S')"
    git commit -m "$COMMIT_MESSAGE"
    git push origin "$BRANCH"
    echo "Committed and pushed successfully."
  else
    echo "No changes to commit."
  fi
} >> "$LOG_FILE" 2>&1
