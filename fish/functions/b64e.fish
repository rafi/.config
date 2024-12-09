function b64e
	if set -q argv[1]
		echo -n "$argv" | base64 | fish_clipboard_copy
	else
		echo >&2 'Using clipboard…'
		echo -n (fish_clipboard_paste) | base64 | fish_clipboard_copy
	end
	fish_clipboard_paste
	echo >&2 'Copied to clipboard.'
end
