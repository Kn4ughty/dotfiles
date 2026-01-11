#!/usr/bin/fish

# modes (-m | --mode)
# output
# window
# region
# active

#  capture a window                      \`hyprshot -m window\`

function window_cap
    set --local windows $(hyprctl clients -j)
    set --local monitors $(hyprctl monitors -j)

    # Filter to only things on active monitors
    set --local windows $(echo $windows | jq -r '[.[] | select(.workspace.id 
    | contains('$(echo $monitors | jq -r 'map(.activeWorkspace.id) | join(",")')'))]')

    set --local found "$(echo $windows | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"
    set --local selected $(echo $found | slurp -r)

    grim -g $selected - | wl-copy
end
# window_cap

function output_cap
    grim -g "$(slurp -o)" - | wl-copy
end
# output_cap

function active_workspace
    grim -o $(hyprctl activeworkspace -j | jq -r '.monitor') - | wl-copy
end

function box_cap
    grim -g "$(slurp)" - | wl-copy
end
# box_cap

switch $argv[1]
    case "window"
        window_cap
    case "activeworkspace"
        active_workspace
    case "output"
        output_cap
    case "box_cap"
        box_cap
end

