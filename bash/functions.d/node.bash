#!/usr/bin/env bash

# Node.js functions
# https://github.com/rafi/.config

# show only requested dependencies from a shallow yarn list
function yarndeps() {
	# preload installed dependencies, remove first and last lines
	roster="$(yarn list --depth 0 2>/dev/null | awk '{print $2}' | sed '1d;$d')"
	# match each dependency (from package.json) to the preloaded list
	while IFS= read -r dependency; do
		echo "${roster}" | GREP_OPTIONS='' grep --color=never "^${dependency}@"
	done <<< "$(jq -r '.dependencies,.devDependencies|keys[]' package.json)"
}

# vim: set ts=2 sw=2 tw=80 noet :
