#! /usr/bin/env bash
# Determine a dynamic completion path and print it on stdout for capturing

# Determine target path
set_target_path() {
	local month; month="$(date +'%Y-%m')"

	# Only move data downloaded into a ".leech" directory
	egrep >/dev/null "/.leech/" <<<"${__d_base_path}/" || return

	target_tail=$(sed -re 's~^.*/\.leech/(.*)~\1~' <<<"${__d_base_path}")
	test "$__d_is_multi_file" -eq 1 || target_tail="$(dirname "$target_tail")"
	test "$target_tail" != '.' || target_tail=""

	# Move by label
	test -n "$__target" || case $(tr A-Z' ' a-z_ <<<"${__d_label:-NOT_SET}") in
		tv|hdtv)   __target="tv" ;;
		movie*)    __target="movies/$month" ;;
	esac

  # Move by name patterns (check both displayname and info.name)
	for i in "$__d_display_name" "$__d_name"; do
		test -n "$__target" -o -z "$i" || case $(tr A-Z' ' a-z. <<<"${i}") in
			*hdtv*|*pdtv*)              __target="tv" ;;
			*.s[0-9][0-9].*)            __target="tv" ;;
			*.s[0-9][0-9]e[0-9][0-9].*) __target="tv" ;;
			*pdf|*epub|*ebook*)         __target="ebooks/$month" ;;
		esac
	done

	if [ -z "$__target" ]; then
		if [ "$(is_movie "$__d_name")" = "1" ] || \
				[ "$(is_movie "$__d_display_name")" = "1" ]; then
			__target="movies/$month"
		fi
	fi

	# Append tail path if non-empty
	if [ -n "$__target" ] && [ -n "$target_tail" ]; then
		__target="$__target/$target_tail"
	fi
}

is_movie() {
	python - "$@" <<'EOF'
import re
import sys

pattern = re.compile(
    r"^(?P<title>.+?)[. ](?P<year>\d{4})"
    r"(?:[._ ](?P<release>UNRATED|REPACK|INTERNAL|PROPER|LIMITED|RERiP))*"
    r"(?:[._ ](?P<format>480p|576p|720p|1080p|1080i|2160p))?"
    r"(?:[._ ](?P<srctag>[a-z]{1,9}|V2.HC))?"
    r"(?:[._ ](?P<source>BDRip|BRRip|HDRip|DVDRip|DVD[59]?|PAL|NTSC|Web|WebRip|WEB-DL|Blu-ray|BluRay|BD25|BD50))"
    r"(?:[._ ](?P<sound1>MP3|DD.?[25]\.[01]|AC3|AAC(?:2.0)?|FLAC(?:2.0)?|DTS(?:-HD)?))?"
    r"(?:[._ ](?P<codec>xvid|divx|avc|x264|h\.?264|hevc|h\.?265))"
    r"(?:[._ ](?P<sound2>MP3|DD.?[25]\.[01]|AC3|AAC(?:2.0)?|FLAC(?:2.0)?|DTS(?:-HD)?))?"
    r"(?:[-.](?P<group>.+?))"
    r"(?P<extension>\.avi|\.mkv|\.mp4|\.m4v)?$"
    , re.IGNORECASE
)

title = ' '.join(sys.argv[1:])
print("0" if not title or not pattern.match(title) else "1")
EOF
}

main() {
	local __directory_default="${1}"  # e.g. /home/bob/media/.leech/
	local __session_path="${2}"  # e.g. /home/bob/.cache/rtorrent/session/
	local __d_hash="${3}"  # e.g. 10A4FD60CF131810210A670916981F7897ABE1DF
	local __d_name="${4}"  # e.g. Foo.2019.1080p.V2.HC.HDRip.X264-ABC
	local __d_directory="${5}"  # e.g. /home/bob/media/.leech/Foo.2019.1080p.V2.HC.HDRip.X264-ABC
	local __d_base_path="${6}"  # e.g. /home/bob/media/.leech/Foo.2019.1080p.V2.HC.HDRip.X264-ABC
	local __d_tied_to_file="${7}"  # e.g. /home/bob/.cache/rtorrent/watch/Foo.2019.1080p.V2.HC.HDRip.X264-ABC [XYZ].torrent
	local __d_is_multi_file="${8}"  # e.g. 1
	local __d_label="${9}"
	local __d_display_name="${10}"

	local __target=""
	local __target_base=""

	{
		echo "-[ $(date +'%Y-%m') ]-----"
		echo "__d_name: $__d_name"
		echo "__d_directory: $__d_directory"
		echo "__d_base_path: $__d_base_path"
		echo "is_movie: $(is_movie "$__d_name")"
	} >> /tmp/rtorrent.log

	# Determine target path
	set_target_path

	# "target_base" is used to complete a non-empty but relative "target" path
	__target_base="$(sed -re 's~^(.*)/\.leech/.*~\1~' <<<"${__d_base_path}")"
	echo "__target=${__target} target_base=${__target_base}" >> /tmp/rtorrent.log

	# Return result (an empty target prevents moving)
	if test -n "$__target"; then
		if test "${__target:0:1}" = '/'; then
			echo -n "$__target"
		else
			echo -n "${__target_base%/}/$__target"
		fi
	fi
}

main "$@"

# vim: set ts=2 sw=2 tw=80 noet :
