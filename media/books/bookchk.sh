#!/bin/sh

echo "Enc JS  Book"
echo "---|---|----"
for arg in "$@"; do
    PDF=`basename "$arg"`
    BOOK=`basename "$arg" .pdf`
    if test "$PDF" != "$BOOK.pdf"; then
        echo "WARNING: $arg not a PDF file"
    else
        pdfinfo "$arg" |
            grep -a -e 'Encrypted:' -e 'JavaScript:' |
            sed -e 's/^.*:\s\+//' |
            xargs echo -e "$arg" |
            awk '{printf "%-3s %-3s %s\n", $3, $2, $1}'
    fi
done

