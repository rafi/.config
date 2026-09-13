#!/usr/bin/env bash

# I use this as mutt's pager
echo
echo '­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­'
echo
exec fribidi "$@" \
	| bat -l Email --theme=TwoDark --color=always --style plain --paging=always --terminal-width 150 --pager "less -RJLMws -+F"
