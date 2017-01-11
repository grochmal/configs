#!/bin/sh

# Dependency file for the remaining scripts in this directory, it contains the
# routines used by different scripts.

convert_imgs () {
    RES=$1
    QAL=$2
    if ls -1 *.jpg 2>/dev/null 1>&2; then
        for img in *.jpg; do
            echo mogrify -strip -resize $RES -quality "$QAL" "$img"
            mogrify -strip -resize $RES -quality "$QAL" "$img"
        done
    fi
    if ls -1 *.jpeg 2>/dev/null 1>&2; then
        for img in *.jpeg; do
            bimg=`basename "$img" .jpeg`
            echo convert "$img" -strip -resize $RES -quality "$QAL" "$bimg.jpg"
            convert "$img" -strip -resize $RES -quality "$QAL" "$bimg.jpg"
        done
        echo rm *.jpeg
        rm *.jpeg
    fi
    if ls -1 *.png 2>/dev/null 1>&2; then
        for img in *.png; do
            bimg=`basename "$img" .png`
            echo convert "$img" -strip -resize $RES -quality "$QAL" "$bimg.jpg"
            convert "$img" -strip -resize $RES -quality "$QAL" "$bimg.jpg"
        done
        echo rm *.png
        rm *.png
    fi
    if ls -1 *.gif 2>/dev/null 1>&2; then
        for img in *.gif; do
            bimg=`basename "$img" .gif`
            # [0] forces the first frame of the GIF to be saved
            # and ingnores all other frames
            fr="${img}[0]"
            echo convert "$fr" -strip -resize $RES -quality "$QAL" "$bimg.jpg"
            convert "$fr" -strip -resize $RES -quality "$QAL" "$bimg.jpg"
        done
        echo rm *.gif
        rm *.gif
    fi
}

