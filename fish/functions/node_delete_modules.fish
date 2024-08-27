function node_delete_modules
	find . -type d -name node_modules -prune -print | xargs rm -rf
end
