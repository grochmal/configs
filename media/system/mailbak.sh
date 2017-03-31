#!/bin/sh
#
# Backup of emails and addressbook, all arguments are optional but have
# sensible defaults.  Since `tar` is not very clever about paths we use
# `realpath` which is not POSIX compatible.  You need to install `realpath` if
# you do not have it.
#
# Usage mailback.sh [backup-dir] [mail-dir] [abook-file]"
#
# backup-dir in ~/mailbak
# mail-dir in ~/mail
# abook-file in ~/.abook/addressbook

date_bak=`date +'%Y%m%d'`
bak_dir=${1:-"$HOME/mailbak"}
if test "x" != "x$MAIL"
then
    mail_base=`dirname "$MAIL"`
    mail_dir=${2:-"$mail_base"}
else
    mail_dir=${2:-"$HOME/mail"}
fi
tar_base=`dirname "$mail_dir"`
abook=${3:-"$HOME/.abook/addressbook"}

if test ! -d "$bak_dir"
then
    echo "mkdir -p \"$bak_dir\""
    mkdir -p "$bak_dir"
fi
bak_file="$bak_dir/mailbak-${date_bak}.tar.gz"

# now prepare the directorie for tar (leave symlinks unexpanded)
tar_mail=`realpath --no-symlinks --relative-to="$tar_base" "$mail_dir"`
tar_abook=`realpath --no-symlinks --relative-to="$tar_base" "$abook"`

echo "Backing up [ $mail_dir && $abook ] => $bak_file"

echo "tar -cvz -C \"$tar_base\" -f \"$bak_file\" \"$tar_mail\" \"$tar_abook\""
tar -cvz -C "$tar_base" -f "$bak_file" "$tar_mail" "$tar_abook"

