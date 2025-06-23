#!/bin/bash

swaymsg -m -t subscribe '["window"]' |
while read -r event; do
    change=$(jq -r '.change' <<< "$event")
    echo $change

    # if (($change != "focus" && $change != "close")); then
    #     echo "BREAKING"
    #     break
    # fi
    container=$(jq -r '.container' <<< "$event")
    window_rect=$(jq -r '.window_rect' <<< "$container")

    width=$(jq -r '.width' <<< "$window_rect")
    height=$(jq -r '.height' <<< "$window_rect")


    echo $window_rect
    echo $(jq -r '.name' <<< "$container")

    if (($height >= $width)); then
        echo "higher than tall"
        swaymsg 'splitv'
    else
        echo "wider than tall"
        swaymsg 'splith'
    fi

done

