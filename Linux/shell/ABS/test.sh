#! /bin/bash
echo "=====================================test=================================="
a=" "
#a=
if test -z "$a"; then
   echo "variable a  null"
else 
   echo " variable a not null"
fi                                   
if [ -z "$a" ]; then
   echo "variable a  null"
else 
   echo " variable a not null"
fi                                   
# conclusion:  test 是一个命令.与 [ 相同,不过 [ 要求有匹配的 ］.
#              -z 判断是否是null, a=   是null， a=" " 则a不是null.                

echo "================================ [ ] ==========================================="
echo "Testing \"0\""
if [ 0 ]; then            # [ 后面和 ] 前面都要有空格. 因为 [ 是一个命令.
   echo "0 is true"
else
   echo "0 is false"
fi                        # 0 is true.

echo "Testing \"1\""
if [ 1 ] ; then
   echo "1 is true"
else
   echo "1 is false"
fi                        # 1 is true.

echo "Testing \"-1\""
if [ -1 ] ; then
   echo "-1 is true"
else
   echo "-1 is false"
fi                        # -1 is true.

echo "Testing NULL"
if [    ] ; then
   echo "NULL is true"
else
   echo "NULL is false"
fi                        # NULL is false

echo "Testing \"xyz\""
if [ xyz ] ; then
   echo "xyz is true"
else 
   echo "xyz is false"
fi                                          # xyz is true

echo "Tesing \"\$xyz\""
if [ $xyz ];then
   echo "uninitialized variable is true"
else 
   echo "uninitialized variable is false"
fi                                         # uninitialized variable is false

echo " Testing \"-n \$xyz\""
if [ -n "$xyz" ]; then
   echo "uninitialized variable is true"
else 
   echo "uninitialized variable is false"
fi                                         # uninitialized variable is false
  
xyz=    
if [ $xyz ];then
   echo "NULL variable is true"
else 
   echo "NULL variable is false"
fi                                         # NULL variable is false
echo 
if [ $xyz ];then
   echo "NULL variable is true"
else 
   echo "NULL variable is false"
fi

   

if [ 3>5 ]; then
   echo "3 is greater than 5"
else
   echo "3 is less-eq than 5"
fi
#let "test_ret_val=[ 3 > 5 ]"            不知道怎么输出 [ 计算结果
echo "test_ret_val = $test_ret_val"

#         conclusion:  [  在数值比较、文件是否存在、变量是否初始化等情况下才会返回NULL,即判断为false.  数字0和字符形式的NULL均判断为true.
if [ 5>3 -a 2>1 ]; then
   echo "5>3 && 2>1 with [ ]"
fi
if [[ 5 >3 &&  2 >1 ]];then
   echo "5>3 && 2>1 with [[ ]]"
fi

stra="bac"
strb="bba"
if [[ "$stra" > "$strb" ]];then
   echo "$stra > $strb"
else
   echo "$stra < $strb"
fi
#   conclusion: 在[ ] 中只能用 -a,不能用 &&;  在 [[ ]] 中只能用 &&,不能用 -a.
#               在[ ] 中操作符与值之间可以没有空格; 在[[ ]]中必须与前一个值有空格.               
#               如果是字符串比较,在[[ ]] 中直接使用 > 或 < ,但是在[ ] 中必须要进行转义 "\>" 或 "\<"               
#               在[ 后面至少要有一个空格, ] 前面至少要有一个空格.
echo "==========================================[[ ]]======================================="
decimal=10
octal=012
if [ "$decimal" -eq "$octal" ];then
   echo "$decimal=$octal"
else 
   echo "$decimal!=$octal"
fi

if [[ "$decimal" -eq "$octal" ]];then
   echo "$decimal=$octal"
else 
   echo "$decimal!=$octal"
fi                                         #  [[ ]] 内部可以进行计算,而 [ ] 不行.



