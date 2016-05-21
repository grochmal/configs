#!/bin/sh

Q=4  # variable bitrate around 128k

for m in *.mp3; do
    song=`basename "$m" .mp3`
    mpg123 -w "$song.wav" "$m"
    oggenc -q $Q "$song.wav"
done
for m in *.flac; do
    song=`basename "$m" .flac`
    flac -d "$m"
    oggenc -q $Q "$song.wav"
done

