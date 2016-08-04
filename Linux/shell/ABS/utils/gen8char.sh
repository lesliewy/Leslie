#! /bin/bash

# gene8char.sh  
# 说明: 随机产生8个字符，包括大小写字母.  A-Z(65-90) a-z(97-122)
#       这种方法扩展行很不好，如果要添加可用字符，很不方便.   可以考虑ABS上的方法，将所有可以用的字符组成一个长字符串，然后利用${STRING:POS:LEN}每次随机截取
#       一个,然后进行拼接.
# 参数: 无.
# 时间: 2011.10.08

declare -i modnum=(122+1)-65 charnum index=0           # 可以放在同一行，需要用空格隔开;可以赋初值.
#declare -i charnum 
#declare -i index=0
#RANDOM=$$           # 种子值取脚本进程号.
SEED=$(head -1 /dev/urandom |od -N 1|awk '{print $2}')   # 利用系统产生随机数的设备.
RANDOM=$SEED
while [ true ];do
#   let "charnum=$RANDOM % $modnum + 65"                # 使用let事先不需要声明为整数.
   charnum="$RANDOM % $modnum + 65"                     # 用这种方式就不能加空格了,如果要加需要用 ". 此时charnum必须先被声明为整数,否则当字符串处理.
   if [ $charnum -gt 90 -a $charnum -lt 97 ];then       # 整数在[ ] 中用 -gt -lt等, 在(( ))中用 > < >= <=.   
      continue
   fi 

#   ((index++))
#   index=index+1                                               # 也可以,但是不能有空格.

#   if [ $index -gt 8 ];then
#      break
#   fi
   if [ "${index:=1}" -gt 8 ];then                      # 另一种方式,利用 parameter substitution.
      break
   fi

   ((index++))
   oct=`printf "%o" $charnum`                                    # 转换成八进制.
   echo -ne "\0$oct"                                            # 输出ascii码表示的数值，如果是sh解析的，不需要加 -e 参数.
done
echo

exit 0
