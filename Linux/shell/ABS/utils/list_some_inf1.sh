#!/bin/sh

{
echo "date & time: `date "+%Y/%m/%d %H:%M:%S"`"  
#echo "date & time: ${date '+%Y/%m/%d %H:%M:%S'}"      #  wrong

echo "users logged in:"  
echo "`who`"

echo "system boot time: `who -b`" 
} > list_some_inf1.txt 





