#!/usr/bin/env bash

swaymsg -m -t subscribe '["window"]' |
while read -r event_json; do
    jq -r '.container.name' <<< $event_json
done
