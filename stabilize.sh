#!/usr/bin/env sh

# TODO

FILE=$1

[ -z "$FILE" ] && ./log.sh "no argument supplied" && exit 1
[ ! -f $FILE ] && ./log.sh "$FILE does not exist" && exit 2

BASENAME=$(basename "$FILE")
EXTENSION="${BASENAME##*.}"
OUTPUT_FILE="${BASENAME%.*}.stabilized.$EXTENSION"
DIR=$(dirname "${FILE}")
FULL_OUTPUT_PATH=$DIR/$OUTPUT_FILE

docker run -v $(pwd):/data jareware/ffmpeg -i $FILE -vf vidstabdetect $FULL_OUTPUT_PATH
docker run -v $(pwd):/data jareware/ffmpeg -i $FILE -vf vidstabtransform -y $FULL_OUTPUT_PATH

rm transforms.trf

./log.sh "done: $FULL_OUTPUT_PATH"
