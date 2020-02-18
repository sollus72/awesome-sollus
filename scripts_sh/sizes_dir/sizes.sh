#!/bin/sh
# View directory sizes for your HOME directory - Просмотр размеров директорий домашнего каталога
# Opening the watched directory in the File manager - Открытие просматриваемой директории в файловом менеджере
# -------------------------------------------------------------------------------------------------------------
# Script Icon Location  # Расположение иконки скрипта
patch_icon=${XDG_HOME:-$HOME}/.config/awesome/size1.png

# File manager - Файловый менеджер
file_manager="pcmanfm -n"

# HOME directory - Домашний каталог
dir=${XDG_HOME:-$HOME}

cd $dir
s=/tmp/s1
echo $dir > $s

var1=1
	while [[ $var1 -ne 0 ]]
		do
		# Open HOME or Selected directory
		i=$(du -ch -d 1 "${dir}" | sort -hr | yad --list --title "Sizes DIR" \
											  --width=800 \
											  --height=600 \
											  --window-icon=$patch_icon \
											  --center \
											  --button="open $dir":77 \
											  --button=back:99 \
											  --button="next choose":0 \
											  --text "Directory Sizes $dir   (ESC=exit)" \
											  --separator " " \
											  --column "Size / Directories")
			x=$?
			# Exit = ESC
			if [[ $x -eq 252 ]]; then exit 0
			# Open directory in File manager
			elif [[ $x -eq 77 ]]; then
				dir="$(cat $s | sed 's/ /\|/ ' | cut -d"|" -f2)"
				$file_manager "${dir}"
			# Back to previous directory
			elif [[ $x -eq 99 ]]; then
				if [[ "${dir}" = ${XDG_HOME:-$HOME} ]]; then
					cd ${XDG_HOME:-$HOME}
				else
					cd ..
					pwd > $s
					dir="$(cat $s)"
				fi
			# No directory selected
			elif [[ $i = "" ]]; then
				dir=${XDG_HOME:-$HOME}	
				echo $dir > $s
			# Selected Next directory
			else
				echo $i > $s
				dir="$(cat $s | sed 's/ /\|/ ' | cut -d"|" -f2)"
				cd "${dir}"
			fi
	done
exit 0	
