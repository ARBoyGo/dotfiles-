#! /bin/bash

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# make sure to clean pipe
pipe="/tmp/cava.fifo"
if [ -p "$pipe" ]; then
    unlink "$pipe"
fi
mkfifo "$pipe"

# write cava config
config_file="/tmp/cava_config"
echo "
[general]
bars = 10

[output]
method = raw
raw_target = $pipe
data_format = ascii
ascii_max_range = 7
" > "$config_file"

# run cava in the background
cava -p "$config_file" &

# define a function to update meta_data

update_meta_data() {
    while true; do
        mpv_metadata=$(echo '{ "command": ["get_property", "metadata"] }' | socat - /tmp/mpvsocket 2>/dev/null | jq '.data')

        if [[ -z $mpv_metadata ]]; then
            meta_data="Nothing is playing right now!"
        else
            artist=$(echo "$mpv_metadata" | jq -r '.artist')
            title=$(echo "$mpv_metadata" | jq -r '.title')
            album=$(echo "$mpv_metadata" | jq -r '.album')

            meta_data="Now playing: \n Artist: $artist \n Title: $title \n Album: $album"
        fi

        echo "$meta_data" > /tmp/meta_data
        sleep 1  # Adjust sleep duration as needed
    done
}

# run update_meta_data in the background
update_meta_data &

# continuously read data from fifo and output as JSON
while true; do
    while read -r cmd; do
        output=$(echo "$cmd" | sed "$dict")
        meta_data=$(cat /tmp/meta_data)
        echo "{\"text\":\"$output  \",\"tooltip\":\"$meta_data\"}"
    done < "$pipe"
    sleep 0.1  # Adjust sleep duration as needed
done