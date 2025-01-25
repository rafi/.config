function node_delete_modules \
	--description 'Delete all node_modules directories in the current directory'

	find . -type d -name node_modules -prune -print | xargs rm -rf
end
