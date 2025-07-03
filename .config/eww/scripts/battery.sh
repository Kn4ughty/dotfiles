#!/bin/bash
# this script isnt very good

# quick=$(acpi -b)
# percentage=$(rg '([0-9]+%)' -or '$1' <<< $quick)
# time_display=$(rg ', (([0-9]+:)+[0-9]+)' -or '$1' <<< $quick)
#
# echo '{ "percent": "'$percentage'", "time": "'$time_display '"}'


get_icon () {
    local percentage 
    local ischarging

    percentage=$1
    ischarging=$2

    if [[ -z ischarging ]]; then
        echo 󱉝
        return 0
    fi

    if [[ -n $ischarging ]]; then
        if (( $percentage == 100 )); then
            echo 󰂅
            return 0
        fi
        if (( $percentage >= 90 )); then
            echo 󰂋
            return 0
        fi
        if (( $percentage >= 80 )); then
            echo 󰂊
            return 0
        fi
        if (( $percentage >= 70 )); then
            echo 󰢞
            return 0
        fi
        if (( $percentage >= 60 )); then
            echo 󰂉
            return 0
        fi
        if (( $percentage >= 50 )); then
            echo 󰢝
            return 0
        # ...
        fi
        if (( $percentage >= 40 )); then
            echo 󰂈
            return 0
        fi
        if (( $percentage >= 30 )); then
            echo 󰂇
            return 0
        fi
        if (( $percentage >= 20 )); then
            echo 󰂆
            return 0
        fi
        if (( $percentage >= 10 )); then
            echo 󰢜
            return 0
        fi
        echo 󰢟
        return 0
    else
        if (( $percentage == 100 )); then
            echo 󰁹
            return 0
        fi
        if (( $percentage >= 90 )); then
            echo 󰂂
            return 0
        fi
        if (( $percentage >= 80 )); then
            echo 󰂁
            return 0
        fi
        if (( $percentage >= 70 )); then
            echo 󰂀
            return 0
        fi
        if (( $percentage >= 60 )); then
            echo 󰁿
            return 0
        fi
        if (( $percentage >= 50 )); then
            echo 󰁾
            return 0
        fi
        if (( $percentage >= 40 )); then
            echo 󰁽
            return 0
        fi
        if (( $percentage >= 30 )); then
            echo 󰁼
            return 0
        fi
        if (( $percentage >= 20 )); then
            echo 󰁻
            return 0
        fi
        if (( $percentage >= 10 )); then
            echo 󰁺
            return 0
        fi
        echo 󰂎
        return 0
    fi
}

# get_icon "12" 'yes'


upower --monitor-detail -i $(upower -e | grep 'bat') |
while read -r line; do
    if [[ $line =~ ^native-path: ]] && [[ -n $buffer ]]; then

        percentage=$(rg 'percentage: +([0-9]+)' -or '$1' <<< $buffer)
        if [[ -z $percentage ]]; then
            percentage=1
        fi
        state=$(rg 'state: +(.+)' -or '$1' <<< $buffer)

        if [[ -z $state ]]; then
            state='unknown'
        fi
        
        
        if [[ $state == "charging" ]]; then
            time_display=$(rg 'time to full: +(.+)' -or '$1' <<< $buffer)
            is_charging="yes"
        else
            ischarging=''
            time_display=$(rg 'time to empty: +(.+)' -or '$1' <<< $buffer)
        fi
        
        # Get icon
        icon=$(get_icon $percentage $is_charging)



        echo '{ "percent": "'$icon $percentage'%", "time": "'$time_display '", "icon": "'$icon'"}'

        buffer=""
    fi

    buffer+="$line"$'\n'
done


