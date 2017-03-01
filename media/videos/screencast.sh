#!/bin/sh

# Screencast region of screen, usefuel together with key-mon

# output filename
VID=${1:-screencast}
# whether to inclrease video size
SIZE=1
# doule or halve the video speed
FILTER=''
case "$2" in
  -slow)
    FILTER='setpts=2.0*PTS,scale=iw:ih:flags=lanczos'
    ;;
  -speed)
    FILTER='setpts=0.5*PTS,scale=iw:ih:flags=lanczos'
    ;;
  *)
    FILTER='scale=iw:ih:flags=lanczos'
    ;;
esac
echo "Recording (<c-c> to stop)"
ffcast -s % ffmpeg -y -f x11grab -show_region 1 -framerate 5 \
                   -video_size %s -i %D+%c -codec:v libvpx \
                   -filter:v crop="iw-mod(iw\\,1):ih-mod(ih\\,1)" \
                   "$VID.webm"

echo "Generating palette"
ffmpeg -y -i "$VID.webm" -filter:v "$FILTER,palettegen" "$VID.png"
echo "Converting to GIF"
ffmpeg -y -i "$VID.webm" -i "$VID.png" \
       -lavfi "$FILTER[x];[x][1:v]paletteuse" "$VID.gif"

# This produces blinking GIFs
#ffmpeg -y -i "$VID.webm" -pix_fmt rgb24 $FILTER "$VID.gif"

# This uses too much memory
#FRAMES=`mktemp -d /tmp/framesXXX`
#echo "Converting to GIF (frames each $DELAY * 10 ms)"
#ffmpeg -i "$VID.webm" -filter:v fps=5 \
#       "$FRAMES/ffout%03d.png"
#convert -set delay $DELAY -loop 0 -layers optimize \
#        "$FRAMES/ffout*.png" "$VID.gif"
#echo "Junk generated at $FRAMES, you may wish to clean that"

