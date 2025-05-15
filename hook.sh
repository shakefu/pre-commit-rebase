#!/bin/bash

function main {
    # Get the remote name (usually "origin")
    local remote
    remote=$(git remote)

    # Use the first argument as the default branch, or find the default branch
    local default_branch="$1"
    if [[ -z "$default_branch" ]]; then
        default_branch=$(git remote show "$(git remote -v | grep push | awk '{print $2}')" | grep 'HEAD branch' | awk '{print $3}')
    fi

    # Fallback to "main"
    [[ -n "$default_branch" ]] || default_branch="main"

    # Fetch the default branch for rebasing
    git fetch --verbose --prune "$(git remote)" "$default_branch" || return $?

    # Attempt to rebase onto the remote default automatically
    local target_branch="$remote/$default_branch"

    # Attempt to rebase onto the remote default automatically
    git rebase --verbose --rerere-autoupdate --autostash --allow-empty "$target_branch"
    local result=$?
    [[ $result -eq 0 ]] || git rebase --verbose --abort
    [[ $result -eq 0 ]] || return $result
}

main "$@"
