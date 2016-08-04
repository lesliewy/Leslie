#! /bin/bash

E_FILE_ACCESS=70
E_WRONG_ARGS=71

if [ ! -r "$1" ];then
   echo "Can't read from input file."
   echo "Usage:$0 input-file output-file"
   exit $E_FILE_ACCESS
fi

if [ -z "$2" ];then
   echo "Need a output file."
   exit $E_FILE_ACCESS
fi

exec 4<&0                # 保存0
exec < $1                # 从input file 中读取.

exec 7<&1                # 保存1
exec > $2                # 输出到 output file

cat - |tr "a-z" "A-Z"
echo "Succeed in "
exec 1>&7 7>&-           # 恢复1
exec 0<&4 4<&-           # 恢复0    不恢复的话，以后所有的输入输出都在指定的文件里.

echo " Succeed."
exit 0
