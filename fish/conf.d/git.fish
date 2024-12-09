# Commit a temporary change to the repository.
function g.
	git add .
	git commit -m '.'
end

# Completely remove all unreachable objects from the repository.
function ggcnow
	git -c gc.reflogExpireUnreachable=now gc --prune=now
end

# Force master/main to origin.
function gmaster-origin
	if git rev-parse --abbrev-ref HEAD | grep -q 'master\|main'
		echo 2>&1 'Already on master branch.'
		return 1
	end
	if not git remote | grep -q origin
		echo 2>&1 'No remote named "origin".'
		return 1
	end
	if git show-ref --quiet refs/heads/master
		git branch -f master origin/master
	end
	if git show-ref --quiet refs/heads/main
		git branch -f main origin/main
	end
end
