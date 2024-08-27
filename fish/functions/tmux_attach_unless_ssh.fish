# Attach to a tmux session, or create a new one if none exists.
# If in an SSH session, list current tmux sessions instead.
# https://github.com/rafi/.config
function tmux_attach_unless_ssh --description 'list tmux session if in SSH, otherwise attach and/or create a new session'
	if not status is-login; or set -q TMUX; or not command -q tmux
		return
	end
	# In SSH sessions, list tmux sessions on log-in.
	if set -q SSH_TTY
		set -l sessions (tmux list-sessions -F '[#S] (#{session_windows} )   #W  #{user}@#H #{pane_title}  󰨱 #{t:window_activity}' 2>/dev/null)
		if test -n "$sessions"
			echo "tmux sessions:"
			for s in (string split '\n' $sessions)
				echo -- '-' $s
			end
		end
	else
		# Auto-attach (or new session)
		tmux attach 2>/dev/null || tmux new-session -A -s main
	end
end
