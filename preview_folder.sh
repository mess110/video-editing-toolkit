#!/usr/bin/env sh

FOLDER=$1

[ -z "$FOLDER" ] && ./log.sh "no folder supplied" && exit 1

vlc $FOLDER
