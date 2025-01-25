function mk --wraps=mkdir --description 'Create a directory and cd into it'
	mkdir -p "$argv" && cd "$argv[1]" || echo "Unable to cd into $argv[1]"
end
