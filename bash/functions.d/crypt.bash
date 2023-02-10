#!/usr/bin/env bash

# bash/aliases
# https://github.com/rafi/.config

function b64enc() {
	echo -n "$1" | base64 | pbcopy
	pbpaste
	echo >&2 'Copied to clipboard.'
}

function b64dec() {
	echo -n "$1" | base64 --decode
}
