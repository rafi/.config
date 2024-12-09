function container_image_inspect --description 'Inspect a container image' \
	--argument-names repo
	set -l repo $argv[1]
	set -l target (crane ls $repo | \
		sort -Vfr | \
		fzf --no-sort --no-multi --prompt 'Tags: ')

	if string length -q -- $target
		crane config $repo:$target | fx
	end
end
