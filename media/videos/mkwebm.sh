#!/bin/sh

MRATE=512k
ERATE=1024k
RATE=$MRATE

if test 0 -eq $#; then
    echo usage:
    echo "  mkwebm.sh [-m|-e] <video> [[-m|-e] video ...]"
    echo
    echo " -m  movie, 512k video channel (default)"
    echo " -e  event video, 1024k video channel"
fi

for arg in "$@"; do
    case $arg in
      -m|--movie)
        RATE=$MRATE
      ;;
      -e|--event)
        RATE=$ERATE
      ;;
      *)
        if test -f "$arg"; then
            # remove the first extension
            VIDEO=${arg%.*}
            echo "ffmpeg '$arg' -> '$VIDEO.webm'"
            ffmpeg -i "$arg" \
                   -c:v libvpx -b:v 512k \
                   -c:a libvorbis -b:a 128k \
                   -quality good \
                   -qmin 30 -qmax 60 -vsync 2 -async 1 \
                   "$VIDEO.webm"
        else
            echo "WARNING $arg : no such file"
        fi
      ;;
    esac
done

