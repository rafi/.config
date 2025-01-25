# Super SSH: safe terminfo, persist user name, tmux window name
function ssh --wraps ssh
	# Use safest terminfo on remote server
	set -l SSH_TERM xterm-256color
	if set -q TMUX
		set SSH_TERM screen-256color
		# Rename tmux window
		set -l title (string match --invert -- '-*' $argv)
		set -l session (tmux display-message -p '#{session_id}:#{window_id}')
		test -n "$title"; and tmux rename-window "$title" 1>/dev/null
	end

	# Propagate local user name, for remote goodies.
	# But don't overwrite environment variable if it's not empty.
	if not set -q LC_IDENTIFICATION
		set -gx LC_IDENTIFICATION "$USER"
	end

	# Execute ssh with identification
	set -l ssh_status 0
	if command -q assh
		TERM=$SSH_TERM assh wrapper ssh -- -o SendEnv=LC_IDENTIFICATION $argv
		or set ssh_status $status
	else
		TERM=$SSH_TERM command ssh -o SendEnv=LC_IDENTIFICATION $argv
		or set ssh_status $status
	end
	# Reset tmux window name
	set -q TMUX; and tmux set-window-option -t "$session" automatic-rename on

	return $ssh_status
end
