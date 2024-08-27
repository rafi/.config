function fish_right_prompt --description 'Write out the right prompt'
	if test -n "$CMD_DURATION"
		echo -n -s (format_time $CMD_DURATION 0.5 false)
	end

	echo -n -s (fish_vcs_prompt) $normal
end
