#!/bin/bash
 
count=0;
for filename in `ls $1`; do
   # 不以notion, index开头, 以xls结尾的
   if [[ `expr $filename : "notion"` == 0 && -n `expr "$filename" : '.*\(xls\)'` && `expr $filename : "ind"` == 0 ]]; then
#      echo $filename
      mv $filename "notion_"$filename
      count=$(( count + 1 ));
   fi
done

echo "success... $count files changed."
