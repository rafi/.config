# rafi palette
# ---

set -l foreground CFCFCF
set -l selection 30302c
set -l comment 686868
set -l description B58858
set -l completion f8f8f2

set -l red D370A3
set -l orange ffb86c
set -l yellow f1fa8c
set -l green 50fa7b
set -l purple bd93f9
set -l cyan 8be9fd
set -l pink ff79c6

# Default Prompt Colors
set -g fish_color_cwd blue
set -g fish_color_cwd_root red
set -g fish_color_host 5D7C33
set -g fish_color_host_remote 5D7C33
set -g fish_color_user B58858
set -g fish_color_status $red  # last command status

# Git Prompt Colors
set -g __fish_git_prompt_color_branch 6D9E3F
set -g __fish_git_prompt_color_prefix 484868
set -g __fish_git_prompt_color_suffix 484868
# Custom
set -g __rafi_prompt_color_symbol 6D9E3F
set -g __rafi_git_prompt_color_atsign 888888

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment
set -g fish_color_cancel $red --reverse
set -g fish_color_option $orange
set -g fish_color_history_current --bold
set -g fish_color_valid_path --underline

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_background
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $completion
set -g fish_pager_color_description $description
set -g fish_pager_color_selected_background --background=44475a
set -g fish_pager_color_selected_prefix $cyan
set -g fish_pager_color_selected_completion $completion
set -g fish_pager_color_selected_description $description
set -g fish_pager_color_secondary_background
set -g fish_pager_color_secondary_prefix $cyan
set -g fish_pager_color_secondary_completion $completion
set -g fish_pager_color_secondary_description $description

# vim: set ft=fish ts=2 sw=2 tw=80 noet :
