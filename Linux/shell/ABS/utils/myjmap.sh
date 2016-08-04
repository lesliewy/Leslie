#! /bin/bash

EX_USAGE=64
EX_NOPID=1

suffix=`date +%Y%m%d%H%M%S`
[ "$#" -ne 1 ] && echo "Usage : `basename $0`  java-programe" && exit $EX_USAGE
while true ;do
   java_pid=`jps -l | grep $1 | awk '{print $1}'`
   if [ -z ${java_pid:=""} ];then
      echo "Oh, no this java programe !"
      exit $EX_NOPID
   fi
   date>>$1${suffix}.jmap
   jmap "$java_pid" &>> $1${suffix}.jmap
   file_size=`du -sm $1${suffix}.jmap | awk '{print $1}'`
   [ $file_size -gt 1 ] && exit 0
   echo "============================================================================================================================">>$1${suffix}.jmap
   sleep 1
done

exit 0
