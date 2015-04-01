#!/bin/bash
iconv -f iso-8859-2 -t utf-8 | \
grep -e '</\?table\|</\?td\|</\?tr\|</\?th' | \
sed 's/^[\ \t]*//g' | \
tr -d '\n\r' | \
sed 's/<\/tr[^>]*>/\n/g' | \
sed 's/<\/\?\(table\|tr\)[^>]*>//g' | \
sed 's/^<t[dh][^>]*>\|<\/\?t[dh][^>]*>$//g' | \
sed 's/[\ \t]*<\/t[dh][^>]*><t[dh][^>]*>[\ \t]*/\t/g' | \
sed 's/\&amp;/\&/g' | sed 's/\&gt;/>/g' | sed 's/\&lt;/</g'
