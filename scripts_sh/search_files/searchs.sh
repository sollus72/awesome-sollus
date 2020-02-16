#!/bin/sh
# 2020-02 created by sollus
# https://github.com/sollus72
#
# Decription
# Search files in the HOME directories
#
# Provided by the principle - as is  # Предоставляется по принципу -  Как есть
#
# Dependencies  # Зависимости
# sudo pacman -S yad
# https://github.com/v1cont/yad
# -------------------------------------------------------------------------------------------------------

# Script Icon Location  # Расположение иконки скрипта
patch_icon=/home/sollus/.config/awesome/icons_myaw/preferences-system-search.png

# Home directory
cd ${XDG_HOME:-$HOME}

# Enter find name
name=$(yad --title "Find name" \
				  --window-icon=$patch_icon \
                  --width=400 \
                  --buttons-layout=center \
                  --center --entry \
                  --text-align=center \
                  --text="Enter Search Name")
                if [[ $? -eq 0 ]]; then

# Search section
i=$(find . -iname "*$name*" | yad --list --title "Search Results HOME" \
				  --window-icon=$patch_icon \
				  --width=800 \
				  --height=600 \
				  --center \
				  --text "Finding all header files.." \
				  --separator " " \
				  --column "Files")
				  	if [[ $? -eq 0 ]]; then
						echo $i > /tmp/f1
						i=$(cat /tmp/f1 | cut -c 2-)
						fullpathname="${i}"
						fileext="${fullpathname##*.}"
						echo $fileext
							if [[ $fileext == 'url' ]]; then
								firefox $(cat ${XDG_HOME:-$HOME}"${i}" | grep "http" | cut -c 5-)
								exit 0
							fi
						
						# Open the found file with the default application  # Открыть найденный файл приложением по умолчанию 
						xdg-open ${XDG_HOME:-$HOME}/"${i}" &
					fi
				fi
exit 0
