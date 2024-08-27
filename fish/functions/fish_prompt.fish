function fish_prompt --description 'Write out the prompt'
	set -l last_pipestatus $pipestatus
	set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
	set -l normal (set_color normal)
	set -q fish_color_status; or set -g fish_color_status red

	# Color the prompt differently when we're root
	set -l color_cwd $fish_color_cwd
	set -l suffix ' ' (set_color $__rafi_prompt_color_symbol)
	if functions -q fish_is_root_user; and fish_is_root_user
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		end
		set suffix $suffix '!'
	else
		set suffix $suffix 'λ'
	end
	set suffix $suffix $normal ': '

	# Write pipestatus
	# If the status was carried over (if no command is issued or if `set` leaves
	# the status untouched), don't bold it.
	set -l bold_flag --bold
	set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
	if test $__fish_prompt_status_generation = $status_generation
		set bold_flag
	end
	set __fish_prompt_status_generation $status_generation
	set -l status_color (set_color $fish_color_status)
	set -l statusb_color (set_color $bold_flag $fish_color_status)
	set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

	if test -n "$SSH_CONNECTION"; or fish_is_root_user
		echo -n -s (prompt_login)" "
	end
	echo -n -s (set_color $color_cwd) (prompt_pwd) $normal " "$prompt_status

	# Show number of jobs
	set --local njobs (count (jobs -p))
	if test "$njobs" -gt 0
		echo -n -s "✦"
	end
	if test "$njobs" -gt 1
		echo -n -s " "$njobs
	end
	echo -n -s $suffix
end
