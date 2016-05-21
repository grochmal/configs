#!/bin/sh

# find the directory the script is in and load dependencies
DIR=$(dirname $(readlink -e "$0"))
source "$DIR/_convert_imgs.sh"  # provides `convert_imgs RESOLUTION QUALITY`

RES=1280x1920\>\^
QAL=90

if test 0 -eq $#; then
    echo usage:
    echo "  mkalbum.sh album.cbt"
    echo
    echo "  (resolution 1280x1920 (smaller side), JPEG quality 90)"
fi

convert_imgs "$RES" "$QAL"
tar -cvf "$1" *.jpg

