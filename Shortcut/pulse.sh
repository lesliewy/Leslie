#! /bin/bash
# ubuntu 12.04
#pulseid=`ps -ef|grep pulse|awk '{if ($3 == 1 && $1 == 112) print $2}'`
# ubuntu 14.04 && 16.04  kill 掉 pulseAudio 的进程.  pulseAudio 是ubuntu 用来管理声音的，另外一个备选的是alsa.
pulseid=`ps -ef|grep pulse|awk '{if ($3 == 1 && $1 == "speech-+") print $2}'`
if [ -n "$pulseid" ]; then
   printf "kill pulse id: $pulseid\n"
   echo -e "leslie1987\n"|sudo -S kill $pulseid
fi
printf "\npulse is killed\n"

