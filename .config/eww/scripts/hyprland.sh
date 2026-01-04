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
            active=$(hyprctl activeworkspace -j | jq ".id")
            # hyprctl workspaces -j | jq -c --arg active "$active" ''
            hyprctl workspaces -j | jq -c --argjson active "$active" 'map(.+={"focused":.id==$active})'
            ;;
        "title")
            hyprctl activewindow -j | jq ".title" 
            ;;
    esac

}


arg1=$1

# if [ $2 = "initial" ]; then
#     output
#     exit
# fi
output


socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
    | while read -r line; do handle "$line"; done
