# Grepping and Parsing
# https://github.com/rafi/.config

# Fuzzy find files and edit selected in vim.
# Dependencies: fzf, ripgrep, bat
function ffi() {
	BAT_ENV=BAT_STYLE=changes,header-filename,numbers
	rg --color=always --line-number --no-heading --smart-case "${*:-}" |
		fzf --ansi --multi --delimiter : \
			--color "hl:-1:underline,hl+:-1:underline:reverse" \
			--preview="$BAT_ENV bat --color=always {1} --highlight-line {2}" \
			--preview-window 'right,50%,border-left,+{2}+3/3,~1' |
		sed 's/:.*//g' |
		xargs "$EDITOR" -O
}

# Fuzzy grep and edit selected in vim.
# Dependencies: fzf, ripgrep, bat
function fif() {
	INITIAL_QUERY="$*"
	BAT_ENV=BAT_STYLE=changes,header-filename,numbers
	RG_PREFIX='rg --column --line-number --no-heading --color=always --smart-case'
	FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")"
	export FZF_DEFAULT_COMMAND

	fzf --nth 1 --delimiter : --ansi --phony --query "$INITIAL_QUERY" \
		--height="50%" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--preview="$BAT_ENV bat --color=always {1} --highlight-line {2}" \
		--preview-label "Hey hey" \
		--preview-window 'right,50%,border-left,nowrap,+{2}+3/3,~1' |
		awk -F: '{print $1 " +" $2}' | xargs "$EDITOR"
}

#  vim: set ft=sh ts=2 sw=2 tw=80 noet :
