# Fisher setup
# https://github.com/jorgebucaran/fisher

set fisher_path $__fish_config_dir/plugins

if test -z "$fisher_path" || test "$fisher_path" = "$__fish_config_dir"
	exit
end

set --query _fisher_path_initialized && exit
set -U _fisher_path_initialized

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

if not functions -q fisher
	echo 'Downloading fisher...' >&2
	test -d $fisher_path; or mkdir -vp $fisher_path
	curl -sL git.io/fisher | source
	and fisher update
end

for file in $fisher_path/conf.d/*.fish
	source $file
end
