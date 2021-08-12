#!/usr/bin/env bash

# Git functions
# https://github.com/rafi/.config
# ---
# See: https://git-scm.com/
#      https://github.com/junegunn/fzf

# List of branches sorted by last commit date
gbl() {
	git branch -r "$@" | grep -v HEAD \
		| xargs -n 1 git log --color=always --no-merges -n 1 \
			--pretty="tformat:%C(yellow)%ci{%C(green)%ar{%C(blue)<%an>{%C(auto)%D%C(reset)" \
		| sort -r | sed -E 's/^[^{]+{//g' | column -t -s '{' | less -FXRS
	}

# Checkout git branch/tag, with a preview showing the commits
# between the tag/branch and HEAD
gbs() {
	local tags branches target
	tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t " $1}') || return
	branches=$(git branch -vv --color=always --sort=-committerdate "$@" |
		grep -v HEAD | sed "s/^[ *]*//" |
		awk '{print "\x1b[34;1mbranch\x1b[m\t " $0}') || return
	target=$( ([ -n "$tags" ] && echo "$tags"; echo "$branches") |
		fzf --no-hscroll --no-multi --delimiter=" " -n 2 \
			--ansi --preview="git-branch-overview {2}" ) || return
	git checkout "$(echo "$target" | awk '{print $2}' | sed "s#remotes/[^/]*/##")"
}

# git commit browser
glf() {
	git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
	fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
		--bind "ctrl-m:execute:
			(grep -o '[a-f0-9]\{7\}' | head -1 |
				xargs -I % sh -c 'git show --color=always % | LESS='' less -iQMXR'
			) << 'FZF-EOF'
			{}
FZF-EOF"
}

# Easier way to deal with stashes
# type gstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
gstash() {
	local out q k sha
	while out=$(
		git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
			fzf --ansi --no-sort --query="$q" --print-query \
				--expect=ctrl-d,ctrl-b);
	do
		mapfile -t out <<< "$out"
		q="${out[0]}"
		k="${out[1]}"
		sha="${out[-1]}"
		sha="${sha%% *}"
		[[ -z "$sha" ]] && continue
		if [[ "$k" == 'ctrl-d' ]]; then
			git diff "$sha"
		elif [[ "$k" == 'ctrl-b' ]]; then
			git stash branch "stash-$sha" "$sha"
			break;
		else
			git stash show -p "$sha"
		fi
	done
}

# Reclone a GitHub repository
greclone() {
	dir="$(basename "$PWD")"
	[ -d "../${dir}.orig" ] && echo "${dir}.orig already exists" && exit 1
	echo "dir: $dir"
	repo="$1"
	[ -n "$repo" ] || read -rp 'enter repo> ' repo
	repo="git@github.com:${repo/.git/}.git"
	cd ..
	mv "$dir" "${dir}.orig"
	git clone --recursive "$repo" "$dir"
	echo "recloned $dir < $repo"
}

# vim: set ts=2 sw=2 tw=80 noet :
