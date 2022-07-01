#!/usr/bin/env bash

# Misc functions
# https://github.com/rafi/.config

# Spellcheck with aspell
function spell() {
	echo "$@" | aspell -a | grep -Ev "^@|^$"
}

# Show active aria2 downloads with diana
function da() {
	watch -ctn 3 "(echo '\033[32mGID\t\t Name\t\t\t\t\t\t\t%   Down   Size Speed    Up   S/L Time\033[36m'; \
		diana list| cut -c -112; echo '\033[37m'; diana stats)"
}

# vim: set ts=2 sw=2 tw=80 noet :
