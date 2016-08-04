#! /bin/bash

#----------------------------------------------
# 利用iconv批量转换指定目录的文件;
#----------------------------------------------

EXIT_OK=0
EXIT_USAGE=64
# 用法说明
USAGE(){
   cat << ENDOFUSAGE
Usage:   `basename $0` -f encoding [-t encoding] [-d dictory] [inputfiles]
  `basename $0` [-d dictory]              :绝对路径,将指定目录内的所有文件的编码进行转换,在原文件名后面添加.backup0000;
ENDOFUSAGE
}

transfiles(){
   # for test begin
   echo "fromencoding: $fromencoding  toencoding: $toencoding  dirname: $dirname"
   # for test end   

   for file in `find "$dirname" -maxdepth 1 -type f`; do
      newfile="$file".backup
      mv "$file" "$newfile"
      # 通常是 iconv -f cp936 -t utf-8 file -o newfile;  如果file中有中文且不是cp936的话，报错:iconv: incomplete character or shift sequence at end of buffer
      iconv -f $fromencoding -t $toencoding "$newfile" -o "$file"
   done

}


[ "$#" -eq 0 ] && USAGE && exit $EX_USAGE

while getopts ":f:t:d:" option; do
   case "$option" in 
      "f")
         fromencoding=$OPTARG
         ;;
      "t")
         toencoding=$OPTARG
	 ;;
      "d") 
         [ -z "$fromencoding" ] && USAGE && exit $EX_USAGE 
	 if [ -z "$toencoding" ]; then
            toencoding=utf-8
	 fi
	 dirname=$OPTARG 
         transfiles $dirname 
         exit $EXIT_OK
	 ;;
      *) 
	 echo "no this option" && USAGE && exit $EXIT_USAGE
         ;; 
   esac
done	
