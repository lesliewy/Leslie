#! /bin/bash

# "rename" utility.
#  ./rn.sh  "a*" b:    将所有以一个或多个a开头的文件替换为以b开头
#  类似a*，必须加双引号,否则shell会解析,只要以重复a开头的都算，参数个数就无法保证.
ARGS=2
E_BADARGS=85
ONE=1
echo "$#: $0  $1  $2"

if [ "$#" -ne "$ARGS" ];then
   echo "Usage: `basename $0` old-pattern new-pattern"
   exit $E_BADARGS
fi
number=0
for filename in *$1* ;do
   if [ -f "$filename" ];then
      fname=`basename $filename`
      n=`echo $fname | sed -e "s/$1/$2/"`
      mv $filename $n
      let "number+=1"
   fi
done

if [ "$number" -ne "$ONE" ];then
   echo "$number file renamed"
else
   echo "$number files renamed"
fi
exit $?
