# Rafi's Grey Beard

set -g status on
set -g status-position top
set -g status-interval 3

# *-attr options accept: none, bright (or bold), dim, underscore, blink,
#                        reverse, hidden, or italics.

set -wg mode-style bg="#373737",fg="#CABC8B"    # window screen colors
set -g message-style bg="#373737",fg="#CABC8B"  # message area
set -g message-command-style bg="#A89984",fg="#3C3836"  # message area inactive

set -g display-panes-active-colour '#FE1A52'  # display pane active number
set -g display-panes-colour '#FEB9CA'         # display pane inactive number
set -wg clock-mode-colour '#FE1A52'           # clock color

# copy mode highlighting
%if #{>=:#{version},3.2}
	set -wg copy-mode-match-style "bg=#A89984,fg=#3C3836"
	set -wg copy-mode-current-match-style "bg=#FE1A52,fg=#FFFFFF"
%endif

# Status line
#-------------------------------------------------

set -g status-justify left
set -g status-style fg=colour239,bg=terminal,none
# set -g status-style fg=colour239,bg=colour236,default

set -g status-left-length 15
set -g status-left-style fg=colour254,bg=colour241,none
set -g status-left '#{?client_prefix,#[fg=colour236]#[bg=colour2],} #S #{?client_prefix,#[fg=colour2],#[fg=colour241]}#[bg=colour235]#[fg=colour234,bg=colour236]░#[default]'

set -g status-right-length 90
set -g status-right-style fg=colour247,bg=colour238,none
set -g status-right "#[fg=colour234,bg=terminal]#[fg=colour238,bg=colour234] #(test kubectl && (kubectl config current-context 2>/dev/null | sed 's/.*_//' | tail -c 35)) #[fg=colour235]#[fg=colour239,bg=colour235] 󰍛 #(uptime | sed 's/.*load average[^0-9]*//;s/,//g') #[fg=colour236]#[fg=colour241,bg=colour236] #(batt) #[fg=colour237]#[fg=colour243,bg=colour237] %H:%M #[default,reverse,fg=colour237]#[default] #H "

if-shell -b '[ -n "${SSH_TTY}" ]' {
	set -g status-right-style fg=colour1,bg=colour235,none
}

set -g pane-active-border-style "fg=#{?pane_synchronized,colour198,colour4},bg=default"
set -g pane-border-style "fg=#{?pane_synchronized,colour198,colour240},bg=default"

# set -g pane-active-border-style "bg=default,#{?window_zoomed_flag,fg=colour61,#{?pane_synchronized,fg=colour37,fg=colour166}}"
# set -g pane-border-format " #[bold,fg=colour231,#{?window_zoomed_flag,bg=colour61,#{?pane_synchronized,bg=colour37,#{?pane_active,bg=colour166,bg=colour245}}}] #{?window_zoomed_flag,Z,#P} \
# #[#{?window_zoomed_flag,fg=colour61,#{?pane_synchronized,fg=colour37,#{?pane_active,fg=colour166,fg=colour245}}},bg=default,nobold] \
# #[bold]#{s|Development/Projects|D/P|;s|/Users/bfrank|~|:pane_current_path}#[nobold] \
# #[align=right] #{pane_current_command} "
# set -g pane-border-lines "heavy"

# set -g pane-active-border-style "bg=default,#{?window_zoomed_flag,fg=colour61,#{?pane_synchronized,fg=colour37,fg=colour166}}"
# set -g pane-border-format "#[#{?window_zoomed_flag,fg=colour61,#{?pane_synchronized,fg=colour37,#{?pane_active,fg=colour166,fg=colour245}}}]#{?window_zoomed_flag, ZOOM ,}"
# set -g pane-border-lines "heavy"
# set -g pane-border-style "bg=default,#{?pane_synchronized,fg=colour37,fg=colour245}"
# set -g pane-border-status top

# Transparent?
setw -g window-style "bg=terminal"
# setw -g window-style "bg=#1D1F21"
# setw -g window-active-style "bg=terminal"

setw -g window-status-separator ""
# #44412C #504D34
setw -g window-status-style "fg=colour247,bg=#{?window_zoomed_flag,#44412C,#{?pane_synchronized,#403434,colour236}},none"
setw -g window-status-format " #[fg=colour243]#I#[fg=colour247]#F#[fg=default]#W #[reverse,fg=colour235]#[fg=colour234,bg=default]░#[default]"
setw -g window-status-current-style "fg=colour251,bg=#{?window_zoomed_flag,#797243,#{?pane_synchronized,#6A4A4A,colour239}},none"
setw -g window-status-current-format "#[fg=colour235]░#[fg=colour235]#I#[fg=colour235]#F#[fg=default]#W #[reverse,fg=colour235]#[fg=colour234,bg=colour236]░#[default]"

setw -g window-status-activity-style fg=colour254,bg=colour236,none
setw -g window-status-bell-style fg=colour169,bg=colour236,none
setw -g window-status-last-style fg=colour247,bg=colour236,none

#  vim: set ft=tmux ts=2 sw=2 tw=80 noet :
