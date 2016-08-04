#! /bin/bash
# 使用前一定要先备份.
# 粗糙版本，没有完善.
EX_USAGE=64

declare -i i=0
[ "$#" -ne 1 ] && echo "`basename $0`: directory " && exit $EX_USAGE
for file in `find $1 -name "*.java"`;do
    i=i+1
   sed -i -e 's:^/\* *[0-9]* *\*/::g' $file            # -i 直接修改原文件,不可以直接用 s:^/\*.*\*/::1  去替换，因为假如一行有多个/* */, 它也不会只替换第一个，会替换第一个/*  和最后一个*/之间的所有内容,  感觉是从后往前匹配的.
done

echo "total files: $i"
