#! /bin/bash

# crontab -e:   crontab -l   : crontab -r
# min | hour | day of month | mon | day of week | [user] | command
#  *     *        *             *      *           leslie     date "+%m%d%Y %H%M%S" >> crontabfile 
# min | hour | day of month | mon | day of week | command
#  *     *        *             *      *           date >> crontabfile
#   55     *        *            *       *           . /media/S/Work/LESLIE/linux/shell/OtherUtils/crontab/rmlog.sh >> /media/S/Work/LESLIE/linux/shell/OtherUtils/crontab/rmlog.log 
day=`date +%d`
rm_day=$((day - 3))
if [ "$rm_day" -lt 10 ];then
   rm_day=0$rm_day
fi
dir_path=~leslie/trc/$rm_day
if [ -d "$dir_path" ];then
   rm -rf "$dir_path"
   date
   echo "删除目录$dir_path"
fi
