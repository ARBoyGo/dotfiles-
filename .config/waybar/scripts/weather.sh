#!/bin/bash

LOC="$1"
# Weather fetch from wttr.in
LOCATION=$(sed -e "s/ /%20/g" <<<"$LOC")
WEATHER=$(curl -s "https://wttr.in/${LOCATION}?format=%t" | sed 's/+//')
ICON=$(curl -s "wttr.in/${LOCATION}?format=3" | cut -d " " -f 2)
WEATHER_CLASS=$(curl -s "https://wttr.in/${LOCATION}?format=%C")
echo '{"text": "'$ICON $WEATHER'", "tooltip": "'$ICON $WEATHER $WEATHER_CLASS $LOC'", "class": "'$WEATHER_CLASS'" }'
