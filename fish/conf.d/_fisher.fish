# Fisher setup
# https://github.com/jorgebucaran/fisher

set --query _fisher_path_initialized && exit
set --global _fisher_path_initialized

set -U fisher_path $__fish_config_dir/plugins

if test -z "$fisher_path" || test "$fisher_path" = "$__fish_config_dir"
	exit
end

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

if not functions -q fisher
	echo 'Downloading fisher...' >&2
	curl -sL git.io/fisher | source; and fisher install jorgebucaran/fisher
end

for file in $fisher_path/conf.d/*.fish
	source $file
end
