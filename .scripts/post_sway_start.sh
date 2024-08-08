#! /bin/bash

# Config bits



name=$(uname -n)

if [[ "$name" == "unicorn" ]]
then
	exec eww deamon
	exec eww open time
else
	true
fi
