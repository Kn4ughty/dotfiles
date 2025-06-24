#!/bin/bash

SOURCE="alsa_input.pci-0000_0b_00.4.analog-stereo"
PORT="analog-input-linein"
SINK="alsa_output.pci-0000_0b_00.4.analog-stereo"

# Grep for existing loopback module
MODULE_ID=$(pactl list short modules | grep "module-loopback" | grep "$SOURCE" | grep "$SINK" | awk '{print $1}')

if [ -n "$MODULE_ID" ]; then
    echo "Disabling loopback (module $MODULE_ID)..."
    pactl unload-module "$MODULE_ID"
else
    echo "Switching source to Line-In..."
    pactl set-source-port "$SOURCE" "$PORT"
    echo "Enabling loopback..."
    pactl load-module module-loopback source="$SOURCE" sink="$SINK" latency_msec=5
fi

