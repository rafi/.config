# zshrc
# ---

zcompare() {
	if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
		zcompile "${1}"
	fi
}

unsetopt extendedglob
setopt nomatch notify nobgnice
setopt autocd autopushd pushdignoredups pushdsilent pushdtohome
setopt histfindnodups histignoredups histignorespace histverify sharehistory
setopt interactivecomments noclobber longlistjobs

# Keybindings
export KEYTIMEOUT=1
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

source "$HOME/.config/bash/exports"
source "$HOME/.config/bash/aliases"
source "$HOME/.config/zsh/utils.zsh"

autoload -Uz compinit && compinit

zcompare "${ZDOTDIR:-${HOME}}/.zshrc"

# Enable readline vi-mode for myself only
# See ./functions.d/ssh.bash for implementation
if [ "${LC_IDENTIFICATION:-$USER}" = rafi ] \
	|| [[ "${LC_IDENTIFICATION:-$USER}" == rafael* ]]
then
	set -o vi
	source "$HOME/.config/zsh/vi-cursor.zsh"
fi

#  vim: set ts=2 sw=2 tw=80 noet :
