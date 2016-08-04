#! /bin/bash

# 如果在《linux 命令详解词典-施威铭研究室》书中存在，就以那里为主,本文件中都是不存在那里的命令.

echo "============================ built in =============================================="
# 1 echo

# 2 printf
declare -r pi=3.141592653
printf "pi is %1.3f\n"  $pi
name=leslie
printf "my name is \t%s\n" $name
#     conclusion:  printf 类似c中的printf。

# 3 read
#echo -n "input variable a:"
#read a
#echo "a is $a" 
#echo -n "input variable a 、b 、c:"
#read a    b      c
#echo -e "a is $a\nb is $b\nc is $c\n"
#echo "variable x is:"
#read
#echo "x is $REPLY"
#     conclusion: read 后可以接多个变量,以空格或tab隔开,输入时同样以空格或tab隔开.
#                 如果只有一个read，那变量保存在环境变量$REPLY中.

# 4 cd

# 5 pwd

# 6 pushd popd dirs
pushd "/home/leslie"
pushd "/home/leslie/leslie/wy"
echo "The top entry array in the DIRSTACK array is $DIRSTACK"
popd
popd
#      conclusion:  pushd 压入目录栈,popd出栈,dirs显示目录栈中内容,$DIRSTACK 栈首.

# 7 let

# 8 eval
a='$b'
b='$c'
c=123
echo "a is $a in echo"
eval echo "a is $a in 1 eval"
eval eval echo "a is $a in 2 eval"
lscommand="ls -l"
eval $lscommand
#     conclusion : eval 将字符串转为命令执行.

# 9 set
echo -e  "before set: #1 is $1  #2 is $2\n"
set `ls`
echo -e "after set: #1 is $1  #2 is $2\n"
set new1 new2
echo -e "after set: #1 is $1  #2 is $2\n"
v1="one two three"
set -- $v1
echo -e "after set -- \$v1: $@"
#     conclusio: set 后面跟空格分割的字符串，则将该部分设置成脚本参数($1,$2,$*等);   set -- $variable,显示的这么做.
#                set :列出所有已经定义的环境变量和自己设置的变量，还有函数.

# 10 unset

# 11 export
name=leslie
export name
export name=wy
#     conclusion:  export的变量只能在该进程及其子进程中引用，没办法设置到父进程中去.
#                  所以常用在启动脚本中(.bashrc)

# 12 declare typeset

# 13 readonly    = declare -r

# 14 getopts       # 解析参数
#   while getopts ":f:lt:" option; do
#      case "$option" in 
#         "f")...
#           ;;
#         "l")...
#           ;;
#         "t")...
#           ;;
#         *)...
#           ;;
#      esac
#   done
   # 上例中-f -t 后面必须要有参数. -l 后面没有参数.  第一个:是必须的.

# 15 source (. command)
#source  file-name
#     conclusion: 执行脚本,如果file 是可执行文件的话,  否则将其中代码include 进脚本.      dot command 更通用些.

# 16 exit

# 17 exec
#   exec echo "Existing,commands after exec will never be execute."
#     conclusion:  exec 后的脚本不会再执行.

# 18 shopt    改变shell参数.

# 19 caller
func1(){
   caller 0
}
func1
#     conclusion:  返回调用该函数的命令所在脚本及行数.  调式中有用.

# 20 true false

# 21 type     基本同which ， type -a

# 22 hash
#     conclusion: hash ls 将ls 命令放入hash table,下次直接取，不需要查找 $PATH

# 23 bind

# 24 help

# 25 jobs 

# 26 bg fg

# 27 wait
# wait  pid
#     conclusion:  等待指定的进程执行完,  如果不加参数，则等待所有的正在执行的程序执行完.

# 28 suspend

# 29 logout

# 30 times

# 31 kill

# 32 killall

# command
#     command ls:　　　本次执行将会忽略对ls做过的alias操作，以原来的形式执行, 仅是此次执行.  也不需要用unalias了.

# builtin        以shell builtin 命令来运行后面的程序.   builtin kill

# enable
#     conclusion:  enable -n kill :  禁止kill命令以builtin 形式执行. enable -a 查看所有可以用builtin形式执行的命令.  

