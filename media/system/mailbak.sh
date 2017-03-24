#!/bin/sh
#
# Backup of emails and addressbook, all arguments are optional but have
# sensible defaults:
#
# Usage mailback.sh [backup-dir] [mail-dir] [abook-file]"
#
# backup-dir in ~/mailbak
# mail-dir in ~/mail
# abook-file in ~/.abook/addressbook

DATE=`date +'%Y%m%d'`
BAKDIR=${1:-"$HOME/mailbak"}
if test "x" != "x$MAIL"
then
    MAILBASE=`dirname $MAIL`
    MAILDIR=${2:-"$MAILBASE"}
else
    MAILDIR=${2:-"$HOME/mail"}
fi
ABOOK=${3:-"$HOME/.abook/addressbook"}

if test ! -d "$BAKDIR"
then
    echo "mkdir -p \"$BAKDIR\""
    mkdir -p "$BAKDIR"
fi
BAKFILE="$BAKDIR/mailbak-${DATE}.tar.gz"

echo "Backing up [$MAILDIR & $ABOOK] => $BAKFILE"

echo "tar cvzf \"$BAKFILE\" \"$MAILDIR\" \"$ABOOK\""
tar cvzf "$BAKFILE" "$MAILDIR" "$ABOOK"

