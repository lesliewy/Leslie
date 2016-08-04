#! /bin/bash
echo "==============================here document========================================"
#interactive-string <<limitstring
#command1
#command2
#limitstring
cat  <<-  End-of-message
---------------------------
	this is line 1.
this is line 2.
this is line 3.
---------------------------
End-of-message                    
#   Conclusion:   后面一个必须顶格写.


echo "===============================here string========================================="
String="This is a string"
read  -a strarr <<<$String              # 读入一个数组,   <<< 省略和不省意思不同.
echo " strarr[0]=${strarr[0]}"
echo " strarr[1]=${strarr[1]}"
echo " strarr[2]=${strarr[2]}"
echo " strarr[3]=${strarr[3]}"
echo " strarr[4]=${strarr[4]}"

echo "===============================IO redirection ====================================="
#0: stdin       1:stdout       2:stderr
cat <<ioredirectionend
M > N :  M 是file descriptor. N 是文件名.   不输入M,默认是1(stdout)
M > &N:  M 是file descriptor,N 是另一个file descriptor.不输入M,默认是1(stdout)
&> N :  & 是1,2(stdout,stderr),  N 是文件名.   注意, & 与 > 之间不能有空格.

ioredirectionend
ls -l > ls.log
ls -ly 2> ls.err1
ls -ly &>ls.err2
ls -ly 2>&1
echo "a"

declare -i a=1
a=a+1
echo "a=$a"
declare -i ind=0
while [ $ind -lt 10 ];do
   echo $ind
   let "ind=ind+1"
done > "while.log"

if [ $ind -eq 10 ];then
   echo $ind
fi > "if.log"
#    conclusion:  while , for , if/else, until 等代码块都可以在最后 进行输入输出重定向.  不过在sh(bourne shell)中不可用.

echo "================================Restricted shell=================================="
echo "before: `pwd`"
set -r
cd ../..
echo "after set -r: `pwd`"
PATH=/bin
ls > ls.log1

#     conclusion: set -r  设置为 restricted shell.       #! /bin/bash -r 设置整个脚本的执行为 restricted.

echo "================================process substitution==============================="
# <(command-list)
# >(command-list)

echo "================================ function ========================================="
# . analyse_func: 之间必须要有至少一个空格.
# 被载入的函数文件必须具有 r（读权限),否则会报permission denied。

a=3
func1(){
a=4
#local a=4
echo "in func1: a=$a"
}
func1
echo "after func1: a=$a"
func2=func1                  # func2指向函数func1
func2                       # 执行函数func2 

func1 "$variable1" "$variable2"            # 执行带有参数的函数,  函数定义部分: func1(){} 不能带参数.
result1=`func1 "$variable1" "$variable2"`  # 函数的结果赋值,也可以用``
#     conclusion: local 只用于function中. 加local的变量，只在function中起作用,外面不起作用.
echo "================================ and list   or list ==============================="
and1=1
and2=2
and3=3
[ "$and1" -lt "$and2" ] && [ "$and2" -lt "$and3" ] && (echo "$and1<$and2<$and3")
or1=1
or2=2
or3=3
[ "$or1" -gt "$or2" ] || [ "$or2" -gt "$or3" ] || (echo "$or1 <= $or2 <= $or3")

[ "$and1" -lt "$and2" ] && [ "$and3" -lt "$and2" ] || (echo -n "&& ||:";echo "$and1<$and2<=$and3")

#     conclusion:  && 只有当前面正确时后面的才会执行; || 只有当前面错误时后面的才会执行.

echo "================================ array ============================================"
array1[5]=3                                               # 赋值第一种方式
array1[15]=4                                                       
echo "array1[5]=${array1[5]}"
echo "array1[15]=${array1[15]}"
echo "array1[25]=${array1[25]}"
echo "array1[5]+array1[15]=`expr ${array1[5]} + ${array1[15]}`"   #  expr 中 + 前后必须要有空格.

array2=(zero one two three four five)                    # 赋值第二种方式
echo "array2[0]=${array2[0]} array2[3]=${array2[3]}"

array3=([8]=eight  [12]=twelve)
echo "array3[8]=${array3[8]} array3[12]=${array3[12]}"    # 赋值第三种方式

echo "output:"
echo "all array1 element: ${array1[*]}"          #  取array中所有值.
echo "array1 length: ${#array1[*]}"              #  取array长度.
echo "all array2 element: ${array2[@]}"
echo "array2 length: ${#array2[@]}"
echo "array2[0] length: ${#array2[0]}"           #  取array中某个值长度.

#     conclusion:  array 不需要声明就可以赋值，下标不需要连续;  与变量赋值一样，＝ 前后不能有空白.
#                  array 有3种赋值方式;  




