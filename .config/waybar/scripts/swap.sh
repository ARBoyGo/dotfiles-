#!/bin/bash

total=$(free -m | awk '/^Swap:/ {print $2}')
used=$(free -m | awk '/^Swap:/ {print $3}')
percentage=$(awk "BEGIN {printf \"%.1f\", $used/$total*100}")
consumption=$(awk "BEGIN {printf \"%.1f\", $used/1024}")

text=" $percentage%"
tooltip="$consumption GiB swap used"
class="SWAP Usage: $percentage%"

echo '{"text": "'$text'", "tooltip": "'$tooltip'", "class": "'$class'"}'
