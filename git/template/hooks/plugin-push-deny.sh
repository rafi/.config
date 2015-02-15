#!/usr/bin/env bash
#
# Git hook to protect branches from being pushed.
# https://github.com/rafi/.config

# Redirect output to stderr
exec 1>&2

abort()
{
	echo "$@" 1>&2; exit 1
}

main()
{
	branch_allow="$(git config --path hooks.push-deny.branch-allow)"
	branch_deny="$(git config --path hooks.push-deny.branch-deny)"
	current_branch=$(git symbolic-ref HEAD 2>/dev/null)

	# Stop accidental pushes of protected branches
	if [ "$current_branch" != "$branch_allow" ]; then
		abort "[hooks.push-deny] Pushing this branch is not allowed."
	fi
	if [ "$current_branch" == "$branch_deny" ]; then
		abort "[hooks.push-deny] Pushing this branch is forbidden."
	fi
}

if test $(git config --bool hooks.push-deny.enabled) = true; then
	main
fi

exit 0
