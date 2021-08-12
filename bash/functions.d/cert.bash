#!/usr/bin/env bash

# Certificate functions
# https://github.com/rafi/.config

ssl-info() {
	openssl s_client \
			-servername "$1" \
			-connect "$1":443 </dev/null 2>&1 \
		| openssl x509 -noout -issuer -subject -fingerprint -serial -dates
}

# vim: set ts=2 sw=2 tw=80 noet :
