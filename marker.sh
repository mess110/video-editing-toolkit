#!/usr/bin/env sh

FILE=$1
echo $FILE

INDEX_REAL_PATH=`realpath marker.html`
VIDEO_REAL_PATH=`realpath ${FILE}`
# using firefox due to seekToNextFrame
firefox "file://$INDEX_REAL_PATH?video=${VIDEO_REAL_PATH}"
