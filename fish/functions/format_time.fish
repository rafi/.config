function format_time \
	--description="Format milliseconds to a human readable format" \
	--argument-names milliseconds threshold show_subsecond prefix

	set --query show_subsecond[1]; or set show_subsecond false
	test "$milliseconds" -lt 0; and return 1
	test "$milliseconds" -lt (math --scale=0 "$threshold * 1000"); and echo; and return 0

	set --local time
	set --local days (math --scale=0 "$milliseconds / 86400000")
	test "$days" -gt 0; and set --append time (printf "%sd" $days)
	set --local hours (math --scale=0 "$milliseconds / 3600000 % 24")
	test "$hours" -gt 0; and set --append time (printf "%sh" $hours)
	set --local minutes (math --scale=0 "$milliseconds / 60000 % 60")
	test "$minutes" -gt 0; and set --append time (printf "%sm" $minutes)
	set --local seconds (math --scale=0 "$milliseconds / 1000 % 60")

	if test "$show_subsecond" = true
		set --local threshold_as_ms (math --scale=0 "$threshold*1000")
		set --local subseconds (format_time_subseconds $milliseconds $threshold_as_ms)
		set --append time $seconds$subseconds's'
	else
		test "$seconds" -gt $threshold; and set --append time (printf "%ss" $seconds)
	end

	echo -e "$prefix$(string join ' ' $time)"
end
