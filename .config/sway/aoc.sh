#!/usr/bin/env bash

update_scale () {
    AOC_JSON=$(swaymsg -t get_outputs -r | jq '.[] | select(.make == "AOC")')
    if [[ -z "$AOC_JSON" ]]; then
        echo "did not find aoc"
        continue
    fi

    echo "Found AOC!"

    reso=$(echo "$AOC_JSON" | jq '.current_mode.width')
    scale=$(echo "$AOC_JSON" | jq '.scale')

    if [[ "$reso" = "3840" && "$scale" != '1.75' ]]; then 
        swaymsg output \$AOC resolution 3840x2160@160;
        swaymsg output \$AOC scale 1.75;
    elif [[ "$reso" = "1920" && "$scale" != '1.0' ]]; then 
        swaymsg output \$AOC resolution 1920x1080@320;
        swaymsg output \$AOC scale 1;
    else
        echo "unknown resolution! $reso"
    fi
}

update_scale

swaymsg -m -t subscribe '["output"]' |
while read -r event; do
    update_scale

done
