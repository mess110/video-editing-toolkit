#!/usr/bin/env sh

FILE=$1

[ -z "$FILE" ] && ./log.sh "missing join.txt path" && exit 1
[ ! -f $FILE ] && ./log.sh "$FILE does not exist" && exit 2

ALL_FILES=`cat $FILE | tr -d "'" | awk '{ print $2 }'`
for i in $ALL_FILES
do
    ffmpeg -i "$i" -q 0 "$i.MTS"
    echo "file '$i.MTS'" >> 'join.mts'

    BASENAME=$(basename "$i")
    EXTENSION="${BASENAME##*.}"
    OUTPUT_FILE="${BASENAME%.*}.join.$EXTENSION"
    DIR=$(dirname "${i}")
    FULL_OUTPUT_PATH=$DIR/$OUTPUT_FILE
done

./log.sh "Writing to $FULL_OUTPUT_PATH"

ffmpeg -f concat -i join.mts -c copy $OUTPUT_FILE

./log.sh "Cleaning up"
rm join.mts
for i in $ALL_FILES
do
  rm "$i.MTS"
done
