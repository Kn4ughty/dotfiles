#!/bin/bash

start_time=$(date "+%s")

notify-send "Rsync started!"
rsync -rtlP --safe-links --exclude={'.cache','*.sock','.cargo','.local/share/Steam'} --no-links /home/d/ /run/media/main/backup/d/

end_time=$(date "+%s")

elapsed_time=$((end_time - start_time))

elapsed_time_formatted=$(printf "%02d:%02d:%02d" $((elapsed_time/3600)) $(( (elapsed_time%3600)/60)) $((elapsed_time%60)))

notify-send "Rsync finished in $elapsed_time_formatted"


echo "////////////  DONE  ////////////"
echo "////////// Finished! ///////////"

echo "Rsync finished in $elapsed_time_formatted"
