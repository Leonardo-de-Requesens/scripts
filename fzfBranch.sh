#!/bin/bash
# I use this as a function in my .zshrc

folder=$(pwd)
if [ "$folder" = *"worktree"* ]; then
    branch=$(git worktree list | awk '{print $1}' | fzf)
    cd $branch
else
    branch=$(git branch | fzf)
    branch_clean=${branch/"*"}
    branch_clean=$(echo "$branch_clean" | xargs )
    git checkout $branch_clean 2>/dev/null
fi

