#!/usr/bin/env sh

FILE=$1

REAL_PATH=`realpath ${FILE}`

find_duration() {
  path=$1
  ffprobe -i $path -show_entries format=duration -v quiet -of csv="p=0"
  # status=$?
  # if [ $status -ne 0 ]; then
    # echo "Exit code: ${status}"
  # fi
}

find_duration "$REAL_PATH"
