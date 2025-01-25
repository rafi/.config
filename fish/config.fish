# config.fish      _▄▄
# _▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█●_█                        O  o
# █  - ◄█▘ ◦ ▝█  -▄█  █ ---------.        _\_   o
# ▜▄▄█▄▄█▄▄█▄▄█▄▄███▄▄▛        * |     \\/  o\ .
# github.com/rafi/.config      # |     //\___=
#                              # |        ''
# EXIT HERE IF NOT INTERACTIVE # |
status is-interactive || exit  # |
# `------------------------------'


# Visual {{{
set fish_greeting
set fish_emoji_width 2
set fish_term24bit 1

# Cursor styles.
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

# Prompt path length.
set -g fish_prompt_pwd_dir_length 2

# Prompt git info.
set -g __fish_git_prompt_show_informative_status true
# set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_showcolorhints true

# }}}
# Paths {{{
fish_add_path "$LOCAL_PREFIX"/bin "$LOCAL_PREFIX"/sbin
fish_add_path "$GOPATH/bin"
fish_add_path "$XDG_DATA_HOME/cargo/bin"
fish_add_path "$XDG_DATA_HOME/yarn/global/node_modules/.bin"
fish_add_path "$LOCAL_PREFIX/opt/ruby/bin"
fish_add_path "$KREW_ROOT/bin"
fish_add_path "$PIPX_BIN_DIR"
fish_add_path "$RYE_HOME/shims"
fish_add_path ~/.local/bin
fish_add_path node_modules/.bin/
# fish_add_path ~/.local/bin/pnpm

# }}}
# Key-bindings {{{
# See /opt/homebrew/share/fish/functions/fish_vi_key_bindings.fish
# and /opt/homebrew/share/fish/functions/fish_default_key_bindings.fish

# key-bindings: fish_hybrid_key_bindings, fish_hybrid_key_bindings
set -g fish_key_bindings fish_vi_key_bindings

# Map Ctrl-] to yazi function (see functions/yy.fish)
bind ctrl-\] yy
bind -M insert ctrl-\] yy

# Complete autosuggestion with Ctrl-f in both normal and insert modes.
bind ctrl-f accept-autosuggestion
bind -M insert ctrl-f accept-autosuggestion

# Mix-in some emacs bindings.
bind -M insert ctrl-a beginning-of-line
bind -M insert ctrl-e end-of-line
bind -M insert ctrl-p up-or-search
bind -M insert ctrl-n down-or-search

bind -M insert ctrl-g "commandline -a ' | grep \'\''" end-of-line backward-char
bind ctrl-a beginning-of-line
bind ctrl-e end-of-line
bind ctrl-p up-or-search
bind ctrl-n down-or-search

# }}}
# zoxide https://github.com/ajeetdsouza/zoxide {{{
if command -q zoxide
	zoxide init fish | source
end

# }}}
# atuin https://github.com/atuinsh/atuin {{{
if command -q atuin
	atuin init fish --disable-up-arrow | source
end

# }}}
# Source .env file, if available. {{{
if test -f "$XDG_CONFIG_HOME/.env"
	envsource "$XDG_CONFIG_HOME/.env"
end
# }}}

# Attach or create tmux session on login. If in SSH, only list sessions.
tmux_attach_unless_ssh

# vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
