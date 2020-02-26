#!/usr/bin/env bash

# branches sorted by last commit date
gbs() {
  git branch -r "$@" | grep -v HEAD \
    | xargs -n 1 git log --color=always --no-merges -n 1 \
      --pretty="tformat:%C(yellow)%ci{%C(green)%ar{%C(blue)<%an>{%C(auto)%D%C(reset)" \
    | sort -r | sed -E 's/^[^{]+{//g' | column -t -s '{' | less -FXRS
}

# fbr - checkout git branch/tag, with a preview showing the commits
# between the tag/branch and HEAD
fbr() {
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t " $1}') || return
  branches=$(git branch --all -vv --color=always |
    grep -v HEAD | sed "s/^[ *]*//" |
    awk '{print "\x1b[34;1mbranch\x1b[m\t " $0}') || return
  target=$( ([ -n "$tags" ] && echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter=" " -n 2 \
        --ansi --preview="git-branch-overview {2}" ) || return
  git checkout "$(echo "$target" | awk '{print $2}' | sed "s#remotes/[^/]*/##")"
}

# fshow - git commit browser
fshow() {
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

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
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
