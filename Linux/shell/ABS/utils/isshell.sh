#! /bin/bash   
 # echo  comment here

usage(){
   echo "usage:isshell dir"
   exit;
}
if [ "$#" -eq 0 ]; then
   usage;
fi
if [ "$#" -gt 1 ]; then
   usage;
fi
dir=$1
for fil in $(ls $dir);do
#   echo -n  "$fil:"
    file $dir/$fil|grep -iq script            #  因为有 q 参数，所以不会输出.
#   echo "$?" 
   if [ "$?" -eq 0 ]; then
      echo -ne "$fil is script\n"
   fi
done

exit 0
