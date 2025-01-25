function ssl-info --description 'ssl certificate info for host or file with -f'
	if [ $argv[1] = "-f" ]; then
		openssl x509 -noout -issuer -subject -fingerprint -serial -dates -in $argv[2]
	else
		ssl-get $argv | \
			openssl x509 -noout -issuer -subject -fingerprint -serial -dates
	end
end
