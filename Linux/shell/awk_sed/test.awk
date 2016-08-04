#BEGIN{output="output.dat"}
#{
#   if(NR==2){
##      getline
#      next
#   }
#   print $0>>output
#}
## awk将双引号中内容直接传给shell，非双引号内容先在awk程序中找
#END{system("mv " output " 111.dat")}


#BEGIN {
#   IGNORECASE=1
#}
#{
#IGNORECASE=1
#/macro/ { print "leslie" }
#}

# FS 放在主块中情况. FS=" " 放置的位置影响结果，不知道为什么.  是这样的: 我的awk是在读入一行时就已经根据当时的FS做了字段的分割.所以要想FS生效，必须在读入这一行之前设置.
#{
#if (var=="a"){
##   FS=" "
##   if($1 ~ /leslie/) {print FILENAME "|$0:"$0"|""$1:"$1"|""$2:"$2"|" "FS:"FS}
##   FS=":"
#   FS="[:\"]"
#   if($1 ~ /colon/) {print FILENAME "|$0:"$0"|""$1:"$1"|""$2:"$2"|" "FS:"FS}
##   FS=" "
##   FS="\""
#   if($1 ~ /quote/) {print FILENAME "|$0:"$0"|""$1:"$1"|""$2:"$2"|" "FS:"FS}
##   FS=" "
#
#}
#}

# awk 忽略大小写功能.
# 使用tolower实现.
#tolower($0)~/ignorecase/{print}


# 数组
{
arr["a"]="a"
arr["ab"]="ab"
var1="a"
if(var1 in arr){
   print var1 " in array arr:" arr[var1]
}
}


# 使用system
#/leslie1/{
#   print system("cut -d :  -f 3" $0)
   # 可以取grep的输出，0表示查询到； 1表示没有查询到.   不明白awk&sed书中： 这个命令的输出结果是不可用的.
#   a=system("grep abcd test1.dat > /dev/null")   
#   print a
#}

#  使用split ,下标从1开始。arr[0]是空的.
#/leslie1/{
#   split($0,arr,"\"")
#   print "arr[0]:"arr[0]
#   print "arr[1]:"arr[1]
#   print "arr[2]:"arr[2]
#   print "arr[3]:"arr[3]
#   print "arr[4]:"arr[4]
#
#}

#/leslie1/{
#   a="1"
#   b="2"
#   printf ("%s %s\n",a,b)           # printf 不能作为右值，赋给一个变量，它是要输出的.
##   c=sprintf ("%s %s",a,b)         # sprintf 不输出，只是格式化.
##   print c
#}
