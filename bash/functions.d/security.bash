# Certificate functions
# https://github.com/rafi/.config

function ssl-get() {
	openssl s_client -servername "$1" -connect "$1":443 </dev/null 2>&1
}

function ssl-info() {
	if [ "$1" = "-f" ]; then
		openssl x509 -noout -issuer -subject -fingerprint -serial -dates -in "$2"
	else
		ssl-get "$1" | \
			openssl x509 -noout -issuer -subject -fingerprint -serial -dates
	fi
}

function ssl-expire() {
	if [ "$1" = "-f" ]; then
		openssl x509 -noout -enddate -in "$2"
	else
		ssl-get "$1" | openssl x509 -noout -enddate
	fi
}

# vim: set ts=2 sw=2 tw=80 noet :
