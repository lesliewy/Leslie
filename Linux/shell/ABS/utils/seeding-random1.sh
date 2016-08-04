#! /bin/bash

MAXCOUNT=25

random_numbers(){
   count=0
   while [ "$count" -lt "$MAXCOUNT" ];do
      number=$RANDOM
      echo -n "$number "
      let "count++" 
   done
   echo
}

echo; echo;
RANDOM=1                       # 设置种子值, 同一种子值产生的随机数相同.
random_numbers

echo;echo
RANDOM=2
random_numbers

echo;echo;
RANDOM=$$                      # 利用当前shell的pid.
random_numbers

echo;echo;
SEED=$(head -1 /dev/urandom |od -N 1|awk '{print $2}')   # 利用系统产生随机数的设备.
RANDOM=$SEED
random_numbers
