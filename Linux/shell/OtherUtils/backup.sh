#! /bin/bash
#  我自己的备份脚本.
USAGE(){
   cat << ENDOFUSAGE
Usage:   `basename $0` [-l]
  `basename $0`  -l              :列出所有备份内容.
ENDOFUSAGE
}

EXIT_OK=0
EXIT_USAGE=64

#[ "$#" -eq 0 ] && USAGE && exit $EX_USAGE
while getopts ":l" option; do
   case "$option" in
      "l")cat <<ENDOFBACKUP
   1)/media/S/Work/LESLIE/  whole directory.
ENDOFBACKUP
      exit $EXIT_OK
      ;;
   esac
done
suffix=`date +%Y%m%d`
logfile="backup_${suffix}.log"
# 备份内容
backup1="/media/S/Work/LESLIE"
backup2="/media/L/my"
# 每个待备份内容小于该值才会备份.
limitsize=200

declare -i size1
size1=`du -sm $backup1|cut -f 1`
echo "$backup1 size : $size1 m"
if [ "${size1:-0}" -le "$limitsize" ];then
   echo "backup $backup1 begin"
   tar -cvz -f "leslie_${suffix}.tar.gz" $backup1 &> $logfile              # & 与 > 之间不能有空格.
fi

exit $EXIT_OK
