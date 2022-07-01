#!/usr/bin/env bash

# Bash functions
# https://github.com/rafi/.config
# ---
# See: https://tiswww.case.edu/php/chet/bash/bashtop.html

function bashquote() {
	printf '%q\n' "$(cat)"
}

function do5() {
	# shellcheck disable=2068
	for _ in {1..5}; do $@; done
}

# vim: set ts=2 sw=2 tw=80 noet :
