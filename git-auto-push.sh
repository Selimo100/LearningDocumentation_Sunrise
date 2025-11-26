#!/bin/bash

# Daily commit and push script for Obsidian vault or any Git repo
# This script checks for changes, commits them with a timestamp, and pushes to origin main (or master if needed)

BRANCH="main"  # Change to 'master' if your repo uses master

# Check if it's a Git repo
if [ ! -d .git ]; then
    echo "Error: This is not a Git repository."
    exit 1
fi

# Check for uncommitted changes
if [[ -n $(git status --porcelain) ]]; then
    echo "Changes detected. Committing and pushing..."

    # Add all changes
    git add .

    # Commit with current date as message
    COMMIT_MESSAGE="Daily commit: $(date +'%Y-%m-%d %H:%M:%S')"
    git commit -m "$COMMIT_MESSAGE"

    # Push to origin
    git push origin "$BRANCH"

    echo "Committed and pushed successfully."
else
    echo "No changes to commit."
fi
