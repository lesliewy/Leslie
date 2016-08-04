#! /bin/bash
# 用于缴话费回缴款取文件
EX_OK=0
EX_USAGE=9
EX_FORMATDIR=3
EX_NOTDIR=4
EX_NOCHK=5                  # 没取到.chk文件.
usage(){
   echo "usage: `basename $0` remoteuser remoteip basedir localchkdatadir remotechkdatadir remotedatadir"
   echo "    remoteuser:  远程sftp用户名."
   echo "    remoteip:    远程机器ip."
   echo "    basedir:     本地存放刚获取到的文件和日志的目录."
   echo "    localchkdatadir:  本地存放带有chk的dat文件."
   echo "    remotechkdatadir: 远程存放文件的bak目录."
   echo "    remotedatadir:    远程目录."
   exit $EX_USEAGE
}
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
}

[ "$#" -ne 6 ] && usage
date=`date +%Y%m%d%H%M%S`
# remote user ip
remoteuser=$1
remoteip=$2

if [ -d "$3" ]; then
   basedir=`formatdir $3`  
else
   echo "$3 is not a directory"
   exit $EX_NOTDIR
fi
# 登记日志目录
logdir=${basedir}/log
# 日志名称
logfile=${logdir}/${date}.log
# 存放取回的所有的文件,是临时的,最后会删掉.
datadir_tmp=${basedir}/${date}
sftpbatchfile1=${basedir}/${date}.file1
sftpbatchfile2=${basedir}/${date}.file2

# local 带chk的dat文件存放目录
if [ -d "$4" ]; then
   localchkdatadir=`formatdir $4`  
else
   echo "$4 is not a directory"
   exit $EX_NOTDIR
fi

# remote 备份带chk的dat文件目录.
remotechkdatadir=`formatdir $5`
remotedatadir=`formatdir $6`

[ ! -d ${logdir} ] && mkdir ${logdir}
[ ! -d ${datadir_tmp} ] && mkdir ${datadir_tmp}
[ ! -f ${sftpbatchfile1} ] && touch ${sftpbatchfile1}
[ ! -f ${sftpbatchfile2} ] && touch ${sftpbatchfile2}

sftp $remoteuser@$remoteip:${remotedatadir}/* ${datadir_tmp}   &> ${logfile}    #  15 上不能使用 &>>
# scp mktdev@127.0.0.1:wy/temp/* .

# 计算chk文件 + dat文件.
chkflag=`find ${datadir_tmp} -name *.chk`
if [ -z "$chkflag" ];then
   echo "no check file." >>  ${logfile}
   deletetempfiles
   exit $EX_NOCHK
fi
datawithchk=`ls ${datadir_tmp}/*.chk|sed -e 's/chk/dat/g'`" "`ls ${datadir_tmp}/*.chk` >> ${logfile} 
echo "datawithchk: ${datawithchk}" >>${logfile}

# 将chk文件和dat文件转移.
cp $datawithchk ${localchkdatadir} >>${logfile}
echo ${datawithchk} |tr ' ' '\n'|sed -e 's/^/put /g' > ${sftpbatchfile1}

# 将有chk文件的dat文件sftp至remote
sftp -b ${sftpbatchfile1} $remoteuser@$remoteip:${remotechkdatadir} >> ${logfile}

# 删除remote的 .chk 和 与.chk前缀相同的.dat文件.
for line in `cat ${sftpbatchfile1}|cut -d ' ' -f 2`; do
   sftpbatchfile21=$sftpbatchfile21" "`basename $line`
done
echo ${sftpbatchfile21} |tr ' ' '\n'| sed -e 's/^/rm /g' > ${sftpbatchfile2}
sftp -b ${sftpbatchfile2} $remoteuser@$remoteip:${remotedatadir}  >> ${logfile}

# 删除本地临时文件.
deletetempfiles

exit $EX_OK
