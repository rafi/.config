# Go functions
# https://github.com/rafi/.config
# ---

# Golang - go get or tidy
function gg() {
	if [ -z "$1" ]; then
		go mod tidy -v
	else
		go get -u "$@"
	fi
}

# Golang - show outdated, indirect dependencies
function go-outdated() {
	go list -u -m -f '{{ if and (not .Indirect) .Update }}{{.}}{{end}}' all
}

# Python - delete all packages in virtualenv
function pip-wipeout() {
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

function brew-installed() {
	brew leaves --installed-on-request
}

# Show latest modified brew packages.
# https://stackoverflow.com/a/67845884/351947
function brew-latest() {
	CELLAR="$(brew --prefix)/Cellar"
	jq -nr --arg cellar "$CELLAR" '
		[inputs | {time, file: (input_filename|sub($cellar;"") | sub("/INSTALL_RECEIPT.json";""))}]
		| sort_by(.time)[-40:][]
		| .file
	' "$CELLAR"/*/*/INSTALL_RECEIPT.json
}
