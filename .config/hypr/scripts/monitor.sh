#!/bin/bash

handle() {
  case $1 in
    monitoradded\>\>*) 
        mon=$(sed -E "s/.*>>(.*)/\1/" <<< $1)
        eww open bar --allow-duplicates --arg mon=$mon
        ;;
    monitorremoved\>\>*) 
        # eww open bar --arg mon=$mon
        # cant close a monitor on a specfic window
        echo $1;;
  esac
}

IFS=$'\n'

mons=$(hyprctl monitors -j | jq -r '.[].name')

while read -r mon; do
    if echo $mon | grep -e 'headless'; then
        continue
    fi
    eww open bar --allow-duplicates --arg mon=$mon
    sleep 2
done <<< "$mons"


socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
    | while read -r line; do handle "$line"; done

