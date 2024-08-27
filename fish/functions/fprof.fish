function fprof --description 'Profile fish startup'
	set --local fprof_txt (mktemp)
	fish --profile-startup="$fprof_txt" -c exit
	cat "$fprof_txt"
	rm "$fprof_txt"
end
