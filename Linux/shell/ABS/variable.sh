# shell 基础参考: https://www.cnblogs.com/maybe2030/p/5022595.html

echo "=================================== variables ==================================="
#a=$(ls -l)
#echo $a
#echo "before $aa1"
#export aa1=3
#echo "after $aa1"
#
#if [ -n "$1" ]; then
#   echo "#1: $1"
#fi
#if [ -n "$2" ]; then
#   echo "#2: $2"
#fi
#if [ -n "$10" ]; then
#   echo "#10:$10"
#fi
#num=$#
#lastarg=${!#}
#echo "lastarg: $lastarg"

#no_space_between_eq=                            # 变量赋值 = 前后不能有空格,否则会当作command来执行. 
#echo "no_space_between_eq = $no_space_between_eq" 
echo "================================\$a && \"\$a\"================================"
#i=                                   # i 是否初始化会导致结果不一样.
#if [ -n $i ];then
#   echo "i is initialized"
#else
#   echo "i is uninitialized"
#fi
#
#if [ -n "$i" ];then
#   echo "i is initialized"
#else
#   echo "i is uninitialized"
#fi
#
#abc="one two three"
#ab="one two"
#a=one
#echo abc=$abc
#echo ab=$ab
#echo a=$a
#
#list="one two three"
#for a in "$list"                           # $list 与 "$list" 结果不一样.
#do
#   echo "$a"
#done

#     conclusion:  a 已经初始化为非NULL, $a 与 "$a" 一样.
#                  a 未初始化(NULL),[ -n $a ] 判断始终正确.   [ -n "$a" ] 判断为NULL. 
#                  a 变量中存在空格, 在for 循环中 $a 以whitespace为分割, "$a"则阻止这种分割,同样,如果变量a中有换行,那么"$a"才能将a作为一个整体.
#                                    普通变量赋值情况下正常.                                     

echo "================================ Internal variable =========================="
#testIFS(){
#   for arg do
#       echo $*               #  加 “” 和不加 "" 不同.
#   done
#}
#v1="a+b+c"
#v2="a:b:c"
#echo "$v1  $v2"
#IFS=+
#echo "IFS:$IFS"
#echo $v1
#testIFS $v1
#IFS=:
#echo "IFS:$IFS"
#testIFS $v2
#echo $v2
#
##        conclusion:    echo 和 $* 的分隔符受 IFS 内部变量的影响,  除非加 ""
#
#echo "$LINENO: \$LINENO 这个不错"
#
#echo
#
#echo "\$SECONDS: 程序运行时间"
#while [ $SECONDS -lt 5 ]; do
#   echo "SECONDS : $SECONDS"
#   sleep 1
#done

echo "================================= Strings ===================================="
# 字符串长度
stringa="abcdefg123"
echo "length of $stringa: ${#stringa}"
echo "length of $stringa: `expr length $stringa`"         #  计算字符串长度2种方法.

# 子串位置
stringb="abcABC123 AAA"
echo "ABC is in position of $stringb:`expr index "$stringb" ABC`"    
echo "BCA is in position of $stringb:`expr index "$stringb" BCA`"     # 计算子串的位置:  expr index $string $substring      不是完全匹配的.

# 截取子串
stringc="123456abc"
echo "extract position 1 from $stringc: ${stringc:1}"
echo "extract position 2 from $stringc: ${stringc:2}"
echo "extract posiotion 1 from $stringc length 3: ${stringc:1:3}"     # 抽取子串:  ${string-name:position:length}    .其中position可以为负值(右边抽取)

# 删除子串
stringd="abcdefg1234abcdefg"
echo "remove shortest match a*c: ${stringd#a*c}"
echo "remove longest match a*c: ${stringd##a*c}"                      # 可以删除指定字符串:   ${string#regex}

# 替换子串
stringe="abcdefg1234abc"
echo "replace the first match of bc in $stringe: ${stringe/bc/xx}"
echo "replace the all matches of bc in $stringe: ${stringe//bc/xx}"   # 字符串替换:   ${string/reg/replacement}   ${string/\/home\/fdadm\//}  替换/home/fdadm/为空,注意转换.

echo "================================ parameter substitution ===================================="
#para1=
declare -i para1
para2=2
a=${para1:-$para2}
echo "a: $a"                      
#conclusion:    ${para1:-default} 前一个没有设置，则取后一个.  ${para1-default}和${para1:-default}区别是如果一个变量只是声明但是没有值(para= )，前一个将取值为空. 后一个取default值. 也就是说后一个只有当para1非空的情况下才取para1.
#               注意{ } 之间不要留有空格.   
para3=abc
#para3=
#declare -r para3
b=${para3=`pwd`}
echo "b:$b"                       # 暂时还没发现 ${a:-$para1} 和 ${a:=$para1}的区别.

#para3=${para2:?"must be set"}
#echo "para3:$para3"
#echo ${para4:?"must be set"}      #   para4没有设置，报错.

echo "=============================== command substitution ======================================="
#  ` ` 和 $() 两种形式,   $()支持嵌套使用.
a=$(echo "abc $(echo "123")" )
echo $a
pwd
pwd1=`pwd`
echo $pwd1
ls
grep -li a *

a=$(ls)
echo "\$(ls): $a"
#       conclusion:     在shell脚本中可以直接执行shell command,默认输出为stdout.
#                       如果将命令结果赋值，需要用到``来执行命令, 赋值也可以用$( ) 来执行command并返回执行结果。  不可以直接使用 ` `   和 $(), 如 `ls`



