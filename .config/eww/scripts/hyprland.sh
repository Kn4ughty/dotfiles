#!/bin/bash

handle() {
  case $1 in
    workspace\>\>*) output $1 ;;
    activewindow\>\>*) output $1 ;;
    submap*) output $1 ;;
  esac
}

output() {
    case $arg1 in 
        "workspace")
            active=$(hyprctl activeworkspace -j | jq ".id")
            # hyprctl workspaces -j | jq -c --arg active "$active" ''
            hyprctl workspaces -j | \
                jq -c --argjson active "$active" 'map(.+={"focused":.id==$active})
                | sort_by(.name)'
            ;;
        "title")
            hyprctl activewindow -j | jq -r ".title" 
            ;;
        "submap") 
            # echo $1
            regex="^submap"
            if [[ $1 =~ $regex ]]; then 
                echo $1 | sed -E "s/submap>>(.*)/\1/"
            fi
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
