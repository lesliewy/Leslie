#! /bin/sh
##########################################
#   find specified text in jar files
#   Date : 2011-01-19   wy
##########################################

if [ "$#" -lt 2 ];then
  echo "usage:$0 jar-file classname."  
  exit 1
fi

# jar file name
jarname=$1
# class name
classname=$2

# jar file parameter
case "$1" in
   *|*.jar)
      for i in ../; do
         echo "$i"
      done
   ;;
esac
# jar file must be exist
[ ! -f "$1" ] && echo "$1 not exists" && exit 2
jar -tvf "$1"|grep -q "$2"
if [ "$?" -eq 0 ];then
   echo "$2 exists in $1."
else
   echo "$2 not exists in $1."
fi




