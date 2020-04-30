#! /bin/bash
# 使用antiword 搜索doc里的内容.  antiword 不支持docx.
# 需要先下载antiword.

# 配置antiword 路径.
antiword=/Users/leslie/bin/antiword

USAGE(){
   cat << ENDOFUSAGE
   Usage:   `basename $0` docdir text
ENDOFUSAGE
}

[ "$#" -lt 2 ] && USAGE && exit $EX_USAGE

# 变换分隔符。将换行符作为分隔符, 防止文件名中包含空格.
IFS=$'\n'
OLDIFS="$IFS"
for docfile in `find $1 -iname "[!~]*.doc"`; do
   $antiword "$docfile"|grep -i $2 > /dev/null
   [ "$?" -eq 0 ] && echo "$docfile"
done
IFS="$OLDIFS"
