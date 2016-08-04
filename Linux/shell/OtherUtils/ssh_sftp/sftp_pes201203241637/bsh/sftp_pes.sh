#! /bin/bash

EX_OK=0
date=`date +%Y%m%d%H%M%S`
#basedir=/media/S/Work/LESLIE/linux/shell/OtherUtils/ssh_sftp
basedir=$1
# 登记日志目录
logdir=${basedir}/log
# 日志名称
logfile=${logdir}/${date}.log
# 存放取回的所有的文件,是临时的,最后会删掉.
datadir_tmp=${basedir}/${date}
sftpbatchfile=${basedir}/${date}.file
# 带chk的dat文件存放目录
#localchkdatadir=${basedir}/chkdata
localchkdatadir=$2

# remote 备份带chk的dat文件目录.
remotechkdatadir=$3
remotedatadir=$4

 [ ! -d ${logdir} ] && mkdir ${logdir}
 [ ! -d ${datadir_tmp} ] && mkdir ${datadir_tmp}
 [ ! -f ${sftpbatchfile} ] && touch ${sftpbatchfile}

sftp mktdev@127.0.0.1:${remotedatadir}/* ${datadir_tmp}  &>> ${logfile}
# scp mktdev@127.0.0.1:wy/temp/* .
# 计算有chk文件的dat文件.
datawithchk=`ls ${datadir_tmp}/*.chk|sed -e 's/chk/dat/g'` &>> ${logfile}
echo ${datawithchk} &>>${logfile}

# 将有chk文件的dat文件转移.
cp $datawithchk ${localchkdatadir} &>>${logfile}

echo ${datawithchk} |sed -e 's/^/put /g' &>> ${sftpbatchfile}
# 将有chk文件的dat文件sftp至remote
#sftp -b ${sftpbatchfile} mktdev@127.0.0.1:${remotedatadir}

exit $EX_OK
