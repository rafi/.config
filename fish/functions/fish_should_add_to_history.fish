# Executed before command is added to history, if return 0. (fish v4+)
function fish_should_add_to_history
	string match -qr "^\s" -- $argv; and return 1
	string match -qr "^clear\$" -- $argv; and return 1
	return 0
end
