#! /bin/bash
# 用于缴话费回缴款取批扣文件
EX_OK=0
EX_ARGS=3                   # sftp_pes.sh 参数错误.
EX_NOTDIR=4                 # 指定的不是一个目录.
EX_SFTP_ERROR=5             # SFTP错误.
EX_NOCHK=6                  # 没取到.chk文件.
EX_FORMATDIR=7
EX_USAGE=9

#usage(){
#   echo "usage: `basename $0` remoteuser remoteip basedir localchkdatadir remotechkdatadir remotedatadir"
#   echo "    remoteuser:  远程sftp用户名."
#   echo "    remoteip:    远程机器ip."
#   echo "    basedir:     本地存放刚获取到的文件和日志的目录."
#   echo "    localchkdatadir:  本地存放带有chk的dat文件."
#   echo "    remotechkdatadir: 远程存放文件的bak目录."
#   echo "    remotedatadir:    远程目录."
#   exit $EX_USEAGE
#}
# 统一去掉目录最后面的 "/"
formatdir(){
   [ "$#" -ne 1 ] && echo "formatdir: args error" && exit $EX_FORMATDIR   
   a=`echo "$1"|sed -e 's/\/*$//g'` 
   echo $a
}
# 删除临时文件.
deletetempfiles(){
   rm -rf "$datadir_tmp"
   rm -rf "$sftpbatchfile1"
   rm -rf "$sftpbatchfile2"
   rm -rf "$logfile1"
   rm -rf "$logfile2"
}

[ "$#" -ne 6 ] && exit $EX_ARGS 
date=`date +%Y%m%d%H%M%S`
# remote user ip
remoteuser=$1
remoteip=$2

if [ -d "$3" ]; then
   basedir=`formatdir $3`  
else
   exit $EX_NOTDIR
fi
# 登记日志目录
logdir=${basedir}/log
# 日志名称
logfile=${logdir}/${date}.log
logfile1=${logdir}/${date}.log1              # 用于 &>.
logfile2=${logdir}/${date}.log2              # 用于 &>.
# 存放取回的所有的文件,是临时的,最后会删掉.
datadir_tmp=${basedir}/${date}
sftpbatchfile1=${basedir}/${date}.file1
sftpbatchfile2=${basedir}/${date}.file2

# local 带chk的dat文件存放目录
if [ -d "$4" ]; then
   localchkdatadir=`formatdir $4`  
else
   exit $EX_NOTDIR
fi

# remote 备份带chk的dat文件目录.
remotechkdatadir=`formatdir $5`
remotedatadir=`formatdir $6`

[ ! -d ${logdir} ] && mkdir ${logdir}
[ ! -d ${datadir_tmp} ] && mkdir ${datadir_tmp}
[ ! -f ${sftpbatchfile1} ] && touch ${sftpbatchfile1}
[ ! -f ${sftpbatchfile2} ] && touch ${sftpbatchfile2}

sftp -oPasswordAuthentication=no  $remoteuser@$remoteip:${remotedatadir}/* ${datadir_tmp}   &> ${logfile}    #  15 上不能使用 &>>  因为如果输错用户名会进入密码验证交互模式,必须阻止这种情况.
sftpreturn=$?
if [ "$sftpreturn" -ne 0 ]; then
   echo "sftp return: $sftpreturn" >>$logfile
   deletetempfiles
   exit $EX_SFTP_ERROR                                                   # sftp 报错,查看log
fi
# scp mktdev@127.0.0.1:wy/temp/* .

# 计算chk文件 + dat文件,.chk .CHK都支持.
chkflag1=`find ${datadir_tmp} -name *.chk`
chkflag2=`find ${datadir_tmp} -name *.CHK` 
if [ -z "$chkflag1" -a -z "$chkflag2" ];then
   echo "no check file." >>  ${logfile}
   deletetempfiles
   exit $EX_NOCHK
fi
if [ -n "$chkflag1" ];then
   datawithchk1=`ls ${datadir_tmp}/*.chk|sed -e 's/\.chk$/\.dat/g'`" "`ls ${datadir_tmp}/*.chk`
fi
if [ -n "$chkflag2" ];then
   datawithchk2=`ls ${datadir_tmp}/*.CHK|sed -e 's/\.CHK$/\.dat/g'`" "`ls ${datadir_tmp}/*.CHK`                              
fi
datawithchk=$datawithchk1" "$datawithchk2
for chkfile in `ls ${datadir_tmp}/*.chk 2>/dev/null` `ls ${datadir_tmp}/*.CHK 2>/dev/null`;do
   noimportfilename=`echo $chkfile|sed -e 's/\.chk$/\.noimport/g' -e 's/\.CHK$/\.noimport/g'` 
   touch $noimportfilename
   datawithchknoimport1=$datawithchknoimport1" ""$noimportfilename"
done
datawithchknoimport=$datawithchk" "$datawithchknoimport1 
echo "datawithchknoimport: ${datawithchknoimport}" >>${logfile}

# 将chk文件和dat文件转移,同时生成同名.noimport文件并转移.
cp $datawithchknoimport ${localchkdatadir} >>${logfile}
echo ${datawithchk} |tr ' ' '\n'|sed -e 's/^/put /g' > ${sftpbatchfile1}

# 将有chk文件的dat文件sftp至remote
sftp -oPasswordAuthentication=no -b ${sftpbatchfile1} $remoteuser@$remoteip:${remotechkdatadir}  &> ${logfile1}
sftpreturn=$?
if [ "$sftpreturn" -ne 0 ]; then
   cat ${logfile1} >> $logfile
   echo "sftp return: $sftpreturn" >>$logfile
   deletetempfiles
   exit $EX_SFTP_ERROR                                                   # sftp 报错,查看log
fi
cat ${logfile1} >> $logfile

# 删除remote的 .chk 和 与.chk前缀相同的.dat文件.
for line in `cat ${sftpbatchfile1}|cut -d ' ' -f 2`; do
   sftpbatchfile21=$sftpbatchfile21" "`basename $line`
done
echo ${sftpbatchfile21} |tr ' ' '\n'| sed -e 's/^/rm /g' > ${sftpbatchfile2}
sftp -oPasswordAuthentication=no -b ${sftpbatchfile2} $remoteuser@$remoteip:${remotedatadir}  &> ${logfile2}
sftpreturn=$?
if [ "$sftpreturn" -ne 0 ]; then
   cat ${logfile2} >> $logfile
   echo "sftp return: $sftpreturn" >>$logfile
   deletetempfiles
   exit $EX_SFTP_ERROR                                                   # sftp 报错,查看log
fi
cat ${logfile2} >> $logfile

# 删除本地临时文件.
deletetempfiles
times >> ${logfile}

exit $EX_OK
