#!/usr/bin/env bash

# tmux functions
# https://github.com/rafi/.config

# tm - Create and attach new tmux session, or switch to existing one.
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the edit session if it exists, or create it
function tm() {
	[[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
	if [ -n "$1" ]; then
		tmux "$change" -t "$1" 2>/dev/null || \
			(tmux new-session -d -s "$1" && tmux $change -t "$1")
		return
	else
		session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0)
		tmux "$change" -t "$session" || echo "No sessions found."
	fi
}

function _tm() {
	TMUX_SESSIONS=$(tmux ls -F '#S' | xargs)
	local cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$TMUX_SESSIONS" -- $cur) )
}

complete -o filenames -o nospace -F _tm tm

# vim: set ts=2 sw=2 tw=80 noet :
