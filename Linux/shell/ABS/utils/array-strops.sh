#! /bin/bash
set -x
arrayZ=( zero one two three four five)
echo ${arrayZ[@]:0}                  # 同样也可以: echo ${arrayZ[*]:0}        这两句都是相对于 array 中元素而言的. 
echo ${arrayZ[@]:1}
echo ${arrayZ[@]:1:3}

echo

echo ${arrayZ[@]#f*r}               # 删除array中所有以f开头r结尾的元素.
echo ${arrayZ[@]#f*}                # 对array中的每一个元素应用:  删除前面的一个或多个f.

echo ${arrayZ[@]/e/ee}              # 对array中每一个元素应用:  替换第一个出现的e为ee.

echo ${arrayZ[@]//e/ee}             # 替换所有出现的e.
echo ${arrayZ[@]/#t/ttt}            # 对array中每一个元素应用: 所有以t开头的元素,将t替换为ttt
echo ${arrayZ[@]/%e/eee}            # 对array中每一个元素应用: 所有以e结尾的元素,将e替换为eee



declare -a bigOne=( /dev/* )
echo "testing: =(${array[@]})"
times
declare -a bigTwo=( ${bigOne[@]} )
times
	
echo                                       # 这种赋值方法更快些,上面的有(),是一个元素一个元素的赋值,要慢些.
echo "testing: = ${array[@]}"
times
declare -a bigThree=${bigOne[@]}
times

