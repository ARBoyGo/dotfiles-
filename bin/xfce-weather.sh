#!/bin/bash

LOC="$1"
# Weather fetch from wttr.in
LOCATION=$(sed -e "s/ /%20/g" <<<"$LOC")
WEATHER=$(curl -s "https://wttr.in/${LOCATION}?format=%t" | sed 's/+//')
ICON=$(curl -s "wttr.in/Kozhikode?format=3" | cut -d " " -f 2)
echo "$ICON $WEATHER"
