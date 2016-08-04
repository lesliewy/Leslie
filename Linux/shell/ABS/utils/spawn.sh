#! /bin/bash

PIDS=$(pidof sh $0)
pid_array=$PIDS
echo $PIDS
let "instances=${#pid_array[*]} -1"

echo "$instances instance(s) of this script running."

echo "[Hit Ctrl-c to exit.]"
echo

sleep 1
sh $0
exit 0            #  永远不会执行这个.

