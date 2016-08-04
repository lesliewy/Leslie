#! /bin/bash
pulseid=`ps -ef|grep pulse|awk '{if ($3 == 1 && $1 == 112) print $2}'`
if [ -n "$pulseid" ]; then
   printf "kill pulse id: $pulseid\n"
   echo -e "leslie1987\n"|sudo -S kill $pulseid
fi
printf "\npulse is killed\n"

