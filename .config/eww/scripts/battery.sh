#!/bin/bash
quick=$(acpi -b)
percentage=$(rg '([0-9]+%)' -or '$1' <<< $quick)
time_empty=$(rg ', (([0-9]+:)+[0-9]+)' -or '$1' <<< $quick)

echo '{ "percent": "'$percentage'", "time": "'$time_empty '"}'

upower --monitor-detail -i $(upower -e | grep 'bat') |
while read -r line; do
    if [[ $line =~ ^native-path: ]]; then
        if [[ -n $buffer ]]; then
            # echo $buffer
            percentage=$(rg 'percentage: +(.+%)' -or '$1' <<< $buffer)
            # echo $percentage
            time_empty=$(rg 'time to empty: +(.+)' -or '$1' <<< $buffer)

            echo '{ "percent": "'$percentage'", "time": "'$time_empty '"}'

            buffer=""
        fi
    fi

    buffer+="$line"$'\n'
done

