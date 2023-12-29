# Git functions
# https://github.com/rafi/.config
# ---
# See: https://git-scm.com/
#      https://github.com/junegunn/fzf

## Git branches
alias gball="git branch --sort=-committerdate --all --color=always --format \
	'%(refname:short) %(if)%(upstream)%(then)-> %(upstream)%(end)'"
gbf() { gball | fzf --ansi | awk '{print $1}'; }

# List of branches sorted by last commit date
function gbl() {
	git branch -r "$@" | grep -v HEAD \
		| xargs -n 1 git log --color=always --no-merges -n 1 \
			--pretty="tformat:%C(yellow)%ci{%C(green)%ar{%C(blue)<%an>{%C(auto)%D%C(reset)" \
		| sort -r | sed -E 's/^[^{]+{//g' | column -t -s '{' | less -FXRS
}

# Checkout git branch/tag, with a branch preview.
function gbs() {
	git for-each-ref --format="%(refname)" refs/heads refs/tags --sort=-committerdate | \
		awk '{sub(/^refs\/tags\//, "\x1b[31;1mtag\x1b[m\t "); sub(/^refs\/heads\//, "\x1b[34;1mbranch\x1b[m\t ")} {print}' | \
		fzf --no-hscroll --no-multi --delimiter=" " -n 2 \
			--ansi --preview="git-branch-overview {2}" --preview-window=right,70% | \
		awk '{print $2}' | \
		xargs git checkout
}

# git commit browser
function glf() {
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
function gstash() {
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
function greclone() {
	dir="$(basename "$PWD")"
	[ -d "../${dir}.orig" ] && echo "${dir}.orig already exists" && exit 1
	repo="$(git remote get-url "$(git remote)")"
	echo -e "dir: $dir\nrepo: $repo"
	cd ..
	mv "$dir" "${dir}.orig"
	git clone --recursive "$repo" "$dir"
	echo "recloned $dir < $repo"
}

# vim: set ts=2 sw=2 tw=80 noet :
