# theme settings

# alignment settings
# set -g status-position bottom
set -g status-justify centre
# window separators
set -wg window-status-separator ""
# monitor window changes
set -wg monitor-activity on
set -wg monitor-bell on
# set statusbar update interval
set -g status-interval 1
### colorscheme ###
# change window screen colors
set -wg mode-style bg="#FE8019",fg="#3C3836"
# default statusbar colors (terminal bg should be #282828)
set -g status-style bg=terminal,fg="#A89984"
# default window title colors
set -wg window-status-style bg="#3C3836",fg="#7C6F64"
# colors for windows with activity
set -wg window-status-activity-style bg="#3C3836",fg="#A89984"
# colors for windows with bells
set -wg window-status-bell-style bg="#3C3836",fg="#FE8019"
# active window title colors
set -wg window-status-current-style bg="#FE8019",fg="#3C3836"
# pane border
set -g pane-active-border-style fg="#FE8019"
set -g pane-border-style fg="#3C3836"
# message info
set -g message-style bg="#FE8019",fg="#3C3836"
# writing commands inactive
set -g message-command-style bg="#A89984",fg="#3C3836"
# pane number display
set -g display-panes-active-colour "#FE8019"
set -g display-panes-colour "#3C3836"
# clock
set -wg clock-mode-colour "#FE8019"
# copy mode highlighting
%if #{>=:#{version},3.2}
    set -wg copy-mode-match-style "bg=#A89984,fg=#3C3836"
    set -wg copy-mode-current-match-style "bg=#FE8019,fg=#3C3836"
%endif
# statusbar formatting
# "#fe8019" MUST be in lowercase here (conflicts with statusline alias otherwise)
set -g status-left-length 26
set -g status-left "#[bg=#A89984, fg=#3C3836]#{?client_prefix,#[bg=#fe8019],#[bg=#A89984]} #{=/20/...:session_name} "
set -g status-right "#[bg=#A89984, fg=#3C3836]#{?client_prefix,#[bg=#fe8019],#[bg=#A89984]} #{user}@#{host} "
set -wg window-status-current-format "#{?window_zoomed_flag,#[fg=default bold],#[fg=default]} #{window_index} #{window_name} "
set -wg window-status-format "#{?window_zoomed_flag,#[fg=default bold],#[fg=default]} #{window_index} #{window_name} "

# Add a blank status bar for a bit more space
set -Fg 'status-format[1]' '#{status-format[0]}'
set -g 'status-format[0]' ''
set -g status 2

#  vim: set ft=tmux ts=2 sw=2 tw=80 noet :
