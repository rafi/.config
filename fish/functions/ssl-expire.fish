function ssl-expire \
	--description 'show expiration date of an ssl certificate for host or file with -f'

	if [ $argv[1] = "-f" ]; then
		openssl x509 -noout -enddate -in $argv[2] | sed 's/^notAfter=//'
	else
		ssl-get $argv | openssl x509 -noout -enddate | sed 's/^notAfter=//'
	end
end
