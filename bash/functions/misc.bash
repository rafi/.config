# Misc functions
# https://github.com/rafi/.config

function do5() {
	# shellcheck disable=2068
	for _ in {1..5}; do $@; done
}

# Shuffle words
function shufflewords() {
	local url='https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-usa-no-swears-medium.txt'
	local count="${1:-4}"
	curl -s "$url" | shuf -n"$count" | tr -d '\n'
}

# Spellcheck with aspell
function spell() {
	echo "$@" | aspell -a | grep -Ev "^@|^$"
}

# Query dictionary server
function dict() {
	curl dict://dict.org/d:"$*"
}

# Show active aria2 downloads with diana
function da() {
	watch -ctn 3 "(echo '\033[32mGID\t\t Name\t\t\t\t\t\t\t%   Down   Size Speed    Up   S/L Time\033[36m'; \
		diana list| cut -c -112; echo '\033[37m'; diana stats)"
}

# vim: set ts=2 sw=2 tw=80 noet :
