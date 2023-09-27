#!/bin/bash

while true; do
    output=$(/bin/bash ~/bin/cava.sh)
    echo "<txt>$output</txt>"
    sleep 1
done
