#!/bin/sh

# find the directory the script is in and load dependencies
DIR=$(dirname $(readlink -e "$0"))
source "$DIR/_convert_imgs.sh"  # provides `convert_imgs RESOLUTION QUALITY`

IMGR=1280x1600\>\^
PHTR=1280x1920\>\^
IMGQ=80
PHTQ=90
RES=$IMGR
QAL=$IMGQ

if test 0 -eq $#; then
    echo usage:
    echo "  cbz2cbt.sh [-c|-p] <cbz> [[-c|-p] cbz ...]"
    echo
    echo " -c  resolution 1280x1600 (smaller side), JPEG quality 80 (default)"
    echo " -p  resolution 1280x1920 (smaller side), JPEG quality 90"
fi

for arg in "$@"; do
    case $arg in
      -p|--photo)
        RES=$PHTR
        QAL=$PHTQ
      ;;
      -i|--img)
        RES=$IMGR
        QAL=$IMGQ
      ;;
      *)
        if test -f "$arg"; then
            CBZF=`basename "$arg"`
            BASE=`basename "$arg" .cbz`
            # sanity check
            if test "$CBZF" = "$BASE" -o "x$BASE" = "x"; then
                echo "WARNING $arg is not named .cbz, will not process"
            else
                if test ! -d "$BASE"; then
                    echo mkdir "$BASE"
                    mkdir "$BASE"
                fi
                mv "$CBZF" "$BASE"
                cd "$BASE"
                unzip "$CBZF"
                mv "$CBZF" ..
                convert_imgs "$RES" "$QAL"
                tar cvf "$BASE.cbt" *.jpg
                mv "$BASE.cbt" ..
                cd ..
                echo rm -rf "$BASE"
                rm -rf "$BASE"
            fi
        else
            echo "WARNING $arg : no such file"
        fi
      ;;
    esac
done

