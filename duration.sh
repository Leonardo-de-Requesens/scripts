#!/bin/bash

for file in *.mkv; do
    in="${file}"
    out="${file%.mkv}.mp4"
    ffmpeg -i ${in} -codec:a aac -b:a 128k -codec:v libx264 -crf 23 ${out}
    if [ $? -eq 0 ]; then
        rm ${in}
    fi
done

