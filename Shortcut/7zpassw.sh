#! /bin/bash

FILE="$1"
NUMOFJOBS="$2"
TOTAL=10000
BEGIN=$(date +%s)
echo "$FILE"

testpw(){
   local name="$1"
   local LOW="$2"
   local HIGH="$3"
   local pw="$LOW"
   local num=0
   echo "$name" "$(date)" "$LOW"-"$HIGH"": " 0
   while [ "$pw" -le "$HIGH" ];do
      num=$((num + 1))
      pw=$((pw + 1))
      now=$(date +%s)
      if [ $(( (now - BEGIN)  % 60)) == 0 ] && [ "$num" -ge 10 ];then
         echo "$name" "$(date)" "$LOW"-"$HIGH"": ""$num"
         num=0
      fi
      7z t -p"$pw" "$FILE" &> /dev/null
      if [ "$?" == 0 ];then
         echo "$name" "password: " "$pw"
         break;
      fi
   done
}

split(){
   numofjobs="$1"
   passwperone=$((TOTAL / numofjobs))
   i=0
   while [ "$i" -lt "$numofjobs" ];do
      testpw "job""$i" $((passwperone * i )) $((passwperone * (i + 1))) &
      i=$((i + 1))
   done
}

split "$NUMOFJOBS"