function cdd --wraps=fd
	fd -I --type d $argv | fzf | read selection
	test -z $selection; and return 1
	cd -- $selection || echo "Unable to cd"
end

function cdf --wraps=fd
	fd -I --type f $argv | fzf | read selection
	test -z $selection; and return 1
	cd -- (dirname $selection) || echo "Unable to cd"
end
