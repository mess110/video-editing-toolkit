#!/usr/bin/env sh

FILE=$1

REAL_PATH=`realpath ${FILE}`

if [ -d "$REAL_PATH" ]; then
  raw_duration=`find $REAL_PATH -type f | xargs -n 1 ./_find_duration.sh | awk '{ sum += $1 } END { print sum }'`
  echo "$raw_duration seconds"
  minutes=`echo "scale=0; ($raw_duration % 3600) / 60" | bc`
  seconds=`echo "scale=0; ($raw_duration % 60)" | bc`
  echo "$minutes minutes $seconds seconds"
elif [ -f $REAL_PATH ]; then
    ./_find_duration.sh $REAL_PATH
else
    ./log.sh "Path '$REAL_PATH' is not valid"
    exit 1
fi
