#!/usr/bin/env bash

# tail functions
# https://github.com/rafi/.config

tailgrep() {
	Q="$2"
	: "${Q:="ERROR"}"
	ESC="$(printf '\033')"
	tail -f "$1" | sed "s,$Q,$ESC\[1;31m&$ESC\[0m,g"
}

tailfzf() {
	fzf --preview-window follow --preview 'tail -f {}'

	# With "follow", preview window will automatically scroll to the bottom.
	# "\033[2J" is an ANSI escape sequence for clearing the screen.
	# When fzf reads this code it clears the previous preview contents.
	# fzf --preview-window follow --preview 'for i in $(seq 100000); do
	# 	echo "$i"
	# 	sleep 0.01
	# 	(( i % 300 == 0 )) && printf "\033[2J"
	# done'
}

# vim: set ts=2 sw=2 tw=80 noet :
