# tm - Create and attach to tmux session, or switch to existing one.
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the session if it exists, or create it
# https://github.com/rafi/.config
function tm --description 'start or attach tmux session'
	if set -q argv[1]
		tmux switch-client -t "$(tmux new-session -dP -s "$argv[1]")"
		return
	end

	set -f mode attach-session
	set -q TMUX; and set mode switch-client;

	set -f fmt '#S (#{session_windows} )   #W  #{user}@#H #{pane_title}  󰨱 #{t:window_activity} 󰟩 #{socket_path}'
	set -f session (tmux list-sessions -F $fmt 2>/dev/null | fzf -1 -0 | awk '{print $1}')
	tmux $mode -t $session 2>/dev/null || tmux new-session -A -s main
end
