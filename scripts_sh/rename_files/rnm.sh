#!/bin/sh
#
# 2020-02 created by sollus
# https://github.com/sollus72
#
# video ин script 
# https://www.dropbox.com/s/g1f520mdwndxoke/rename1.mp4
#
# Provided by the principle - as is  # Предоставляется по принципу -  Как есть
#
# Dependencies  # Зависимости
#
# sudo pacman -S yad
# https://github.com/v1cont/yad
#
# The number of files to rename must be more than one  # Количество файлов для переименования должно быть больше чем один
#
# Renamed file example # Пример переименованного файла
# Old name: file.jpg ; New name: file_1.jpg  # Старое имя: file.jpg ; Новое имя: file_1.jpg
# -------------------------------------------------------------------------------------------------------

# Script Icon Location  # Расположение иконки скрипта
patch_icon=/home/sollus/.config/awesome/rename1.png

# Select multiple files to rename # Выбор нескольких файлов для переименования
yad --title "Rename files" --file --center --multiple \
	--width=800 --height=600 \
	--window-icon=$patch_icon \
	--separator "\\n" > /tmp/f1
	if [[ $? -ne 0 ]]; then exit 0
	fi

# Confirm selected files for renaming # Подтверждение выбранных файлов для переименования
yad --text-info --title "Rename files" \
				  --window-icon=$patch_icon \
				  --width=500 \
				  --height=500 \
				  --center \
				  --text "Rename files ... OK?" \
				  --separator " " \
				  --column "Files" \
				  --filename=/tmp/f1
	if [[ $? -ne 0 ]]; then exit 0
	fi
# Number of files to rename  # Количество файлов для переименования
n_string=$(cat /tmp/f1 | wc -l)

# Common name for files to be renamed  # Общее имя для файлов, которые будут переименованы
# The extension of renamed files will not change  # Расширение переименованных файлов не изменятся
# Prefix _1, _2, _3 ... will be added to the new file name ...  # К новому имени файла добавиться префих _1,_2,_3...
name=$(yad --title "Rename files" \
				  --window-icon=$patch_icon \
                  --width=400 \
                  --bg=#3F3F3F \
                  --buttons-layout=center \
                  --center --entry \
                  --text-align=center \
                  --text="Enter a new name. 1,2,3 will be added ...")
    if [[ $? -ne 0 ]]; then exit 0
    	elif [[ $name == '' ]]; then exit 0
    fi

# Rename Files # Переименование файлов
name_new="${name}"
i=1
prefix=1

	while [[ $n_string -ne 0 ]]
		do
		x=$(head -n $i /tmp/f1 | tail -n 1)
			fullpathname="${x}"
			dir_file="${fullpathname%/*}"
			ext_file="${fullpathname##*.}"
			name_old="${fullpathname##*/}"
		mv -f "${dir_file}/${name_old}" "${dir_file}/${name_new}_$prefix.$ext_file"
			prefix=$[ $prefix + 1 ]
			i=$[ $i + 1 ]
			n_string=$[ $n_string - 1 ]
	done

#Open directory with renamed files  # Открыть директорию с переименованными файлами
xdg-open "${dir_file}" &

exit 0
