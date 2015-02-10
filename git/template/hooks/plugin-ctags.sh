#!/usr/bin/env bash
#
# Git hook for ctags
# https://github.com/rafi/.config

# Runs ctags if enabled in git config
main()
{
	if test $(git config --bool hooks.ctags.enabled) = true; then
		ctags &
	fi
}
main
