#!/bin/bash
# usage: cropfile <file> <SN> <EN>
# cut first <SN> and last <EN> lines of file;
# the rest is saved under the same name.

FILE=$1
SN=$2
EN=$3

TMP=tmp$$

NTOTAL=`wc -l $FILE | cut -d ' ' -f 1`
NK=$(echo "$NTOTAL +1 - $SN" | bc) # NB. +1: no newline at end of file
tail -n $NK $FILE > $TMP
NK=$(echo "$NK - $EN" | bc)
head -n $NK $TMP > $FILE
rm $TMP
