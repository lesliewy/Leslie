#! /bin/bash

saveDir="/home/leslie/Work/HTML/Template"
logFile=$saveDir/download.log
# http://jsdx.sc.chinaz.com/Files/DownLoad/moban/201607/moban1382.rar
#commonUrl="http://jsdx.sc.chinaz.com/Files/DownLoad/moban/201607/moban"   # [1300, 1500]
commonUrl="http://jsdx.sc.chinaz.com/Files/DownLoad/moban/201606/moban"    # [1300, 1400]

for i in `seq -s " " 1300 1 1400`;do
   filename1=${saveDir}/moban${i}.rar
   filename2=${saveDir}/moban${i}
   if [ -e $filename1 -o -e $filename2 ];then
      echo "$filename1 exists." >>$logFile
      continue
   fi

   url=${commonUrl}${i}.rar
   echo "downloading $url..." >>$logFile
   ret=`aria2c -q -d $saveDir $url`
   # 3: If a resource was not found.
   if [ $? == 0 ]; then
      echo "success."  >>$logFile
   else
      echo "url not found." >>$logFile
   fi
   sleep 2
done
