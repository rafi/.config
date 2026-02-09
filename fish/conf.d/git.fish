function g. --description 'Commit a temporary change to the repository.'
	git add .
	git commit -m '.'
end

function ggcnow --description 'Completely remove all unreachable objects from the repository.'
	git -c gc.reflogExpireUnreachable=now gc --prune=now
	git maintenance run --task=pack-refs
end

function gmr --description 'Force master/main branch to origin.'
	set -l name (git remote | head -n1)
	if ! git remote | grep -q $name
		echo 2>&1 "No remote named '$name'."
		return 1
	end
	if git rev-parse --abbrev-ref HEAD | grep -q 'master\|main'
		echo 2>&1 "Already on $(git branch --show-current) branch."
		git merge "$name/$(git branch --show-current)"
		return 1
	end
	if git show-ref --quiet refs/heads/master
		git branch -f master $name/master
	end
	if git show-ref --quiet refs/heads/main
		git branch -f main $name/main
	end
end
