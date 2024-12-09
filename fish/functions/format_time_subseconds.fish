function format_time_subseconds \
	--description="Format duration milliseconds to a human readable format" \
	--argument-names \
	duration \
	threshold

	set --local subseconds
	if test "$duration" -gt $threshold
		set --local precision 2
		set --local milliseconds (string sub --start -3 --length $precision $duration)
		set --append subseconds '.'$milliseconds
	end
	echo $subseconds
end
