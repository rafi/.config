# Ref: https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc?permalink_comment_id=4574195#gistcomment-4574195
function envsource
	set -f envfile "$argv"
	if not test -f "$envfile"
		echo "Unable to load $envfile"
		return 1
	end
	while read line
		if not string match -qr '^#|^$' "$line"
			set item (string split -m 1 '=' $line)
			set -gx $item[1] $item[2]
		end
	end < "$envfile"
end
