#!/bin/sh
#
# Backup of the personal information kept under the rc directory.  All
# arguments are optional and have sensible defaults.  Note that this is not a
# POSXI script since it needs `realpath` so the `tar` can be made from
# anywhere.
#
# Usage secback.sh [backup-dir] [sec-dir] [hostname]"
#
# backup-dir in ~/rcbak
# sec-dir in ~/rc/secrc
# hostname as given by `hostname -s`

date_bak=`date +'%Y%m%d'`
host=`hostname -s`
bak_dir=${1:-"$HOME/rc/secrc/bak"}
sec_dir=${2:-"$HOME/rc/secrc"}
host_bak=${3:-"$host"}
tar_base=`dirname "$sec_dir"`
exclude_baks="--exclude=secrc/bak --exclude=secrc/lost+found"
exclude_tomb="--exclude=secrc/.last --exclude=secrc/.host"
exclude_perm="--exclude=secrc/.uid --exclude=secrc/.tty"
excludes="$exclude_baks $exclude_tomb $exclude_perm"

if test ! -d "$bak_dir"
then
    echo "mkdir -p \"$bak_dir\""
    mkdir -p "$bak_dir"
fi
bak_file="$bak_dir/secbak-${host_bak}-${date_bak}.tar.gz"

# prepare the path for tar (leave symlinks unexpanded)
tar_sec=`realpath --no-symlinks --relative-to="$tar_base" "$sec_dir"`

echo "Backing up [ $sec_dir ] => $bak_file"

echo "tar -cvz -C \"$tar_base\" -f \"$bak_file\" $excludes \"$tar_sec\""
tar -cvz -C "$tar_base" -f "$bak_file" $excludes "$tar_sec"

