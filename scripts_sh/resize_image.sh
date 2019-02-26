#!/bin/bash
out=$1
image_icon=$HOME/.config/awesome/icons_myaw/preferences-desktop-display.png
#image_icon=/usr/share/icons/Arc/apps/24/preferences-desktop-wallpaper.png
	# Ввод величины маштабирования
			scale=$(yad --center \
						--height=190 \
					  	--title="Enter scaling value" \
					    --window-icon=$image_icon \
						--list --radiolist \
		              	--text-align=center \
			            --text="Select Scale" \
						--column=Select \
						--column=Scale true 75% false 50% false 25% false 10%)
			if [[ $? -eq 0 ]]; then
				size=$(echo $scale | cut -d"|" -f2)					# % маштабирования
				i=$out 												# путь, имя, расширение исходного файла
				fullpathname="${i}" 								# путь, имя, расширение исходного файла
						#echo "fullpathname" $fullpathname			# fullpathname /home/sollus/Pictures/tttt space.jpg
						#echo "catalog" "${fullpathname%/*}"		# catalog /home/sollus/Pictures
						#echo "filename" "${fullpathname##*/}"		# filename tttt space.jpg
						#echo "fileext" "${fullpathname##*.}"		# fileext jpg or png
				fileext="${fullpathname##*.}"						# this is jpg or png
						#echo "filenameclear" "${fullpathname%.*}"	# filenameclear /home/sollus/Pictures/tttt space 
						#du -h "${i}" 								# размер исходного файла
						#du -h "${fullpathname}" 					# размер исходного файла
					yad --center \
						--title="Save resize image $size" \
						--window-icon=$image_icon \
						--text-align=center \
						--text "Selecting the method of recording images" \
						--button="Overwrite source file":1 \
						--button="Create a new file":0 \
						--buttons-layout=center
					n=$?	#escape=252 Overwrite source file=1 Create a new file=0
					if [[ $n -ne 252 ]]; then
							if [[ $n -eq 0 ]]; then
								cp "${i}" "${i}-res-$size.$fileext" # копирование, переименование исходного файла
								convert "${i}-res-$size.$fileext" -resize $size "${i}-res-$size.$fileext"	#конвертирование imagemagik new file
							else
								convert "${i}" -resize $size "${i}"	#конвертирование imagemagik перезапись исходного файла
							fi
					fi
			fi
exit 0
