#!/usr/bin/env sh

ffmpeg -i input.mp4 -vf "transpose=2,transpose=2,format=yuv420p" -metadata:s:v rotate=0 -codec:v libx264 -codec:a copy output.mp4
