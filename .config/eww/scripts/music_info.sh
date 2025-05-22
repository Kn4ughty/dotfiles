#!/bin/bash

## Get data
STATUS="$(mpc status)"
COVER="/tmp/.music_cover.jpg"
MUSIC_DIR="$HOME/Music"

## Get status
get_status() {
	if [[ $STATUS == *"[playing]"* ]]; then
		echo "images/icons/music/pause-button.png"
	else
		echo "images/icons/music/play-button.png"
	fi
}

## Get song
get_song() {
    playerctl --follow metadata --format {{title}}
}

## Get artist
get_artist() {
    playerctl --follow metadata --format {{artist}}
}

get_time() {
    playerctl --follow metadata --format '{{duration(position)}}'
}

get_time_s() {
    playerctl --follow metadata --format '{{position}}'
}

get_total_time() {
    playerctl --follow metadata --format '{{duration(mpris:length)}}'
}

get_total_time_s() {
    playerctl --follow metadata --format '{{mpris:length}}'
}

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
if [[ "$1" == "--song" ]]; then
	get_song
elif [[ "$1" == "--artist" ]]; then
	get_artist
elif [[ "$1" == "--status" ]]; then
	get_status
elif [[ "$1" == "--time" ]]; then
	get_time
elif [[ "$1" == "--time_s" ]]; then
	get_time_s
elif [[ "$1" == "--totaltime" ]]; then
	get_total_time
elif [[ "$1" == "--totaltime_s" ]]; then
	get_total_time_s
elif [[ "$1" == "--cover" ]]; then
	get_cover
elif [[ "$1" == "--toggle" ]]; then
	mpc -q toggle
elif [[ "$1" == "--next" ]]; then
	{ mpc -q next; get_cover; }
elif [[ "$1" == "--prev" ]]; then
	{ mpc -q prev; get_cover; }
fi
