#!/usr/bin/env bash

# Grepping and Parsing
# https://github.com/rafi/.config

# rga (ripgrep-all) + fzf-tmux
# find-in-file - usage: fif <searchTerm> or fif "string with spaces" or fif "regex"
# fif() {
# 	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
# 	local file
# 	file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && open "$file"
# }

function fif() {
	INITIAL_QUERY="$*"
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	export FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'"

	FZF="fzf"
	HEIGHT="50%"
	if [ -n "$TMUX" ]; then
		FZF="fzf-tmux"
		HEIGHT="100%"
	fi

	"$FZF" --bind \
		"ctrl-d:page-down,ctrl-u:page-up,ctrl-y:yank,tab:down,btab:up,change:reload:$RG_PREFIX {q} || true" \
		--ansi --phony --query "$INITIAL_QUERY" \
		--height="$HEIGHT" --layout=reverse
}

#  vim: set ft=sh ts=2 sw=2 tw=80 noet :
