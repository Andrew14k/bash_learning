#!/bin/bash

# Check args are correct
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <repository-url> \"commit message\""
  echo "Example: ./git-push-to-repo.sh https://github.com/user/repo.git \"Updated code\""
  exit 1
fi

REPO_URL="$1"
COMMIT_MESSAGE="$2"
REMOTE_NAME="origin"

# Check if the folder is already a git repo
if [ ! -d .git ]; then
  echo "📁 Not a Git repository. Initializing..."
  git init
  git remote add $REMOTE_NAME "$REPO_URL"
else
  # already a Git repo, ensure remote is set to the provided URL
  git remote remove $REMOTE_NAME 2> /dev/null
  git remote add $REMOTE_NAME "$REPO_URL"
fi

# add changes
git add .

#  commit changes
git commit -m "$COMMIT_MESSAGE"

# detect current branch
CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)

# If no branch yet, create and checkout main
if [ -z "$CURRENT_BRANCH" ]; then
  CURRENT_BRANCH="main"
  git checkout -b "$CURRENT_BRANCH"args are correct
fi

# Push to the specified repo and branch
git push -u $REMOTE_NAME "$CURRENT_BRANCH"

echo "Changes pushed to $REPO_URL on branch '$CURRENT_BRANCH' with message: '$COMMIT_MESSAGE'"

# to run: ./bash_auto.sh https://github.com/Andrew14k/repo.git "Commit Message"


