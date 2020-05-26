#!/usr/bin/env sh

FILE=$1

[ -z "$FILE" ] && ./log.sh "no argument supplied" && exit 1

BASENAME=$(basename "$FILE")
EXTENSION="${BASENAME##*.}"
OUTPUT_FILE="${BASENAME%.*}.reverse.$EXTENSION"
DIR=$(dirname "${FILE}")
FULL_OUTPUT_PATH=$DIR/$OUTPUT_FILE

./log.sh "Reversing to $FULL_OUTPUT_PATH"

ffmpeg -i $FILE -vf reverse $FULL_OUTPUT_PATH
