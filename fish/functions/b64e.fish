function b64e
	if set -q argv[1]
		echo -n "$argv" | base64 | pbcopy
	else
		echo >&2 'Using clipboard…'
		echo -n (pbpaste) | base64 | pbcopy
	end
	pbpaste
	echo >&2 'Copied to clipboard.'
end

function b64d
	if set -q argv[1]
		echo -n "$argv" | base64 --decode
	else
		echo >&2 'Using clipboard…'
		echo -n (pbpaste) | base64 --decode
	end
end
