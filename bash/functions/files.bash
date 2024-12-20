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

# Show processes hogging files
function openedfiles() {
	sysctl kern.maxfiles
	sysctl kern.maxfilesperproc
	sudo lsof -n +c 0 | cut -f1 -d' ' | uniq -c | sort | tail
	echo
	sudo lsof -n +c 0 | sed -E 's/^[^ ]+[ ]+([^ ]+).*$/\1/' | uniq -c | sort | tail
}

# yazi! https://github.com/sxyazi/yazi
if hash yazi 2>/dev/null; then
	alias lf=yazi

	function lfcd() {
		local tmp; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
		yazi "$@" --cwd-file="$tmp"
		if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
			cd -- "$cwd" || echo "Unable to cd"
		fi
		rm -f -- "$tmp"
	}

	# Use <C-]> to change working directory in shell to last dir in yazi.
	bind '"\C-]":"lfcd\C-m"'

# lf https://github.com/gokcehan/lf
# Change working dir in shell to last dir in lf on exit (adapted from ranger).
elif hash lf 2>/dev/null; then
	function lfcd() {
		# `command` is needed in case `lfcd` is aliased to `lf`
		cd "$(command lf -print-last-dir "$@")" || echo "Unable to cd"
	}

	# Use <C-]> to change working directory in shell to last dir in lf.
	bind '"\C-]":"lfcd\C-m"'
fi

# gits https://github.com/rafi/gits
# cdgit - change directory to selected repository with gits.
if hash gits 2>/dev/null; then
	cdgit() {
		cd "$(gits cd "$@")" || echo "Unable to cd"
	}

	# Use <C-t> to change directory to selected repository with gits.
	bind '"\C-t":"cdgit\C-m"'
fi

# vim: set ts=2 sw=2 tw=80 noet :
