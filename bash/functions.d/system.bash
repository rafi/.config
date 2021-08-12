#!/usr/bin/env bash

# System functions
# https://github.com/rafi/.config

# Quickly grep a process
function psg() {
	# shellcheck disable=2009
	ps auxww | grep -i --color=always "$@" | grep -v "grep.*${*}"
}

# Filter and process with fzf and kill it
function psk() {
	(date; ps -ef) | fzf \
		--bind='ctrl-r:reload(date; ps -ef)' \
		--header=$'Press CTRL-R to reload\n\n' --header-lines=2 \
		--preview='echo {}' --preview-window=down,3,wrap \
		--layout=reverse --height=80% | awk '{print $2}' | xargs kill -9
}

# Select command name with fzf and show memory usage
function psmem() {
	ps -o rss= -p "$(pidof "$(ps -ec | fzf | awk '{print $4}')")" \
		| awk '{print $1*4, "KiB"}'
}

# Top 15 cpu heavy process
function topcpu() {
	ps -ceo pmem,pid,pcpu,rss,vsz,time,command \
		| awk 'NR<2{print $0;next}{print $0| "sort -k 3 -r"}' | head -15
}

# Top 15 memory heavy process
function topmem() {
	ps -ceo pmem,pid,pcpu,rss,vsz,time,command | sort -k 1 -r | head -15 \
		| awk '
				function human(x) {
					if (x < 1000) { return x }
					x /= 1024;
					s = "MGTEPYZ";
					while (x >= 1000 && length(s) > 1) {
						x /= 1024;
						s = substr(s, 2)
					}
					return int(x + 0.5) substr(s, 1, 1)
				}
				{
					if (NR > 1) {
						sub($4, human($4));
						sub($5, human($5));
					}
					print
				}'
}

# vim: set ts=2 sw=2 tw=80 noet :
