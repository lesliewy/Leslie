echo "============================= if else ===================================="
#if [ condition1 ] ; then
#   command1
#   command2
#elif [ condition2 ]; then
#   command3
#   command4
#else 
#   command5
#fi                               # if elif else fi
dir=/home/leslie
if cd "$dir" 2>/dev/null;then     #   2>/dev/null 忽略错误,否则会报: 目录不存在.
   echo " now in $dir"
else
   echo "Can't change to $dir"
fi
#if-grep 
file="/home/leslie/aa.txt"
if grep -q leslie "$file";then
   echo "$file contains at lease one occurrence of leslie"
fi                                #   if - command 形式很有用.  同样，也可以没有if
[ -z "$a" ] && echo "variable a is uninitialized"    

echo "============================= case ======================================"
#case "$variable" in
#   condition1 )
#      command1
#      command2
#      ;;
#   condition2 )
#      command1
#      command2
#      ;;
#esac
   
i=1
case $i in 
   1 ) echo "\$i is 1"
     ;;
   1 ) echo "\$i is 2"
     ;;
esac
#     conclusion: 如果有一个匹配了，就会终止case，不会执行case后面的内容. 不像c中那样存在fall through 现象.
c1=\;
case "$c1" in
   [[:lower:]])
      echo " Lowercase letter"
      ;;
   [[:upper:]])
      echo "uppercase letter"
      ;;
   [0-9])
      echo "Digit"  
      ;;
   \;|\,)
      echo "; or ,"
      ;;
   *)
      echo "Punctuation,whitespace or other"
      ;;
esac
#     conclusion: condition 条件可以是正则表达式,可以用 | ; [[:lower:]] [[:upper:]]只能用于单个字母.

    
echo "=================================== for ==================================="
#for arg in [list];do
#   command1
#   command2
#done

#for i  in 1 2 3 4 5 6 7 8 9 10            # First loop.
#do
#  echo -n "$i "
#  sleep 1
#done & # Run this loop in background.
#       # Will sometimes execute after second loop.
#echo   # This 'echo' sometimes will not display.
#for i in 11 12 13 14 15 16 17 18 19 20   # Second loop.
#do
#  echo -n "$i "
#  sleep 1
#done  
#echo   # This 'echo' sometimes will not display.
#

for planet in "Mecury 36" "Venus 67" "Earth 93" "Mars 142" "Jupiter 483" ;do
   set -- $planet
   echo "$1 $2"
done

#     conclusion :     [list] 可以自己列出来.
#                      set -- $planet  自动解析每一个 $planet, 给参数赋值.

echo "====================================while=================================="
#while [ condition ];do            # while [[ condition ]]; do   也可以.
#   command1
#   command2
#done
a=0
while [[ "$a" -lt 5 ]];do
   echo $a
   ((a++))
done

#      conclusion:   [[ condition ]] 也可以用在while 循环中.

condition1(){
  return 0
}
while condition1 ;do
   echo "while exec"
   break
done

#      conclusion:   和for 中一样,while 的[ condition ] 部分也可以调用函数. 函数返回0，就是true; 非0就是false;

echo "===================================until=================================="
#until [ condition ];do
#   command1
#   command2
#done

#END_CONDITION=end
#until [ "$var1" = "$END_CONDITION" ];do
#   echo "Input variable #1"
#   echo "($END_CONDITION to exit)"
#   read var1
#   echo "variable #1 = $var1"
#done

#      conclusion:  除非[ condition ] 为true,否则执行循环.

echo "===============================break========================================"
outer=1
for a in 1 2 3 4 5 ;do
   echo "outer=$outer"
   inner=1
   for b in 1 2 3;do
      echo "inner=$inner"
      let "inner=inner+1"
      break 2
   done
   let "outer=outer+1"
done
echo "end loop"
#     conclusion: 在嵌套循环中,break默认只能跳出它所在的循环，而不是全部,即 break 1;   break 2 跳出2它自己和上一层循环.

echo "==============================continue======================================"
outer=1
for a in 1 2 3 4 5;do
   echo "outer=$outer"
   inner=1
   for b in 1 2 3 ;do
      echo "inner=$inner"
      ((inner++))
      continue 2
   done
   ((outer++))
done
echo "end loop"
#     conclusion: 与break类似, continue 默认是它所在的循环,相当于continue 1;   continue 2 让它上一层循环继续下一个.
