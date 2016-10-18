#! /bin/bash
#  我自己的备份脚本.
EXIT_OK=0
EXIT_USAGE=64
DROPBOX_HOME=/home/leslie/Dropbox
# 通常使用这个，dropbox不能用了.
LESLIE_HOME=/home/leslie/Work/Leslie

USAGE(){
   cat << ENDOFUSAGE
Usage:   `basename $0` [-l] [-d]
  `basename $0`  -l              :列出所有备份内容.
  `basename $0`  -d              :备份到dropbox
  `basename $0`  -m              :备份到LESLIE目录.
ENDOFUSAGE
}

old(){
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
   

}

backup2dropbox(){
   cp /home/leslie/.vimrc $DROPBOX_HOME/Leslie/Linux/Vim
   cp /home/leslie/.bashrc $DROPBOX_HOME/Leslie/Linux/shell
   cp /home/leslie/.vimperatorrc $DROPBOX_HOME/Leslie/vimperator
   cp /opt/Software/ProgrammingSoftware/Eclipse/links/* $DROPBOX_HOME/Leslie/eclipse/plugins-links
   cp /opt/tomcat/apache-tomcat-7.0.26/bin/mydeploy.sh  $DROPBOX_HOME/Leslie/Linux/shell
   echo "backup2dropbox success..."
}
backup2Leslie(){
   cp /home/leslie/.bashrc $LESLIE_HOME/Linux/shell
   cp /home/leslie/.vimrc $LESLIE_HOME/Linux/Vim
   cp /home/leslie/.vimperatorrc $LESLIE_HOME/Vimperator
   cp /opt/Software/ProgrammingSoftware/Eclipse/links/* $LESLIE_HOME/Eclipse/plugins-links
   # L derefence, copy 所指向的文件. 2016-10-18：不需要了，只保留 $LESLIE_HOME/Leslie 下的.
#   cp -rL /home/leslie/Shortcut/* $LESLIE_HOME/Linux/Shortcut
   cp /opt/tomcat/apache-tomcat-7.0.26/bin/mydeploy.sh $LESLIE_HOME/Shortcut
   echo "backup2Leslie success..."
}



[ "$#" -eq 0 ] && USAGE && exit $EX_USAGE
while getopts ":ldm" option; do
   case "$option" in
      "l")cat <<ENDOFBACKUP
   1)/home/leslie/.bashrc   to $LESLIE_HOME/Linux/shell
   2)/home/leslie/.vimrc    to $LESLIE_HOME/Linux/Vim
   3)/home/leslie/.vimperatorrc   to $LESLIE_HOME/Vimperator
   4)/opt/Software/ProgrammingSoftware/Eclipse/links    to $LESLIE_HOME/Eclipse/plugins-links
   5)/opt/tomcat/apache-tomcat-7.0.26/bin/mydeploy.sh   to $LESLIE_HOME/Shortcut
ENDOFBACKUP
      exit $EXIT_OK
      ;;
      "d") backup2dropbox
           exit $EXIT_OK
	      ;;
      "m") backup2Leslie
           exit $EXIT_OK
	      ;;
       *) echo "no this option" && USAGE && exit$EX_USAGE	      
              ;;
   esac
done

exit $EXIT_OK

