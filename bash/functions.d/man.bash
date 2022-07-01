#!/usr/bin/env bash

# Man functions
# https://github.com/rafi/.config

# View man pages in OSX Preview.app
function manpdf() { man -t "$@" | ps2pdf - - | open -f -a Preview; }

# Man page coloring using less
function man() {
	env \
		LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
		LESS_TERMCAP_md="$(printf "\e[0;35m")" \
		LESS_TERMCAP_me="$(printf "\e[0m")" \
		LESS_TERMCAP_se="$(printf "\e[0m")" \
		LESS_TERMCAP_so="$(printf "\e[1;47;30m")" \
		LESS_TERMCAP_ue="$(printf "\e[0m")" \
		LESS_TERMCAP_us="$(printf "\e[0;34m")" \
		man "$@"
}
