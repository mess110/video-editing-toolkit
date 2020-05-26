#!/usr/bin/env sh

log() {
  msg=$1
  t=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$t : $msg"
}

log "$1"
