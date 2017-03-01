#!/bin/sh

# firefox, chromium, surf, min
URL_OPENER=${BROWSER:-firefox}
PROGRAM=`which $URL_OPENER 2>/dev/null`

if test "x" = "x$PROGRAM"
then
    echo "$URL_OPENER: no such program in PATH"
else
    "$PROGRAM" "$1"
fi

