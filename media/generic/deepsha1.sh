#!/bin/sh

DIR=`pwd`

for sha in `find . -type f -name "sha1sums*"`; do
    base=`basename "$sha"`
    sdir=`dirname "$sha"`
    echo "    INFO: cd \"$sdir\""
    cd "$sdir"
    echo "    INFO: sha1sum --quiet -c \"$base\" 2>/dev/null"
    sha1sum --quiet -c "$base" 2>/dev/null
done

