#! /usr/bin/sh
#
#ftp_wy.sh : to get the named file in the specified host.
#Date: 2011-01-19 wang_yang
#
checkip(){
   oip=$1
   # ���ip�ĸ�ʽ�Ƿ���ȷ.
   echo $oip|grep -q '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$'
   if [ "$?" -ne 0 ]; then
      echo "invalid ipaddress:$oip"
      exit 1
   fi
   ipa=$(echo $oip|awk -F . '{print $1}')
   ipb=$(echo $oip|awk -F . '{print $2}')
   ipc=$(echo $oip|awk -F . '{print $3}')
   ipd=$(echo $oip|awk -F . '{print $4}')
   # ���ip��ÿ���ֶ��Ƿ�����Ч�ķ�Χ��.
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
# IP ��ַ
ipaddr=$1
checkip $1
# �û���
username=$2
# ����
passwd=$3

# �����ļ���
filename=$4
remotedir=`dirname $filename`                                     # �ļ�Ŀ¼������ftp��.
remotefilename=$filename
localfilename=$(echo $filename |awk -F / '{print $NF}')
filebasename=$localfilename

cd /app/mng/data/mon/send/
# ����ͬ���ļ�ʱ������֮ǰ��¼�ļ���Ϣ
if [ -e "$localfilename" ]; then
   fileinfo_beg=`istat $localfilename`
   fileexists=1
fi
curday=`date +%d`
logdir=${HWORKDIR}/log/${curday}
[ -d "$logdir" ] || mkdir -p $logdir
logfil=${logdir}/ftp_wy.log

echo "WORKDIR:$WORKDIR"
# ͨ��ftp��ȡ�ļ�.
ftp -n ${ipaddr} << FTPEND 1>>${logfil} 2>>${logfil}
user ${username} ${passwd}
bin
cd $remotedir
get $filebasename
bye
FTPEND

fileinfo_end=`istat $localfilename`
# �ļ������ڣ�����
if [ ! -e "$localfilename" ]; then
   echo "error code 4:download failed."
   exit 4
fi
# �ļ�֮ǰ�Ѿ��������ж��Ƿ��������ص�
if [ "$fileexists" == 1 ]
then
   if [ "$fileinfo_beg" == "$fileinfo_end" ]
   then
      echo "error code 5:download failed."
      exit 5
   fi
fi