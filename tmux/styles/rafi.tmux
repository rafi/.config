# My grey scheme

# General look 'n feel
# ---

# *-attr options accept: none, bright (or bold), dim, underscore, blink,
#                        reverse, hidden, or italics.
set -g mode-style fg=colour11,bg=colour236,none
set -g message-style fg=colour11,bg=colour236,none
set -g message-command-style fg=colour253,bg=colour236,none
set -g pane-border-style fg=colour240,bg=default
set -g pane-active-border-style fg=colour4,bg=colour235

set -g display-panes-active-colour colour220
set -g display-panes-colour colour74

setw -g clock-mode-colour colour64
setw -g clock-mode-style 24

# Status line
#-------------------------------------------------

set -g status-justify left
set -g status-style fg=colour239,bg=colour236,default

set -g status-left-length 15
set -g status-left-style fg=colour254,bg=colour241,none
set -g status-left '#{?client_prefix,#[fg=colour236]#[bg=colour2],} #S #{?client_prefix,#[fg=colour2],#[fg=colour241]}#[bg=colour235]#[fg=colour234,bg=colour236]░'

set -g status-right-length 90
set -g status-right-style fg=colour240,bg=default,none
set -g status-right "#[fg=colour234]#[fg=colour238,bg=colour234] #(kubectl config current-context 2>/dev/null | tail -c 35) #[fg=colour235]#[fg=colour239,bg=colour235] 󰍛 #(uptime | sed 's/.*load average[^0-9]*//;s/,//g') #[fg=colour236]#[fg=colour241,bg=colour236] #(batt) #[fg=colour237]#[fg=colour243,bg=colour237] %H:%M #[fg=colour238]#[fg=colour244,bg=colour238] #H "

setw -g window-style ''
setw -g window-active-style ''
setw -g pane-active-border-style ''

setw -g window-status-separator ""
setw -g window-status-format " #[fg=colour243]#I#[fg=colour247]#F#[fg=default]#W #[fg=colour236,bg=colour235]#[fg=colour234,bg=default]░"
setw -g window-status-style fg=colour247,bg=colour236,none
setw -g window-status-current-style fg=colour251,bg=colour239,none
setw -g window-status-current-format "#[fg=colour235]░#[fg=colour235]#I#[fg=colour235]#F#[fg=default]#W #[fg=colour238]#[fg=colour239,bg=colour235]#[fg=colour234,bg=colour236]░"

setw -g window-status-activity-style fg=colour254,bg=colour236,none
setw -g window-status-bell-style fg=colour169,bg=colour236,none
setw -g window-status-last-style fg=colour247,bg=colour236,none

#  vim: set ft=tmux ts=2 sw=2 tw=80 noet :
