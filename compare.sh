#!/usr/bin/env sh

# compute side by side comparison
FILE1=$1
FILE2=$2

[ -z "$FILE1" ] && ./log.sh "no argument supplied" && exit 1
[ ! -f $FILE1 ] && ./log.sh "$FILE2 does not exist" && exit 2
[ -z "$FILE2" ] && ./log.sh "no argument supplied" && exit 3
[ ! -f $FILE2 ] && ./log.sh "$FILE2 does not exist" && exit 4

BASENAME=$(basename "$FILE1")
EXTENSION="${BASENAME##*.}"
OUTPUT_FILE="${BASENAME%.*}.compare.$EXTENSION"
DIR=$(dirname "${FILE1}")
FULL_OUTPUT_PATH=$DIR/$OUTPUT_FILE

ffmpeg -i $FILE1 -i $FILE2 -filter_complex "[0:v:0]pad=iw*2:ih[bg]; [bg][1:v:0]overlay=w" $FULL_OUTPUT_PATH
