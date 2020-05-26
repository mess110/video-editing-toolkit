#!/usr/bin/env sh

#                 input    from to speed
# ./butterflow.sh asd.mp4  3    5  0.5

FILE=$1
FROM=$2 # second ex: 1, 5, 7
TO=$3 # second ex: 1, 5, 6
SPEED=$4 # 0.5 , 2 etc

[ -z "$FILE" ] && ./log.sh "no argument supplied" && exit 1
[ ! -f $FILE ] && ./log.sh "$FILE does not exist" && exit 2
[ -z "$FROM" ] && ./log.sh "from second missing" && exit 3
[ -z "$TO" ] && ./log.sh "to second missing" && exit 4
[ -z "$SPEED" ] && ./log.sh "speed missing" && exit 5

TIMESTAMP=`date "+%s"`
BASENAME=$(basename "$FILE")
EXTENSION="${BASENAME##*.}"
INPUT_FILE="$BASENAME.$EXTENSION"
OUTPUT_FILE="${BASENAME%.*}.butterflow.$SPEED.$EXTENSION"
DIR=$(dirname "${FILE}")
FULL_OUTPUT_PATH=$DIR/$OUTPUT_FILE
TMP_DIR="/tmp/butterflow$TIMESTAMP"
BUTTERFLOW_OUTPUT_FILE="/butterflow/$OUTPUT_FILE"

mkdir $TMP_DIR
cp $FILE $TMP_DIR/$INPUT_FILE

# docker run -it --rm -v /tmp/butterflow:/butterflow saren/butterflow butterflow -m -v /butterflow/video.mp4 -o /butterflow/out.mp4
docker run -it --rm -v $TMP_DIR:/butterflow saren/butterflow butterflow -s a=$FROM,b=$TO,spd=$SPEED -v -k /butterflow/$INPUT_FILE -o $BUTTERFLOW_OUTPUT_FILE
cp "$TMP_DIR/$OUTPUT_FILE" $FULL_OUTPUT_PATH
rm -rf $TMP_DIR
