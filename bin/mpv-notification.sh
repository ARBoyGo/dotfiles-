#!/bin/bash

mpv_metadata=$(echo '{ "command": ["get_property", "metadata"] }' | socat - /tmp/mpvsocket | jq '.data')

if [[ $mpv_metadata != "null" ]]; then
  artist=$(echo "$mpv_metadata" | jq -r '.artist')
  title=$(echo "$mpv_metadata" | jq -r '.title')
  album=$(echo "$mpv_metadata" | jq -r '.album')

  echo "Now playing:"
  echo "Artist: $artist"
  echo "Title: $title"
  echo "Album: $album"
else
  echo "MPV is not running or detected."
fi
