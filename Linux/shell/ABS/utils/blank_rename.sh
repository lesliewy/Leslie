#! /bin/bash

# ./blank_rename.sh
# 法一 : 文件名中的空格替换为_,只查找当前目录; 用grep判断是否有空格,有的话用sed作替换.
#ONE=1
#number=0
#FOUND=0
#
#for filename in *;do
#   echo "$filename"|grep -q " "
#   if [ $? -eq $FOUND ];then
#      fname=$filename
#      n=`echo $fname|sed -e "s/ /_/g"`
#      mv "$fname" "$n"                     # $fname 必须加双引号,因为其中包含空格.
#      let "number+=1"
#   fi
#done
#
#if [ $number -eq $ONE ];then
#   echo "$number file renamed."
#else
#   echo "$number files renamed."
#fi

# 法二:查找的目录由用户指定.
E_USAGE=64
[ "$#" -ne 1 ] && (echo "Usage: `basename $0` dir-name";echo "Exit.") && exit $E_USAGE

if [ ! -d "$1" ];then
   echo "Usage: `basename $0` dir-name."
   echo "Exit."
   exit $E_USAGE
fi

dir="$1"
blank_num=0
for blank_file in "$(find "$dir" -name "* *" -print)";do
   oldname=`basename "$blank_file"`
   newname=`echo "$oldname"|sed -e "s/ /_/g"`
   echo "oldname:$oldname length:${#oldname}"
   echo "newname:$newname length:${#newname}"
#   mv "$blank_file" $newname
   let "blank_num=$blank_num+1"
done
echo "$blank_num file(s) name changed."

