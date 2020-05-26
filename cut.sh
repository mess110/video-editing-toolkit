#!/usr/bin/env sh

# ./cut.sh asa.mp4 00:01:00.000 4

FILE=$1
FROM=$2
SECONDS=$3

[ -z "$FILE" ] && ./log.sh "no argument supplied" && exit 1
[ ! -f $FILE ] && ./log.sh "$FILE does not exist" && exit 2
[ -z "$FROM" ] && ./log.sh "from missing: 00:01:00.000" && exit 3
[ -z "$SECONDS" ] && ./log.sh "number of seconds missing" && exit 4

BASENAME=$(basename "$FILE")
EXTENSION="${BASENAME##*.}"
OUTPUT_FILE="${BASENAME%.*}.$FROM.cut.$EXTENSION"
DIR=$(dirname "${FILE}")
FULL_OUTPUT_PATH=$DIR/$OUTPUT_FILE

./log.sh "Writing file '$FULL_OUTPUT_PATH'"
ffmpeg -ss $FROM -i $FILE -t $SECONDS -c copy $FULL_OUTPUT_PATH
