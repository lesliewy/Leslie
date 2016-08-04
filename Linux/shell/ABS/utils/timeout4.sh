#! /bin/bash
# 利用 read -t 设置超时.
TIMELIMIT=4

echo -n "set variable="
read -t $TIMELIMIT variable

if [ -z "$variable" ];then
   echo "time out! variable still unset."
else
   echo "variable= $variable"
fi


