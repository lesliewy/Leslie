#! /usr/bin/sh
#
#ftp_wy.sh : to get the named file in the specified host.
#Date: 2011-01-19 wang_yang
#
checkip(){
   oip=$1
   # 检查ip的格式是否正确.
   echo $oip|grep -q '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$'
   if [ "$?" -ne 0 ]; then
      echo "invalid ipaddress:$oip"
      exit 1
   fi
   ipa=$(echo $oip|awk -F . '{print $1}')
   ipb=$(echo $oip|awk -F . '{print $2}')
   ipc=$(echo $oip|awk -F . '{print $3}')
   ipd=$(echo $oip|awk -F . '{print $4}')
   # 检查ip中每个字段是否在有效的范围内.
   for i in $ipa $ipb $ipc $ipd; do
      if [ i -ge 256 -o i -le 0 ]; then
         echo "invalid ip field:$oip:$i"
         exit 2
      fi
   done
}
if [ "$#" -lt 4 ];then
   echo "usage: $0 ipaddress username passwd file"
   exit 3
fi
# check ip address
# IP 地址
ipaddr=$1
checkip $1
# 用户名
username=$2
# 密码
passwd=$3

# 下载文件名
filename=$4
remotedir=`dirname $filename`                                     # 文件目录，用于ftp中.
remotefilename=$filename
localfilename=$(echo $filename |awk -F / '{print $NF}')
filebasename=$localfilename

cd /app/mng/data/mon/send/
# 存在同名文件时，下载之前记录文件信息
if [ -e "$localfilename" ]; then
   fileinfo_beg=`istat $localfilename`
   fileexists=1
fi
curday=`date +%d`
logdir=${HWORKDIR}/log/${curday}
[ -d "$logdir" ] || mkdir -p $logdir
logfil=${logdir}/ftp_wy.log

echo "WORKDIR:$WORKDIR"
# 通过ftp获取文件.
ftp -n ${ipaddr} << FTPEND 1>>${logfil} 2>>${logfil}
user ${username} ${passwd}
bin
cd $remotedir
get $filebasename
bye
FTPEND

fileinfo_end=`istat $localfilename`
# 文件不存在，报错
if [ ! -e "$localfilename" ]; then
   echo "error code 4:download failed."
   exit 4
fi
# 文件之前已经存在则判断是否是新下载的
if [ "$fileexists" == 1 ]
then
   if [ "$fileinfo_beg" == "$fileinfo_end" ]
   then
      echo "error code 5:download failed."
      exit 5
   fi
fi