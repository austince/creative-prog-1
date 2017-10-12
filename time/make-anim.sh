#!/usr/bin/env bash

if [[ -z $1 ]]; then
FR=30
else
FR=$1
fi

echo "Making animation at $FR fps"
ffmpeg -loglevel fatal -y -framerate $FR -i "./frames/%d.png" time.mp4
