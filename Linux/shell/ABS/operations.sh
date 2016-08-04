#! /bin/bash

echo "===============================(( )) constructor=========================="
#echo "(( )) 整数计算"
#((a=23))                      # 空格不是必须的.   表达式右值不能包含数字(0-9)以外的任何值,包括小数点.  ((a=023)): echo 显示的是19.
#echo "after \"((a=23))\",a is $a"
#echo "((a=23)) return value \$? is $?"                       # 0
#((0&&1))
#echo "((0&&1)) return value \$? is $?"                       # 1
#
#b=$((3+5))                   # 如果((3+5)),则结果会被抛弃，如果要保存结果,用$(( ))。
#echo "b = $b"
#
#let "c=((3+5))"              # 双引号必须的.
#echo "c = $c"                # c = 8

echo "=============================== num ============================================"
n=1
#n=n+1                       # n+1, 非数值计算.
echo -n "$n"                 # 1
n=a
let "n=n+1"                  # 1
echo -n "$n"
let n=n+1
echo -n "$n"                 # 2
let n="n+1"
echo -n "$n"
let "n=n+1"
echo -n "$n"
((n=n+1))
echo -n "$n"                 # 
#n=((n+1))                   # error
n=$((n+1))
echo -n "$n"
#[n=n+1]                     # error
n=$[n=$n+1]
echo -n "$n"
#     conclusion:   (( )) 和 let 中变量都可以不加"$";都不能进行浮点数运算；let 中如果右值变量未定义或包含非数字时，作0处理。
#                   要取得 (( )) 和 [ ] 中数值计算的结果需要$(( )) 、$[ ],  但是$[ ] 是旧时用法，现在以废弃.                    
echo
let n=17
echo -n "$n "         # 默认10进制
let n=017
echo -n "$n "         # 8进制
let n=0xab
echo -n "$n "         # 16进制
let n=2#1101
echo -n "$n "         # base#num
let n=21#23
echo -n "$n "         # base#num

echo
declare -r const=3
#readonly const 
#const=3              # error 不可以再次赋值.
#const++              # error, declare -r 声明只读; 等同于 readonly 关键字.

declare -i int1
int1=int+1            # 不需要加 $
echo "int1:$int1"
int1=6/2
echo "int1: $int1"
int1=abc
echo "int1: $int1"    # 声明为 -i 后，会自动的将其作为整数来处理,不能再是字符; 在表达式中时不需要再加上$来引用,单独引用变量值时，还是要加$

testfunc1(){
   echo "this is a test func."
}
declare -f testfunc1
testfunc1             #  declare -f : 列出函数及其内容. 并不是声明一个函数.

declare -x a=3        # declare -x : export


echo "=============================== array ==================================="

