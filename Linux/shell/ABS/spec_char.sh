#echo "================================ # ===================================="
#echo "The # here does not begin a comment."           # echo 语句中的单/双引号中的 # 不是注视.
#echo 'The # here does not begin a comment.'
#echo The \# here does not begin a comment.            # echo 语句中的转义的# 该行不是注释.
#echo The # here begins a comment.
##echo ${PATH#*:}                                       # ????

#        conclusion:      在echo语句中,双引号中的# 和 转义的#(\#) 都不是注释.


#echo ========================================= echo =============================
## 将变量a的值作为参数. a的值以空格作为分隔符;  shift 仍然使用; 原来命令传递的所有变量都不存了(即使原来有10个变量此时也只有4个).
#set -- $a
#echo $1
#echo $2
#shift
#echo $3;  echo $4
#
#echo $a                            # 变量 a 中,有多个空格只会保留一个.
#echo "$a"                          # 加双引号会 preserve whitespace.
#echo \$*:        '    $*'          # 单引号中的所有字符都是literal string,不是命令.
#echo \$*:        "   $*"           # 双引号中的命令仍然有效.且双引号中是什么就是什么，有3个空格输出3个空格. 不过其中的 # 不再是注释.
#echo \$*:      $*     $*           # 没有单引号和双引号时，存在多个空格当作一个空格.    $*将当前所有的参数，看作一个整体.
#echo "\$@:" "$@"                   # 当前所有的参数, 每个参数是独立的.
#ret1=`echo abcd|grep 123`                        # 返回值为1,带有管道符的返回最后一个命令的执行结果.
#echo "\$?:$?"
#echo "ret1:$ret1"
#


