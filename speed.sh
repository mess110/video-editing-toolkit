#!/usr/bin/env sh

FILE=$1
AMOUNT=$2

[ -z "$FILE" ] && ./log.sh "no argument supplied" && exit 1
[ -z "$AMOUNT" ] && ./log.sh "amount missing: 0.5" && exit 1

BASENAME=$(basename "$FILE")
EXTENSION="${BASENAME##*.}"
OUTPUT_FILE="${BASENAME%.*}.${AMOUNT}x.$EXTENSION"
DIR=$(dirname "${FILE}")
FULL_OUTPUT_PATH=$DIR/$OUTPUT_FILE
RATE=60

./log.sh "Changing speed of $FULL_OUTPUT_PATH by $AMOUNT"
ffmpeg -i $FILE -filter:v "setpts=$AMOUNT*PTS" -r $RATE $FULL_OUTPUT_PATH
