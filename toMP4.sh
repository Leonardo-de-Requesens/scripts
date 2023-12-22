#!/bin/bash

ORANGE='\033[0;33m'
WHITE='\033[0m'
RED='\033[0;31m'

for file in *.mkv; do
	in="${file}"
	out="${file%.mkv}.mp4"
	ffmpeg -i ${in} -codec:a aac -b:a 128k -codec:v libx264 -crf 23 ${out}
	if [ $? -eq 0 ]; then
		rm ${in}
	else
		echo -e "${RED}ERROR${WHITE}: issue happened when converting ${in}"
		exit 1
	fi
	echo "=========="
	echo -e "${ORANGE}${out}${WHITE} DONE"
	echo "=========="
done

