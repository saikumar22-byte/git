#!/bin/bash

FILE="welcome.txt"

cat << EOF > $FILE
Welcome to your DevOps & Git practice environment!

Current Date & Time: $(date)
Logged in User: $(whoami)
System Uptime: $(uptime -p)

Disk Usage:
/bin/df -h | grep '^/dev/'

Home Directory Listing:
$(ls -lah ~)

----------------------------
# Git Repository Overview
----------------------------

EOF

# Check if we are inside a git repository
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  {
    echo "Repository Path: $(git rev-parse --show-toplevel)"
    echo "Current Branch: $(git branch --show-current)"
    echo "Latest Commit:"
    git log -1 --pretty=format:"  %h - %an, %ar : %s"
    echo
    echo "Status Summary:"
    git status -s
    echo
    echo "Untracked files (if any):"
    git ls-files --others --exclude-standard
    echo
    echo "Remotes URL(s):"
    git remote -v
    echo
    echo "Last Fetch/Push:"
    git reflog --date=relative | head -10
  } >> $FILE
else
  echo "No git repository detected in the current directory." >> $FILE
fi

echo -e "\nTip: Use this information to explore Git commands and workflows.\n"

echo "Welcome file '$FILE' created with system and Git info."


