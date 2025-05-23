#!/bin/bash

## Get data
STATUS="$(mpc status)"
COVER="/tmp/.music_cover.jpg"
MUSIC_DIR="$HOME/Music"

get_status_image() {
    playerctl --follow status 2>/dev/null | while read -r status; do
        if [[ "$status" == "Playing" ]]; then
            echo "images/music/pause-button.png"
        else
            echo "images/music/play-button.png"
        fi
    done
}

get_status_glyph() {
    playerctl --follow status 2>/dev/null | while read -r status; do
        if [[ "$status" == "Playing" ]]; then
            echo ""
        else
            echo ""
        fi
    done
}

# Im not using this ATM but keeping it for future reference
## Get cover
get_cover() {
	ffmpeg -i "${MUSIC_DIR}/$(mpc current -f %file%)" "${COVER}" -y &> /dev/null
	STATUS=$?

	# Check if the file has a embbeded album art
	if [ "$STATUS" -eq 0 ];then
		echo "$COVER"
	else
		echo "images/music.png"
	fi
}

## Execute accordingly
if [[ "$1" == "--status" ]]; then
	get_status_image
elif [[ "$1" == "--statusg" ]]; then
	get_status_glyph
elif [[ "$1" == "--toggle" ]]; then
	mpc -q toggle
elif [[ "$1" == "--next" ]]; then
	{ mpc -q next; get_cover; }
elif [[ "$1" == "--prev" ]]; then
	{ mpc -q prev; get_cover; }
fi
