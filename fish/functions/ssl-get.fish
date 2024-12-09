function ssl-get
	openssl s_client -servername $argv -connect $argv:443 </dev/null 2>&1
end

function ssl-info
	if [ $argv[1] = "-f" ]; then
		openssl x509 -noout -issuer -subject -fingerprint -serial -dates -in $argv[2]
	else
		ssl-get $argv | \
			openssl x509 -noout -issuer -subject -fingerprint -serial -dates
	end
end

function ssl-expire
	if [ $argv[1] = "-f" ]; then
		openssl x509 -noout -enddate -in $argv[2]
	else
		ssl-get $argv | openssl x509 -noout -enddate
	end
end
