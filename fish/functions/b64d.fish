function b64d
	if set -q argv[1]
		echo -n "$argv" | base64 --decode
	else
		echo >&2 'Using clipboard…'
		echo -n (fish_clipboard_paste) | base64 --decode
	end
end
