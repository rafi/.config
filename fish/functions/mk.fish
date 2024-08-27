function mk --wraps=mkdir
	mkdir -p "$argv" && cd "$argv[1]" || echo "Unable to cd into $argv[1]"
end
