# Super SSH: safe terminfo, persist user name, tmux window name
function ssh --wraps ssh
	# Use safest terminfo on remote server
	if [ -n "$TMUX" ]
		set -gx TERM screen-256color
	else
		set -gx TERM xterm
	end

	# Propagate local user name, for remote goodies.
	# But don't overwrite environment variable if it's not empty.
	if not set -q LC_IDENTIFICATION
		set -gx LC_IDENTIFICATION "$USER"
	end

	# Rename tmux window
	test -n "$TMUX"; and tmux rename-window "$argv[1..-1]" 1>/dev/null

	# Execute ssh with identification
	if command -q assh
		assh wrapper ssh -- -o SendEnv=LC_IDENTIFICATION "$argv"
	else
		command ssh -o SendEnv=LC_IDENTIFICATION "$argv"
	end

	# Reset tmux window name
	test -n "$TMUX"
	and tmux set-window-option automatic-rename "on" 1>/dev/null

	commandline -f repaint
end
