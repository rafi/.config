# Credits: https://github.com/camspiers/dotfiles
# This tmux statusbar config was created by tmuxline.vim
# on Fri, 27 Dec 2019

set -g status-justify "centre"
set -g status-left-style "none"
set -g message-command-style "fg=#3B4252,bg=#81A1C1"
set -g status-right-style "none"
set -g pane-active-border-style "fg=#88C0D0"
set -g status-style "none,bg=#4C566A"
set -g message-style "fg=#3B4252,bg=#81A1C1"
set -g pane-border-style "fg=#81A1C1"
set -g status-right-length "100"
set -g status-left-length "100"

setw -g window-status-activity-style "none,fg=#88C0D0,bg=#4C566A"
setw -g window-status-separator ""
setw -g window-status-style "none,fg=#E5E9F0,bg=#4C566A"

set -g status-left "#[fg=#3B4252,bg=#88C0D0] #S #[fg=#88C0D0,bg=#81A1C1,nobold,nounderscore,noitalics]#[fg=#3B4252,bg=#81A1C1] #(whoami) #[fg=#81A1C1,bg=#4C566A,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#88C0D0,bg=#4C566A,nobold,nounderscore,noitalics]#[fg=#3B4252,bg=#88C0D0] %R  %a  %Y "

setw -g window-status-format "#[fg=#4C566A,bg=#4C566A,nobold,nounderscore,noitalics]#[default] #I  #W #[fg=#4C566A,bg=#4C566A,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#4C566A,bg=#81A1C1,nobold,nounderscore,noitalics]#[fg=#3B4252,bg=#81A1C1] #I  #W #[fg=#81A1C1,bg=#4C566A,nobold,nounderscore,noitalics]"

#  vim: set ft=tmux ts=2 sw=2 tw=80 noet :
