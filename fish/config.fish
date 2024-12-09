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
set -g fish_key_bindings fish_vi_key_bindings

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
fish_add_path ~/.local/bin/pnpm
fish_add_path "$XDG_DATA_HOME/yarn/global/node_modules/.bin"
fish_add_path "$LOCAL_PREFIX/opt/ruby/bin"
fish_add_path "$KREW_ROOT/bin"
fish_add_path "$PIPX_BIN_DIR"
fish_add_path "$RYE_HOME/shims"
fish_add_path ~/.local/bin
fish_add_path node_modules/.bin/
# fish_add_path bin/

# }}}
# Key-bindings {{{
# See /opt/homebrew/share/fish/functions/fish_vi_key_bindings.fish

# Disable Escape in Normal mode.
bind \e true

# Map Ctrl-] to yazi function (see functions/yy.fish)
bind \c] yy
bind -M insert \c] yy

# Complete autosuggestion with Ctrl-f in both normal and insert modes.
bind \cF accept-autosuggestion
bind -M insert \cF accept-autosuggestion

# Mix-in some emacs bindings.
bind \cA beginning-of-line
bind -M insert \cA beginning-of-line
bind \cE end-of-line
bind -M insert \cE end-of-line
bind \cP up-or-search
bind -M insert \cP up-or-search
bind \cN down-or-search
bind -M insert \cN down-or-search

# }}}
# zoxide https://github.com/ajeetdsouza/zoxide {{{
if command -q zoxide
	# PERF: ~3ms
	zoxide init fish | source
end

# }}}
# atuin https://github.com/atuinsh/atuin {{{
if command -q atuin
	# PERF: ~14ms
	atuin init fish --disable-up-arrow | source
end

# }}}
# Source .env file, if available. {{{
if test -f "$XDG_CONFIG_HOME/.env"
	envsource "$XDG_CONFIG_HOME/.env"
end
# }}}

# File list colors. (nice ones: rose-pine, nord, snazzy, one-dark, jellybeans)
# TODO: Needed at all? 15-09-2024
# set -gx LS_COLORS (cat "$XDG_CONFIG_HOME/vivid/snazzy.dircolors")

# Attach or create tmux session on login. If in SSH, only list sessions.
tmux_attach_unless_ssh

# vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
