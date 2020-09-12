#!/bin/sh
fullpathname=$1
# terminal="lxterminal"
terminal="urxvt"
image_icon=/usr/share/icons/Arc/mimetypes/24/application-x-bittorrent.png
	dirr=$(yad --width=600 --height=600 --center \
			   --title="Directory selection" --window-icon=$image_icon \
		       --text-align=center --text="Download ${fullpathname##*/} To Directory" \
	           --file --file-directory)
	if [[ $? -eq 0 ]]; then
		cd "${dirr}"
		$terminal -e aria2c --seed-time=0 "${fullpathname}"
		notify-send -t 25000 "Download torrent ${fullpathname##*/}" "Completed to Directory ${dirr}"
	fi
exit 0
