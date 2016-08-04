#! /bin/bash

# 用法
usage(){
   echo "`basename $0` {jar-file|jar-direcotry} src-directory"
   exit 1
}

# 检查路径是否绝对路径.
isabsolutedir(){
   $(echo $1|grep -q  "\./")               # $() 相当于 ｀｀,可以执行命令.
   if [ "$?" = "0" ];then
      echo "directory must be absolute."
      exit 15
   fi
   $(echo $1|grep -q  "\.\./")
   if [ "$?" = "0" ];then
      echo "directory must be absolute."
      exit 15
   fi
}

if [ "$#" -ne 2 ];then
   usage 
fi
jarentry=$1
sourcedir=$2

# $2 必须是目录
if [ ! -d "$2" ];then
   echo "$2 is not a directory"
   exit 3
fi

# 检查路径是否是绝对路径
isabsolutedir $1
isabsolutedir $2

tmpclassdir=$2/tmpclassdir
if [ ! -d "$tmpclassdir" ];then
   mkdir $tmpclassdir
fi

# $1 是目录的情况.
if [ -d "$1" ];then
#   jardir=`dirname $1`                      # dirname /app/etc/   :  /app
#   echo $jardir
   for jarfile in $(find $1 -name "*.jar") 
   do
     echo "jarfile:$jarfile" 
#     echo `basename $jarfile` >jarfiledirtmp
#     jarfiledir=`cut -f 1 -d . jarfiledirtmp` 
     jarfiledir=$(echo "$jarfile" |awk -F "/" '{if(/\.jar/) print substr($NF,1,length($NF)-4)}')
     echo $jarfiledir
     cd $tmpclassdir
     mkdir $jarfiledir
     cd $jarfiledir
     jar -xvf $jarfile  
     cd ../..
     mkdir $jarfiledir
     cd $jarfiledir
     jad -r -ff -d . -s java $tmpclassdir/$jarfiledir/**/*.class
   done 
# $1 jarfile的情况.
elif [ -f "$1" ];then
   ret=`grep -q ".jar$" "$1"`
   if [ -n "$ret" -a  "$ret" -ne 0 ];then
      echo "invalid jar-file."
      exit 2 
   fi
# $1 其他情况
else
   usage
fi
#rm -rf $tmpclassdir


