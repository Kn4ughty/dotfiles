#! /bin/bash

# Config bits



name=$(uname -n)

if [[ "$name" == "unicorn" ]]
then
	swaynag -m "a"
else
	swaynag -m "not unicorn"
fi
