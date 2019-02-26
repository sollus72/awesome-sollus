#!/bin/bash
cd $HOME/.config/awesome/themes/zenburn/
out=$1
i=$out
fullpathname="${i}"
filename="${fullpathname##*/}"
echo $out > f2
image_icon=/usr/share/icons/Arc/devices/24/video-display.png
yad --title="Change Wallpaper" \
	--window-icon=$image_icon \
	--text="Your image for New Wallpaper" \
	--text-align=center \
	--picture --size=fit --filename=$fullpathname \
	--button="Change Wallpaper OK":0 \
	--button="Cancel":1 \
	--buttons-layout=center\
	--width=400 --height=300 --center --inc=256
	if [[ $? -eq 0 ]]; then
		echo "theme.wallpaper =" > f1
		sed -i -e 's/$/"/' -e 's/^/"/' f2
		paste -d '\ ' f1 f2 > f3
		i=$(cat theme.lua | sed -n '/theme.wallpaper/=')
		sed -i "${i}r f3" theme.lua
		sed -i "${i}d" theme.lua
	fi
rm -rf f1 f2 f3
cd -
exit 0
