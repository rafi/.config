# System functions
# https://github.com/rafi/.config

# Quickly grep a process
function psg() {
	# shellcheck disable=2009
	ps auxww | grep -i --color=always "$@" | grep -v "grep.*${*}"
}

# Filter and process with fzf and kill it
function psk() {
	(
		date
		ps -ef
	) | fzf \
		--bind='ctrl-r:reload(date; ps -ef)' \
		--header=$'Press CTRL-R to reload\n\n' --header-lines=2 \
		--preview='echo {}' --preview-window=down,3,wrap \
		--layout=reverse --height=80% | awk '{print $2}' | xargs kill -9
}

# Top 15 memory heavy processes
function topmem() { _top 1 15; }

# Top 15 cpu heavy processes
function topcpu() { _top 2 15; }

# Select process with fzf and show macOS logs  TODO: support Linux
function toplog() {
	_top "${1:-1}" 0 |
		fzf --header-lines=1 --no-multi |
		awk '{print $6}' |
		xargs -I{} log show --predicate 'processID == {}'
}

# Top processes with human-friendly unit-sizes.
# Args: <sortby> <count>
# Example: _top 1 10
function _top() {
	local sortby="${1:-1}"
	local count="${2:-15}"
	ps -ceo pmem,pcpu,rss,vsz,time,pid,command | sort -k "$sortby" -r |
		awk -f <(
			cat - <<-EOD
				function human(x) {
					if (x < 1000) { return x }
					x /= 1024;
					s = "MGTEPYZ";
					while (x >= 1000 && length(s) > 1) {
						x /= 1024;
						s = substr(s, 2)
					}
					return int(x + 0.5) substr(s, 1, 1)
				}
				{
					if (NR > 1) {
						sub(\$3, human(\$3));
						sub(\$4, human(\$4));
					}
					printf "%5s %5s %5s %5s %8s %7s %s", \$1, \$2, \$3, \$4, \$5, \$6, \$7
					s = ""; for (i = 8; i <= NF; i++) s = s " " \$i; print s;
					if (NR == $count) {
						exit
					}
				}
			EOD
		)
}

# vim: set ts=2 sw=2 tw=80 noet :
