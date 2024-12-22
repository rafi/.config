function xssh --description 'Connect to remote hosts using xpanes'
	xpanes -ss -tc 'command ssh {}' $argv
end

complete -c xssh -d Remote -k -fa '(__fish_print_hostnames)'
