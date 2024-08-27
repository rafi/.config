# FZF fish setup
# github.com/rafi/.config

set fzf_keymaps \
	ctrl-d:half-page-down \
	ctrl-u:half-page-up \
	ctrl-f:preview-half-page-down \
	ctrl-b:preview-half-page-up \
	ctrl-g:toggle-preview \
	ctrl-t:toggle-preview-wrap \
	ctrl-y:yank \
	alt-a:select-all \
	alt-d:deselect-all \
	shift-up:toggle+up \
	shift-down:toggle+down \
	tab:down \
	btab:up

set -gx FZF_DEFAULT_OPTS \
	--ansi \
	--reverse \
	--cycle \
	--info=hidden \
	--border \
	--separator ━ \
	--ellipsis … \
	--margin 0,5% \
	--color dark \
	--color info:6,prompt:2,pointer:2,marker:3,spinner:1,header:4,preview-fg:#6F7478,preview-bg:#17191B \
	--bind (string join ',' $fzf_keymaps)
# 	--exact \

set -gx FZF_DEFAULT_COMMAND \
	rg \
	--vimgrep \
	--files \
	--follow \
	--hidden \
	--no-ignore-vcs \
	--smart-case \
	"--glob='!**/.git/*'"

set -gx _ZO_FZF_OPTS \
	"$FZF_DEFAULT_OPTS --keep-right --exit-0 --select-1" \
	"--preview='command eza {2..}' --preview-window=bottom"

if type --query fzf_configure_bindings
	set -g fzf_fd_opts --hidden --exclude .git
end
