#! /bin/bash

# date_between.sh
# 法一:
# 说明: 计算输入的日期之间的间隔天数. 利用了date命令. 
#       判断日期是否合法时，date -d "date",根据返回值判断.
#       计算天数时利用 date -d "date -10 days" 或者 date -d "date 10 days ago" 从后面的日期一天一天的往前推算,直至等于前面的日期. 
# 输入参数:  date1  date2
# 参数说明: 日期格式为 20110302 
# 完成日期: 2011/10/04

E_USAGE=64
[ "$#" -ne 2 ] && (echo "Usage: `basename $0` date1 date2 (日期格式为20110302)";echo "Exit.") && exit $E_USAGE

date1=$1
date2=$2
[ "${#date1}" -ne 8 ] || [ "${#date2}" -ne 8 ] && (echo "日期格式必须为20110302";echo "Exit.") && exit $E_USAGE # date1和date2 处也可以是1,2(positional parameter)

# 判断日期是否合法.
date -d "$date1" &> /dev/null                # 不输出任何信息.
[ "$?" -ne 0 ] && (echo "invalid date1.";echo "Exit.") && exit $E_USAGE
date -d "$date2" &> /dev/null                # 不输出任何信息.
[ "$?" -ne 0 ] && (echo "invalid date2.";echo "Exit.") && exit $E_USAGE

# 利用date,开始计算
# 先判断日期的前后关系
if [ "$date1" \> "$date2" ];then
   big_date=$date1
   small_date=$date2
else
   big_date=$date2
   small_date=$date1
fi
#echo "big_date:$big_date"
#echo "small_date:$small_date"
declare -i index=0
echo "法一: begin"
times
while [ true ];do
   result_date=`date -d "$big_date $index days ago" +%Y%m%d`
#   echo "result_date: $result_date"
   if [ "$result_date" == "$small_date" ];then
      printf "$index day(s) between $big_date and $small_date\n"        
      break
   fi 
   index=index+1
done
times
echo "法一: end"

exit 0


# 法二
# 利用date计算日期差值.   date -d "date" +%j
# 如果年份相隔大于1的话,  date -d "20071231" +%j 来计算那年一共有多少天.
# 较小日期：  date -d "20071231" +%j  -  date -d "20070813" +%j
# 较大日期:   date -d "20090813" +%j 
# 输入参数: date1 date2
# 效率上比上面的的降低了2个数量级.   法一大部分的时间耗在了 子进程的执行上, 即 `date`的执行上,该方法尽量减少对子进程的调用.
# 但是受date日期范围的影响，32位表示的秒数不超过2038年,下限好像到19世纪的都不可以了, 法一和法二都不是通用的方法.
E_USAGE=64
[ "$#" -ne 2 ] && (echo "Usage: `basename $0` date1 date2 (日期格式为20110302)";echo "Exit.") && exit $E_USAGE

date1=$1
date2=$2
[ "${#date1}" -ne 8 ] || [ "${#date2}" -ne 8 ] && (echo "日期格式必须为20110302";echo "Exit.") && exit $E_USAGE   #  date1 和date2 处只能用变量名,不能用$1,$2

# 判断日期是否合法.
date -d "$date1" &> /dev/null                # 不输出任何信息.
[ "$?" -ne 0 ] && (echo "invalid date1.";echo "Exit.") && exit $E_USAGE
date -d "$date2" &> /dev/null                # 不输出任何信息.
[ "$?" -ne 0 ] && (echo "invalid date2.";echo "Exit.") && exit $E_USAGE

# 利用date,开始计算
# 先判断日期的前后关系
if [ "$date1" \> "$date2" ];then
   big_date=$date1
   small_date=$date2
else
   big_date=$date2
   small_date=$date1
fi

declare -i big_year=`date -d "$big_date" +%Y`               # 后面日期的年份
declare -i small_year=`date -d "$small_date" +%Y`           # 前面日期的年份
declare -i big_days=0                                       # 后面日期所在年的第几天
declare -i small_days=0                                     # 前面日期所在年的第几天
declare -i interval=0                                       # 前后日期的间隔天数
#echo "big_year: $big_year   small_year:$small_year"

# 如果是同一年
if [ "$big_year" -eq "$small_year" ];then
   big_days=`date -d "$big_date" +%j`
   small_days=`date -d "$small_date" +%j`
   echo "big_days:$big_days   small_days:$small_days"
   interval=big_days-small_days
   printf "%d day(s) between %s and %s\n"  $interval $big_date $small_date     # 与c中区别是这里没有 ",",用空格.
   exit 0
fi
# 间隔日期3个部分.
echo "法二: begin"
times
# 前面日期
last_day=1231
small_year_last=$small_year$last_day
small_days=$(expr $(date -d "$small_year_last" +%j) - $(date -d "$small_date" +%j))
interval=$small_days
#echo "small_days:$small_days"

# 中间年份
declare -i i
for (( i=small_year+1;i < $big_year;i++));do
   interval+=`date -d "$i$last_day" +%j`
#   echo "$i:$interval"
done
#echo "interval:$interval"

# 后面日期
#echo "big_date:$big_date"
#interval+=`date -d "$big_date" +%j`
interval=$(expr $(date -d "$big_date" +%j) + $interval)
#echo "day:`date -d $big_date +%j`" 
echo "$interval day(s) between $big_date and $small_date"
times
echo "法二: end"
exit 0
