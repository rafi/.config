# zsh/utils
# ---
# github.com/rafi/.config

# zsh-users/zsh-completions
# zsh-users/zsh-autosuggestions
# zdharma-continuum/fast-syntax-highlighting
# zsh-users/zsh-syntax-highlighting
# zsh-users/zsh-history-substring-search
# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' history-substring-search-down
# bindkey -M viins '^P' history-substring-search-up
# bindkey -M viins '^N' history-substring-search-down
# wfxr/forgit
# export -r FORGIT_NO_ALIASES=1

# Vivid https://github.com/sharkdp/vivid
# nice ones: rose-pine, nord, snazzy, one-dark, jellybeans
LS_COLORS="$(vivid generate snazzy)"
export LS_COLORS

# See https://github.com/junegunn/fzf
# fzf_keymaps=(
# 	ctrl-d:half-page-down
# 	ctrl-u:half-page-up
# 	ctrl-f:preview-half-page-down
# 	ctrl-b:preview-half-page-up
# 	ctrl-t:toggle-preview-wrap
# 	ctrl-y:yank
# 	shift-up:toggle+up
# 	shift-down:toggle+down
# 	tab:down
# 	btab:up
# )
# keymaps="$(printf ",%s" "${fzf_keymaps[@]}")"
# export FZF_DEFAULT_OPTS="--margin 1,5% --border --info=inline-right --separator ━ --reverse --height 100% --bind ${keymaps:1}"
export FZF_DEFAULT_COMMAND='rg --vimgrep --files --follow --hidden --no-ignore-vcs --smart-case --glob !**/.git/*'
# unset fzf_keymaps keymaps

# # See https://github.com/junegunn/fzf
# if [ -f "$PREFIX/opt/fzf/shell/key-bindings.bash" ]; then
# 	. "$PREFIX/opt/fzf/shell/key-bindings.bash"
# fi

if hash zoxide 2>/dev/null; then
	export _ZO_ECHO=1
	export _ZO_DATA_DIR="$XDG_CACHE_HOME/zoxide"
	eval "$(zoxide init zsh)"
fi

# # Work with multiple versions of Python via https://github.com/pyenv/pyenv
# # But don't overcast shims when inside an activated virtualenv sub-shell.
# if [ -z "$VIRTUAL_ENV" ] && hash pyenv 2>/dev/null; then
# 	export PYENV_ROOT="${XDG_DATA_HOME}/python/pyenv"
# 	export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# 	eval "$(pyenv init --no-push-path -)"
# fi

# Rye
if [ -f "$XDG_DATA_HOME/python/rye/env" ]; then
	. "$XDG_DATA_HOME/python/rye/env"
fi

# Initialize Atuin setup scripts, without the default key-bindings.
# Manually bind <C-r> and <C-p> for history browsing.
if hash atuin 2>/dev/null; then
	# source ~/.atuin
	eval "$(ATUIN_NOBIND=true atuin init zsh)"
	bindkey -M emacs '^r' atuin-search
	bindkey -M viins '^r' atuin-search-viins
	bindkey -M vicmd '/' atuin-search
	# bindkey -M emacs '^[[A' atuin-up-search
	# bindkey -M vicmd '^[[A' atuin-up-search-vicmd
	# bindkey -M viins '^[[A' atuin-up-search-viins
	# bindkey -M emacs '^[OA' atuin-up-search
	# bindkey -M vicmd '^[OA' atuin-up-search-vicmd
	# bindkey -M viins '^[OA' atuin-up-search-viins
	bindkey -M vicmd 'k' atuin-up-search-vicmd
fi

# Pretty prompt.
eval "$(starship init zsh)"

# vim: set ts=2 sw=2 tw=80 noet :
