# Encoding functions
# https://github.com/rafi/.config

function bashquote() {
	printf '%q\n' "$(cat)"
}

function b64enc() {
	echo -n "$1" | base64 | pbcopy
	pbpaste
	echo >&2 'Copied to clipboard.'
}

function b64dec() {
	echo -n "$1" | base64 --decode
}
