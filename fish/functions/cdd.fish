function cdd --wraps=fd
	fd -I --type d $argv | fzf | read selection
	test -z $selection; and return 1
	cd -- $selection || echo "Unable to cd"
	# commandline -r ''
	# commandline -f repaint
end
