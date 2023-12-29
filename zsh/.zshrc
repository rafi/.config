# zshrc
# ---

zcompare() {
	if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
		zcompile "${1}"
	fi
}

source "$HOME/.config/bash/exports"
zcompare "${ZDOTDIR:-${HOME}}/.zshrc"
eval "$(sheldon \
	--config-file="$XDG_CONFIG_HOME"/sheldon/plugins.zsh.toml \
	--data-dir="$XDG_DATA_HOME"/sheldon/zsh source)"

#  vim: set ts=2 sw=2 tw=80 noet :
