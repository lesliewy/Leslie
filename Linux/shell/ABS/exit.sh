#echo "================================ exit status ==================================="
#true 
#echo $?
#! true
#echo $?

echo "================================= (( )) && let ================================="
((0&&1))                     # ./(用#!解析，需要有x权限,或者直接bash test.sh) 执行，而不要用sh test.sh(＝dash test.sh) 来执行，这样会报错，用的是dash,而不是bash。 let declare 等命令都是这样.
echo $?                      #1
let "num=((0&&1))"
echo $?                      #1
echo $num                    #0 同$((0&&1)).

a=$((0&&1))
echo "a = $a"                # a = 0.  计算 0 && 1的值.

(( 3+5 ))
echo $?                      # 0
(( 3>5 )) && echo "3>5"      # false
(( 5>3 )) && echo "5>3"      # true
# conclusion:(( ))constructor :如果计算的内容为0，则(( )) 返回1,或者是false；  如果计算的结果非0，则(( ))返回0,或true.
#            let  constructor :同上.
a=4
b=3
if (( a>b));then
   echo "$a > $b"
else 
   echo "$a <= $b"
fi                           # 

(( a>b )) && echo "$a>$b"      # false
(( b>a )) && echo "$b>$a"      # true
# conclusion:   (( )) 中变量可以不加$.
