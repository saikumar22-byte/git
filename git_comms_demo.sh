#!/bin/bash

# Abort on error
set -e

# Check if inside a git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "This script must be run inside a Git repository!"
  exit 1
fi

echo "Starting Git commands demo in repo: $(git rev-parse --show-toplevel)"
echo

# Create a new test file
echo "Creating test file: demo.txt"
echo "Initial content line 1" > demo.txt

# git status before any changes
echo -e "\n[git status] - before staging:"
git status --short

# Add file to staging
echo -e "\n[git add demo.txt]"
git add demo.txt

# git status after add
echo -e "\n[git status] - after staging:"
git status --short

# Commit the staged file
echo -e "\n[git commit] - commit demo.txt"
git commit -m "Add demo.txt with initial content"

# View log of last commit
echo -e "\n[git log] - last commit:"
git log -1 --oneline

# Modify demo.txt to demonstrate diff
echo -e "\nAdding a second line to demo.txt"
echo "Second line added" >> demo.txt

# Show unstaged changes diff
echo -e "\n[git diff] - show unstaged changes:"
git diff

# Stage the change and show diff --staged
git add demo.txt
echo -e "\n[git diff --staged] - staged changes:"
git diff --staged

# Commit the change
git commit -m "Update demo.txt with second line"

# Show status clean now
echo -e "\n[git status] - after second commit:"
git status --short

# Create and switch to a new branch "feature-branch"
echo -e "\n[git checkout] - creating and switching to feature-branch"
git checkout -b feature-branch

# Make a change on feature branch
echo "Feature branch line" >> demo.txt
git add demo.txt
git commit -m "Add line in feature-branch"

# Show last two commits (log)
echo -e "\n[git log] - last 2 commits on feature-branch:"
git log -2 --oneline

# Switch back to main branch
echo -e "\n[git checkout] - switch back to main"
git checkout main

# Merge feature-branch into main
echo -e "\n[git merge] - merging feature-branch into main"
git merge feature-branch -m "Merge feature-branch into main"

# Show log after merge
echo -e "\n[git log] - last 3 commits after merge:"
git log -3 --oneline

# Demonstrate rename (git mv) of demo.txt
echo -e "\n[git mv] - renaming demo.txt to demo-renamed.txt"
git mv demo.txt demo-renamed.txt
git commit -m "Rename demo.txt to demo-renamed.txt"

# Demonstrate remove file (git rm)
echo -e "\n[git rm] - removing demo-renamed.txt"
git rm demo-renamed.txt
git commit -m "Remove demo-renamed.txt"

# Note on push/pull: We will show commands but avoid automatic push to remote unless confirmed by user

echo
echo "To push changes to remote repository, run:"
echo "  git push origin main"
echo "  git push origin feature-branch"
echo
echo "To pull changes from remote, run:"
echo "  git pull origin main"
echo

echo "Git commands demo completed successfully."

