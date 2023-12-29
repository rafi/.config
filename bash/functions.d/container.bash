# Container/image functions
# https://github.com/rafi/.config
# ---
# See: https://github.com/google/go-containerregistry/blob/main/cmd/crane/doc/crane.md

function imginspect() {
	repo="$1"
	target="$(crane ls "$repo" \
		| sort -Vfr \
		| fzf --no-sort --no-multi --prompt='Tags: ')" || return
	crane config "${repo}:${target}" | fx
}

# vim: set ts=2 sw=2 tw=80 noet :
