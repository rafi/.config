function gg --description 'go get with argument, or go mod tidy'
	if not set -q argv[1]
		go mod tidy -v
	else
		go get -u $argv
	end
end
