#! /bin/bash

aaa=1
while [ $aaa -lt 255 ]
do
bbb=`printf "%o" $aaa`
echo "bbb: $bbb"
/bin/echo  -e "\0$bbb"
aaa=`expr $aaa + 1`
done
