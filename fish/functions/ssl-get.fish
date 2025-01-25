function ssl-get --description 'show domain ssl certificate information'
	openssl s_client -servername $argv -connect $argv:443 </dev/null 2>&1
end
