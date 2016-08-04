#! /bin/bash

# this script models brownian motion.

PASSES=500
ROWS=10
RANGE=3
POS=0
RANDOM=$$

declare -a Slots       # 声明一个数组.
NUMSLOTS=21

Initialize_slots(){
   for i in $(seq $NUMSLOTS); do
      Slots[$i]=0
   done
echo
}

Show_Slots(){
   echo -n " "
   for i in $(seq $NUMSLOTS); do
      printf "%3d" $[Slots[$i]]
   done
   echo 
   echo " |_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_| "
   echo 
}

Move(){
   Move=$RANDOM
   let "Move %= RANGE"
   case "$Move" in
      0)  ;;
      1)  ((POS--));;
      2)  ((POS++));;
      *)  echo -n "Error ";;
   esac
}

Play(){
   i=0
   while [ "$i" -lt "$ROWS" ]; do
      Move
      ((i++))
   done
   SHIFT=11
   let "POS += $SHIFT"
   ((Slots[$POS]++))
}

Run(){
   p=0
   while [ "$p" -lt "$PASSES" ]; do
      Play
      ((p++))
      POS=0
   done
}

#  main
Initialize_slots
Run
Show_Slots

exit $?
