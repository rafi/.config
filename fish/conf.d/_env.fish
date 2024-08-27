# Fish variables
# github.com/rafi/.config

# XDG dirs
set -qU XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -qU XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -qU XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -qU XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
# set -qU XDG_RUNTIME_DIR; or set -Ux XDG_RUNTIME_DIR /var/run

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

# OS detection
set -g OS_DARWIN false
set -g OS_LINUX false
set -g LOCAL_PREFIX /usr/local
switch (uname)
	case Linux
		set -g OS_LINUX true
	case Darwin
		set -g OS_DARWIN true
		if test (uname -m) = arm64
			set -g LOCAL_PREFIX /opt/homebrew
		end
	case '*'
		echo 'OS not supported.'
end

# Editor and browser
if command -q nvim
	set -gx EDITOR $LOCAL_PREFIX/bin/nvim
else
	set -gx EDITOR $LOCAL_PREFIX/bin/vim
end
set -gx VISUAL $EDITOR
set -gx BROWSER open

# Xorg
set -gx XINITRC "$XDG_CONFIG_HOME/xorg/xinitrc"
set -gx XAUTHORITY "$XDG_CACHE_HOME/Xauthority"

# Pagers
set -gx MANPAGER "nvim +'set cmdheight=2' +Man!"

# Less
if not set -q LESSVERSION
	set -Ux LESSVERSION (less -V | head -n1 | awk '{print $2}')
end
set -gx PAGER less
set -gx LESS "-FiQMXRW"
if test $LESSVERSION -gt 580
	set -gx LESS $LESS '--incsearch'
end
set -gx LESSCHARSET UTF-8
set -gx LESSHISTFILE "$XDG_CACHE_HOME/less_history"
set -gx LESSKEY "$XDG_CONFIG_HOME/lesskey/output"
# On newer versions of less, use the following to support Nerdfonts.
set -gx LESSUTFCHARDEF "E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p"

# Package managers and tools settings
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx INTELLI_SKIP_ESC_BIND 1
set -gx PYTHON_COLORS 1
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
set -gx _ZO_ECHO 1

# Misc XDG
set -gx AWS_CONFIG_FILE "$HOME/docs/aws/config"
set -gx AWS_SHARED_CREDENTIALS_FILE "$HOME/docs/aws/credentials"
set -gx CLOUDSDK_CONFIG "$XDG_STATE_HOME/gcloud"
set -gx GNUPGHOME "$XDG_CONFIG_HOME/gnupg"
set -gx INPUTRC "$XDG_CONFIG_HOME/bash/inputrc"
set -gx PASSWORD_STORE_DIR "$HOME/docs/pass/"
set -gx ZDOTDIR "$XDG_CONFIG_HOME/zsh"

set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
set -gx GEMRC "$XDG_CONFIG_HOME/gemrc/config"
set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem/specs"
set -gx GOPATH "$XDG_DATA_HOME"/go
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx PIPX_BIN_DIR "$XDG_DATA_HOME/python/pipx/bin"
set -gx PIPX_HOME "$XDG_DATA_HOME/python/pipx"
set -gx POETRY_CACHE_DIR "$XDG_CACHE_HOME"/pypoetry
set -gx POETRY_CONFIG_DIR "$XDG_CONFIG_HOME"/pypoetry
set -gx POETRY_DATA_DIR "$XDG_DATA_HOME"/pypoetry
set -gx POETRY_VIRTUALENVS_PATH "$XDG_DATA_HOME"/python/poetry
set -gx PYENV_ROOT $XDG_DATA_HOME/python/pyenv
set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -gx RYE_HOME $XDG_DATA_HOME/python/rye

set -gx CUPS_CACHEDIR "$XDG_STATE_HOME/cups"
set -gx CUPS_STATEDIR "$XDG_STATE_HOME/cups"
set -gx CUPS_DATADIR "$XDG_STATE_HOME/cups"
set -gx COINTOP_CONFIG "$XDG_CONFIG_HOME/cointop/config.toml"
set -gx INTELLI_HOME "$XDG_STATE_HOME/intellishell"
set -gx JIG_SESSION_CONFIG_PATH "$HOME/.local/opt/jig"
set -gx JK_DIRS "$XDG_DATA_HOME/tldr:$HOME/docs/cheatsheets"
set -gx KREW_ROOT "$XDG_DATA_HOME/krew"
set -gx KUBECTL_EXTERNAL_DIFF 'diff -u -N --color=always'
set -gx LIMA_HOME "$XDG_DATA_HOME/lima"
set -gx MINIKUBE_HOME "$XDG_DATA_HOME/minikube"
set -gx MPV_HOME "$XDG_CONFIG_HOME/mpv"
set -gx MYSQL_HISTFILE "$XDG_CACHE_HOME/mysql_history"
set -gx PACKER_CACHE_DIR "$XDG_CACHE_HOME/packer"
set -gx PGCLIRC "$XDG_CONFIG_HOME/pgcli/config"
set -gx PSQLRC "$XDG_CONFIG_HOME/psql/config"
set -gx PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -gx PYTHON_HISTORY "$XDG_CACHE_HOME/python_history"
set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/rc"
set -gx SQLITE_HISTORY "$XDG_CACHE_HOME/sqlite_history"
set -gx TASKDATA "$XDG_DATA_HOME/task"
set -gx TASKRC "$XDG_CONFIG_HOME/task/config"
set -gx VAGRANT_HOME "$XDG_DATA_HOME/vagrant"
set -gx WEGORC "$XDG_CONFIG_HOME/wego/config"
set -gx ZK_NOTEBOOK_DIR "$HOME/code/rafi/rafi.io/content"
set -gx _ZO_DATA_DIR "$XDG_STATE_HOME/zoxide"
