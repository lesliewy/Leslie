#! /bin/sh
echo $1
echo $2
a="1 2sssss 3    4"
# 将变量a的值作为参数. a的值以空格作为分隔符;  shift 仍然使用; 原来命令传递的所有变量都不存了(即使原来有10个变量此时也只有4个).
set -- $a
echo $1
echo $2
shift
echo $3;  echo $4

echo "\$*:""$*"            # 当前所有的参数，看作一个整体.
echo "\$@:" "$@"           # 当前所有的参数, 每个参数是独立的.

echo "================================ # ===================================="
echo "The # here does not begin a comment."
echo 'The # here does not begin a comment.'
echo The \# here does not begin a comment.            # 该行不是注释.
echo The # here begins a comment.
#echo ${PATH#*:}                                       # ????

#declare -i i=1
i=1
for element in $PATH ; do 
   echo "$i:$element"
   i=i+1
done
echo "===============================2====================================="
ret1=`echo abcd|grep 123`                        # 返回值为1,带有管道符的返回最后一个命令的执行结果.
echo "\$?:$?"
echo "ret1:$ret1"

