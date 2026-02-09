function qr --description 'Create a QR code for provided text'
	if test (count $argv) -eq 0
		echo "Usage: qr <text-to-encode>"
		return 1
	end

	set -l file /tmp/qr.png
	echo -n $argv | qrencode -o "$file" -s 10
	open "$file"
end
