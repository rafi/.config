#!/usr/bin/env bash
#
# Git hook to protect commits from forbidden words,
# and also allow and/or deny specific branch.
# https://github.com/rafi/.config

# Redirect output to stderr
exec 1>&2

abort()
{
	echo "$@" 1>&2; exit 1
}

main()
{
	text_file="$(git config --path hooks.protect.text-file)"
	branch_allow="$(git config --path hooks.protect.branch-allow)"
	branch_deny="$(git config --path hooks.protect.branch-deny)"

	# Prepend git-dir if forbidden file path is relative
	if [ "${text_file:0:1}" != "/" ]; then
		text_file="$(git rev-parse --git-dir)/${text_file}"
	fi

	# Make sure text_file exists
	if [ ! -f "$text_file" ]; then
		abort "[hooks.protect] Unable to open text file: $text_file, aborting."
	fi

	# Stop accidental commits to protected branches
	current_branch=$(git symbolic-ref HEAD 2>/dev/null)
	if [ "$current_branch" != "$branch_allow" ]; then
		abort "[hooks.protect] Must commit to '$branch_allow' branch, aborting."
	fi
	if [ "$current_branch" == "$branch_deny" ]; then
		abort "[hooks.protect] Must NOT commit to '$branch_deny' branch, aborting."
	fi

	# Prepare list of staged files, exit if none
	diff=$(git diff --cached --name-only)
	[ -z "$diff" ] && return

	# Prevent protected data to be committed
	while read line
	do
		echo $diff | \
			GREP_COLOR='4;4;37;41' xargs grep --color --with-filename -n $line && \
			abort "[hooks.protect] $file contains sensitive data, aborting."
	done < "$text_file"
}

if test $(git config --bool hooks.protect.enabled) = true; then
	main
fi

# Exit safely, don't rely on read's exit code
exit 0
