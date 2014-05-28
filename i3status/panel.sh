#!/bin/sh
#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'
#
# github.com/rafi i3status mpd support
#
# Uses the 'termsyn.icons' font at http://sourceforge.net/projects/termsyn

i3status | while :
do
	read line
	playing=$(mpc current -f "[%artist% - ]%title% (%date%)")
	if [ -z $playing ]; then
		playing="å No music"
	else
		status="æ"
		mpc | grep "\[paused\]" 1>/dev/null && status="ç"
		playing="$status $playing"
	fi
	
	# Prepend as well-formed JSON
	playing="[{ \"full_text\": \"${playing//\"/\\\"} \" },"
	echo "${line/[/$playing}" || exit 1
done

#-------8<---------------------------------------------------------------------
