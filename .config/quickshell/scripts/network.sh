#!/usr/bin/env bash

# TODO. display SSID

# output of `nmcli -m multiline -t -f STATE`
# STATE:connected
# CONNECTIVITY:full
# WIFI-HW:enabled
# WIFI:enabled
# WWAN-HW:missing
# WWAN:enabled
# METERED:no (guessed)

# Get value with `nmcli -g KEY g` -> value

# For STATE,        it is "connected"   | "disconnected"
# For CONNECTIVITY, it is "full"        | "none"

DEVICE_NAME=$(nmcli -g DEVICE device status | head -n 1 )

get_wifi_icon () {
    local state
    state=$1

    case "$STATE" in
        "connecting")
            echo 󱛇
            return 0
            ;;
        "connected (site only)")
            echo 󰤩
            return 0
            ;;
        "connected")
            echo 
            return 0
            ;;
        "disconnecting")
            echo 󱚼
            return 0
            ;;
        "disconnected")
            echo 󰤯
            return 0
            ;;
        *)
            echo 󰤫
            return 1
            ;;
    esac
}

nmcli m | 
while read -r line; do
    DATA=$(nmcli -m multiline -t g)
    STATE=$(rg 'STATE:(.+)' -or '$1' <<< $DATA)
    IP=$(nmcli -g IP4.ADDRESS device show $DEVICE_NAME)
    SSID=$(nmcli -g GENERAL.CONNECTION device show $DEVICE_NAME)
    # WIFI_HW=$(rg 'WIFI-HW:(.+)' -or '$1' <<< $DATA)
    # DEVICE_STATUS=$(nmcli -m multiline -t device status)

    icon=$(get_wifi_icon "${STATE}")

    jq -c -n \
        --arg state "${STATE}"\
        --arg icon "${icon}"\
        --arg ip "${IP}"\
        --arg ssid "${SSID}"\
        '{ state: $state, icon: $icon, ip: $ip, ssid: $ssid}'
done
