#!/usr/bin/env bash

# Vim functions
# https://github.com/rafi/.config

# Fuzzy grep files with fzf, ripgrep, bat and edit selected in vim
function vgf() {
	IFS=: read -ra selected < <(
		rg --color=always --line-number --no-heading --smart-case "${*:-}" |
			fzf --ansi \
				--color "hl:-1:underline,hl+:-1:underline:reverse" \
				--delimiter : \
				--preview 'bat --color=always {1} --highlight-line {2}' \
				--preview-window 'down,60%,border-top,+{2}+3/3,~3'
	)
	[ -n "${selected[0]}" ] && vim "${selected[0]}" "+${selected[1]}"
}

# Grep files with fzf, ripgrep, bat and edit selected in vim
function vg() {
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
	INITIAL_QUERY="${*:-}"
	IFS=: read -ra selected < <(
		FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
		fzf --ansi \
				--disabled --query "$INITIAL_QUERY" \
				--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
				--delimiter : \
				--preview 'bat --color=always {1} --highlight-line {2}' \
				--preview-window 'down,60%,border-bottom,+{2}+3/3,~3'
	)
	[ -n "${selected[0]}" ] && vim "${selected[0]}" "+${selected[1]}"
}

# Interactively select Vim session with fzf
function vs() {
	SESSIONS="$XDG_DATA_HOME/nvim/sessions"
	VIM=vim
	hash nvim 2>/dev/null && VIM=nvim
	find "$SESSIONS" -type f -printf '%Cs %f\n' \
		| sed 's/\.vim$//g' \
		| sort -r \
		| awk "{print \$2}" \
		| fzf --no-multi --no-sort \
			--prompt='(Choose session):' --header=$'────────────\n\n' \
		| xargs -I'{}' "$VIM" -S "$SESSIONS/{}.vim"
}

# vim: set ts=2 sw=2 tw=80 noet :
