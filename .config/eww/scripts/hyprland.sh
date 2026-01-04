#!/bin/bash

handle() {
  case $1 in
    workspace\>\>*) output ;;
    activewindow\>\>*) output ;;
    # monitoradded*) echo "Monitor connected: $1" ;;
    # configreloaded*) echo "Configuration reloaded" ;;
  esac
}

output() {
    case $arg1 in 
        "workspace")
            hyprctl workspaces -j | jq -c
            ;;
        "title")
            hyprctl activewindow -j | jq ".title" 
            ;;
    esac

}


arg1=$1

output

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
    | while read -r line; do handle "$line"; done
