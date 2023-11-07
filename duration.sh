#!/bin/bash

total_hours=0
total_minutes=0
total_seconds=0

for file in *.mp4; do
    duration=$(ffmpeg -hide_banner -i $file 2>&1 | grep Duration | cut -d ',' -f1 | awk '{print $2}')
    IFS=':' read -r hours minutes seconds <<< $duration

    ((total_hours+=hours))
    ((total_minutes+=minutes))
    seconds=$(bc <<< "$seconds / 1")
    ((total_seconds+=seconds))
done

((total_minutes+=total_seconds / 60))
((total_seconds=total_seconds % 60))
((total_hours+=total_minutes / 60))
((total_minutes=total_minutes % 60))

echo "Time used: ${total_hours}:${total_minutes}:${total_seconds}"
