#!/usr/bin/env bash
#
# sway-to-yuck.sh — Dump workspace layout as Eww/Yuck boxes
#
# Requires: swaymsg, jq

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <workspace-name-or-number>"
  exit 1
fi
WS="$1"

# jq “walk” function: if a node has children, emit a box with orientation;
# otherwise emit a leaf box labeled with the window’s title.
TREE_JSON="$(swaymsg -t get_tree)"

jq -r --arg ws "$WS" '
  def emit:
    if (.nodes | length) > 0 then
      # determine orientation: splith → horizontal, splitv → vertical
      "(box :orientation \"" +
      (if .layout == "splith" then "horizontal"
       elif .layout == "splitv" then "vertical"
       else "vertical" end) +
      "\""
      + ( .nodes[] | " " + emit )
      + ")"
    else
      # leaf: use window title (or class) as label
      "(box :class \"window\" :label \"" + (.name // .window_properties.class // "<no-title>") + "\")"
    end;

  # find the matching workspace node
  .nodes[]
  | select(.type=="workspace" and .name==$ws)
  | emit
' <<<"$TREE_JSON" | {
  # wrap into a defwidget
  echo "(defwidget workspace-$WS []"
  sed 's/^/  /'
  echo ")"
}

