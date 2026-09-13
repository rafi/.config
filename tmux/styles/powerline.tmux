# Powerline
# ---

set -g status on
set -g status-position bottom
set -g status-interval 3

set -g pane-border-style fg=#81A1C1
set -g pane-active-border-style fg=#88C0D0
set -g message-style fg=#3B4252,bg=#81A1C1
set -g message-command-style fg=#3B4252,bg=#81A1C1

set -g status-left-style none
set -g status-left-length 100
set -g status-left "#[fg=colour246,bg=colour238] #S #{?client_prefix,#[bg=colour2],#[bg=colour244]}#[fg=colour238,nobold,nounderscore,noitalics]#[fg=colour236] #(whoami) #[fg=colour244,bg=default,nobold,nounderscore,noitalics]"

set -g status-right-style none
set -g status-right-length 100
set -g status-right "#[fg=colour242,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour242] #h "

set -g status-justify "centre"
set -g status-style none,bg=colour236
setw -g window-status-separator ""
setw -g window-status-style fg=colour250,bg=colour236,none
setw -g window-status-format "#[fg=colour236,bg=#4C566A,nobold,nounderscore,noitalics]#[fg=default] #I  #W #[fg=#4C566A,bg=colour236,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=colour236,bg=#81A1C1,nobold,nounderscore,noitalics]#[fg=#3B4252,bg=#81A1C1] #I  #W #[fg=#81A1C1,bg=default,nobold,nounderscore,noitalics]"
setw -g window-status-activity-style none,fg=#88C0D0,bg=#4C566A

# set -g status-bg black
# set -g status-fg colour243
# set -g mode-bg colour67
# set -g mode-fg colour235
# set -g pane-border-fg colour240
# set -g pane-active-border-fg colour6
# set -g window-status-bg black
# set -g window-status-current-bg colour239
# set -g window-status-current-fg colour250
# set -g window-status-current-attr bold
# set -g window-status-activity-attr bold
# setw -g window-status-activity-bg colour234
# setw -g window-status-activity-fg brightblue
# set -g status-left-length 30
# set -g status-left '#{?client_prefix,#[bg=green]#[fg=black],#[fg=red]}(#S) #(whoami)'
# set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'

#  vim: set ft=tmux ts=2 sw=2 tw=80 noet :
