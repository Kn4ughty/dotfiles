#!/bin/bash

swaymsg -m -t subscribe '["mode"]' |
while read -r event_json; do
    echo $(jq -r '.change' <<< $event_json)
done

# swaymsg -m -t SUBSCRIBE "[ 'mode' ]" | jq ".change"
