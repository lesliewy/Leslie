#! /bin/bash

# 递归输出指定目录下的所有的broken symbolic link
[ $# -eq 0 ] && directorys=`pwd` || directorys=$@
linkchk(){
   for element in $1/*; do
      [ -h "$element" -a ! -e "$element" ] && echo "$element"
      [ -d "$element" ] && linkchk $element
   done
}
for directory in $directorys;do
   if [ -d $directory ];then
      linkchk $directory
   else 
      echo "$directory is not a directory"
      echo "usage:$0 dir1 dir2 ..."
   fi 
done
exit $?
