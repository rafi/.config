# File functions
# https://github.com/rafi/.config

# Create and enter directory
function mk() {
	mkdir -p "$@" && cd "$1" || echo "Unable to cd into $1"
}

# Jump x directories up
function up() {
	local path i
	[ "$1" ] || set 1
	for ((i = 0; i < $1; i++)); do
		path="$path../"
	done
	cd "$path" || echo "Unable to cd into $path"
}

# diff-so-fancy with regular files
function dsf() {
	diff -u "$1" "$2" | diff-so-fancy | less
}

# See https://github.com/gokcehan/lf
if hash lf 2>/dev/null; then
	lfcd () {
		tmp="$(mktemp)"
		# `command` is needed in case `lfcd` is aliased to `lf`
		command lf -last-dir-path="$tmp" "$@"
		if [ -f "$tmp" ]; then
			dir="$(cat "$tmp")"
			rm -f "$tmp"
			if [ -d "$dir" ]; then
				if [ "$dir" != "$(pwd)" ]; then
					cd "$dir" || return
				fi
			fi
		fi
	}
fi

# Show processes hogging files
function openedfiles() {
	sysctl kern.maxfiles
	sysctl kern.maxfilesperproc
	sudo lsof -n +c 0 | cut -f1 -d' ' | uniq -c | sort | tail
	echo
	sudo lsof -n +c 0 | sed -E 's/^[^ ]+[ ]+([^ ]+).*$/\1/' | uniq -c | sort | tail
}

# vim: set ts=2 sw=2 tw=80 noet :
