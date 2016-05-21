#!/bin/sh

# Prints the duration of the MP3, WAV and OGG files after conversion.
# Distinct durations between files normally mean frankenstein tracks.

check () {
    if test -f "$1"
    then
        f=`basename "$1" .ogg`
        if test -e "$f"; then f=`basename "$f" .wav`; fi
        if test -e "$f"; then f=`basename "$f" .mp3`; fi
        echo -en "$f\t\tMP3: "
        if test -r "${f}.mp3"
        then
            mp3info -x "${f}.mp3"  |
                grep -a '^Length:' |
                sed -e 's/^Length:\s*//'
        else
            echo "N/A"
        fi
        echo -en "$f\t\tWAV: "
        if test -r "${f}.wav"
        then
            SEC=`soxi -D "${f}.wav" | sed -e 's/\..*//'`
            MIN=`expr $SEC / 60`
            SEC=`expr $SEC % 60`
            echo "${MIN}m:${SEC}s"
        else
            echo "N/A"
        fi
        echo -en "$f\t\tOGG: "
        if test -r "${f}.ogg"
        then
            ogginfo "${f}.ogg" |
                grep -a 'Playback length:' |
                sed -e 's/^\s*Playback length:\s*//'
        else
            echo "N/A"
        fi
    else
        echo ${1}: no such file
    fi
}

if ! which mp3info >/dev/null
then
    echo mp3info missing, ABORTING
elif ! which soxi >/dev/null
then
    echo soxi missing, ABORTING
elif ! which ogginfo >/dev/null
then
    echo ogginfo missing, ABORTING
else
    for a in "$@"
    do
        check "$a"
    done
fi

