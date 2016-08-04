#! /bin/sh
# 由于缴话费回缴款上传文件.

# args 1: 待上传文件名,绝对路径表示.
# args 2: 远程目录.

EX_OK=0
EX_NOFILE=2           # 指定文件不存在.
EX_ARGS=3             # 参数错误.
EX_SFTP_ERROR=5       # sftp 报错, 具体信息看log.

formatdir(){
   [ "$#" -ne 1 ] && exit $EX_FORMATDIR
   a=`echo "$1"|sed -e 's/\/*$//g'`
   echo $a
}
deletetempfiles(){
   rm -rf $sftpbatchfile
}

date=`date +%Y%m%d%H%M%S`
[ $# -ne 4 ] && exit $EX_ARGS
# 远程用户,ip
remoteuser=$1
remoteip=$2
# 文件名称
[ ! -f $3 ] && exit $EX_NOFILE
absfilename=$3
filename=`basename $absfilename`
# 远程目录.
remotedir=`formatdir $4`

# 登记日志目录
absfilenamelength=`expr length $absfilename`
filenamelength=`expr length $filename`
sublength=`expr $absfilenamelength - $filenamelength`
logdir=`expr substr $absfilename 1 $sublength`"log"
# 日志名称
logfile=${logdir}/${date}.log
# sftp batch file
sftpbatchfile=${logdir}/${date}.file

[ ! -d $logdir ] && mkdir $logdir
[ ! -f $logfile ] && touch $logfile
[ ! -f $sftpbatchfile ] && touch $sftpbatchfile

# 新建.chk文件
chkfile=`echo "$absfilename"|sed -e 's/\.dat/\.chk/g'`
echo $filename >> $chkfile

# 上传文件
echo "put $chkfile" >> $sftpbatchfile
echo "put $absfilename" >> $sftpbatchfile
sftp -oPasswordAuthentication=no -b $sftpbatchfile $remoteuser@$remoteip:$remotedir > $logfile 2>&1
sftpreturn=$?
if [ "$sftpreturn" -ne 0 ]; then
   echo "sftp return: $sftpreturn" >>$logfile
   deletetempfiles
   exit $EX_SFTP_ERROR                                                   # sftp 报错,查看log
fi
# 删除临时文件
deletetempfiles

exit $EX_OK
