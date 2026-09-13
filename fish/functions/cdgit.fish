function cdgit --wraps='gits cd'
	cd -- "$(gits cd $argv)" || echo "Unable to cd"
end
