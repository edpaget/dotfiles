#!/usr/bin/env bash
# Prints git branch and dirty status for the current tmux pane's working directory.

pane_path="$1"
cd "$pane_path" 2>/dev/null || exit 0

branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
[ -z "$branch" ] && exit 0

dirty=""
if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
  dirty="*"
fi

echo "#[fg=#859900] ${branch}${dirty}"
