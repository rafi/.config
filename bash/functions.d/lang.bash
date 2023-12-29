# Go functions
# https://github.com/rafi/.config
# ---

# Golang - show outdated, indirect dependencies
function go-outdated() {
	go list -u -m -f '{{ if and (not .Indirect) .Update }}{{.}}{{end}}' all
}

# Python - delete all packages in virtualenv
function wipeenv() {
	pip freeze --exclude-editable --require-virtualenv | xargs pip uninstall -y
}

function pip-outdated() {
	pip list --outdated
}

# Node.js - show only requested dependencies from a shallow yarn list
function yarn-deps() {
	# preload installed dependencies, remove first and last lines
	roster="$(yarn list --depth 0 2>/dev/null | awk '{print $2}' | sed '1d;$d')"
	# match each dependency (from package.json) to the preloaded list
	while IFS= read -r dependency; do
		echo "${roster}" | GREP_OPTIONS='' grep --color=never "^${dependency}@"
	done <<< "$(jq -r '.dependencies,.devDependencies|keys[]' package.json)"
}
