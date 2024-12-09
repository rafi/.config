# Super SSH: safe terminfo, persist user name, tmux window name
function ssh --wraps ssh
	# Use safest terminfo on remote server
	if set -q TMUX
		set -gx TERM screen-256color
	else
		set -gx TERM xterm
	end

	# Propagate local user name, for remote goodies.
	# But don't overwrite environment variable if it's not empty.
	if not set -q LC_IDENTIFICATION
		set -gx LC_IDENTIFICATION "$USER"
	end

	if set -q TMUX
		# Rename tmux window
		set -l title (string match --invert -- '-*' $argv)
		set -l session (tmux display-message -p '#{session_id}:#{window_id}')
		tmux rename-window "$title" 1>/dev/null
	end

	# Execute ssh with identification
	set -l ssh_status
	if command -q assh
		assh wrapper ssh -- -o SendEnv=LC_IDENTIFICATION $argv
		or set ssh_status $status
	else
		command ssh -o SendEnv=LC_IDENTIFICATION $argv
		or set ssh_status $status
	end
	# Reset tmux window name
	set -q TMUX; and tmux set-window-option -t "$session" automatic-rename "on"

	return $ssh_status
end
