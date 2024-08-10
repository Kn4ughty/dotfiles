#! /bin/bash

# Config bits



name=$(uname -n)

if [[ "$name" == "unicorn" ]]
then
	eww daemon
	eww open time
else
	true
fi
