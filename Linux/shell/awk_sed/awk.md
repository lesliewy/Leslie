============================================================myself==================================================================================
#======================================awk 命令====================================
# awk -f awksrc awk.txt  : awksrc中是awk程序, 如果省略awk.txt,则从标准输入读取.
# awk -F : awksrc awk.txt: -F 指定分隔符. 

# awk -F : '{print $2}' awk.txt      # :和'{}'之间必须要有空格.
# 注意: 在命令行中,命令必须要用''    awk -F : {print $2} awk.txt 是错误的.
#       过程必须要用{}               awk -F : 'print $2' awk.txt 是错误的.  过程包括: print等语句； if while等影响控制流的语句;   不包括: 类似a=3的赋值语句.
# awk -f check.awk a.txt   : check.awk文件中: BEGIN {  }  {   }  END {  }  类似这样有时是错误的，中间部分可能不需要用{ }框住:与在命令行中相同,中间如果是/abc/后面跟{print },则不需要，如果就只有一个print语句则需要.

# 可以用 ; 将多个命令放在同一行。 shell sed awk都是这样.
#{print}           #  即 {print $0}

# 在awk中字符串必须加 "",否则当空值处理. 与shell不同.
# 在awk中变量引用直接用变量名，不用加$, 与shell不同.如:
#x="abc"
#{print x;}

# awk 'a=1;/macro/{print $1;}'      由于a=1的存在，会导致输出文件中的每一行.
# awk '/macro/{a=1;print $1;}'      这样就不会输出每一行，只输出匹配macro的那一行的第一个字段.
# awk '{a=1;b=2; if(/macro/) {print $1;}}'  test1.dat   这样也不会输出每一行. 看来 if(/macro/) 和直接/macro/差别很大. 只要有过程语句在(/macro/后面的print不算),就不会输出每一行.

#==================================== 模式匹配 ===================================
#模式匹配的4种形式
#/1.?1/ {print $0;}           # 整行匹配,相当于 $0 ~ /1.?1/
#$1 ~/1.?1/ {print $0;}       # 字段匹配
#$1 !~/1.?1/ {print $0;}      # 不匹配式
#/<Switch/,/<\/Switch/{ }     # 和sed一样,awk支持正则表达式范围的模式匹配;但是注意，里面不能再嵌套一个范围的模式匹配，对于awk，这样会有歧义.

#模式匹配中，模式那一行至少要有一个"{",否则不对.
#/11/ {
#   print
#}
#/^$/
#{
#   print x+=1
#}
#================================ 内部变量 ========================
#BEGIN {
#   FS=":"                                    # 输入字段的分隔符,必须加""。 RS也是这样.
#   OFS="!"                                   # 输出字段的分隔符，默认是空格. 下面的$1,$2,$3,中虽然有","分隔,实际输出时是按此值分隔; 但是如果是空格,则仍按空格分隔,优先级比此处的高.
##}

#{
#   print "字段分隔符(FS):" FS                # 不管内部变量还是自定义变量，都不需要用$来引用. 但是 $1 $2 这种字段的引用除外.
#   print "输出字段分隔符(OFS):" OFS
#   print "当前字段个数(NF) :" NF
#   print "最后一个字段($NF) " $NF           
#   print "$1,$2,$3:"$1,$2,$3
#}
#END {
#print "记录条数(NR): " NR                    # 即处理的总行数.
#print "输入文件名(FILENAME):" FILENAME
#}

# ARGV ENVIRON 也是环境变量，是数组,名字都是大写.
# ENVIRON保存当前系统的环境变量.
#{
#   if(NR==3){
#      for (i=0;i<=ARGC;i++ )
#         print "ARGV:"i ":" ARGV[i]
#   }
#   if(NR==3){
#      for (item in ENVIRON)
#         print "ENVIRON:"item ":" ENVIRON[item]
#   }
#}

#  FS 变量可以放在shell命令行、BEGIN语句块、中间主块中.
#  RS 在unix中,不能是多个字符,在linux下可以. FS不管在哪都可以.
#  下面4行说明是错误的，暂时没删除.
#  在中间主块中要注意，如果要有预期效果,需要放在模式的前面，而不是模式的模式后面,print前面.    另外，完成后要修改回来.
#  FS=":"
#  /colon/ { print $1 $2}  
#  /colon/ { FS=":" print $1 $2}   # 这种不会达到效果，仍然没变.
#  真正原因是:
# FS 放在主块中情况.   是这样的: 我的awk是在读入一行时就已经根据当时的FS做了字段的分割.所以要想FS生效，必须在读入这一行之前设置.

# =============================条件 循环 数组 等其他影响控制流========================
# if while do..while for等都算是一个过程,必须包含在{}中,所以外面的{ }是不能少的. 而if条件中的{}则根据需要是否添加.
#{
#   if (NF==3)
#      print $3            # if 后不加{},则只此一个语句.
#      print "abc"
#}
# if 语句中不可以使用表示范围的正则表达式,如/macro/,/MACRO/{ };   但是可以使用表示行的: if ($0 ~ /macro/){  }  且必须加if,否则也不可以. /marco/{ }是不行的.

# while 循环.
#while (condition){
#   action1
#}

# do..while循环,至少执行一次.
#do{
#   action1
#}while(condition)

# for 循环.
#for(set_counter;test_counter;increment_counter){
#   action1
#}
# 特殊的for循环版本,可以访问关联数组中的所有元素.  注意访问顺序是随机的.
#for(variable in array-name){
#   actions;   # print variable,array-name[variable]
#}
  
# break continue
# next exit 可以影响主输入循环.
# next 导致主输入循环不执行后面的语句，读入下一个输入,控制流回到脚本的顶部.
# exit 结束主输入循环，转到END控制.   exit 5

# 数组
# 与shell中一样,不必声明,不必指定数组大小,下标不必连续.
#a[3]="abcd"
#{print a[3]}
# awk中数组是关联数组,下标不必是数字,可以是字符串。要注意数字与字符串的区别.
{
   if (NR==1){
      aa="a3"
      a[aa]="a"
      a["ab"]="ab"
      a["abc"]="abc"
      a["03"]="03"
      a[03]="03"                  
      a[3]=4                          # 会覆盖前面的a[03],而不会覆盖a["03"], 整数前面的0会被忽略. 如果是$1 $2这种是字面的引用，不会忽略前面的0.
      x=03
      a[x]="x"                        # 等同于a[03]="x"
      {print a[aa],a["a3"],a["ab"],a["abc"],a["03"],a[03],a[3]}
   }
}
# 测试是否是数组中成员.
#if ("abc" in a){
#   action
#}
# 删除数组中元素
# DELETE ARRAY-NAME[ITEM]

# ========================函数=================================
# function 中的参数须加","分隔.
# next 语句不能用于function中
# getline 执行后，NR增加1,此时print $0 为增加1后NR的记录
# 调用sed 删除文件中的行后，如果没有close文件，则文件的NR并不会减少，会照常计算.记录也不会出错.
# 例如: awk -f test1.awk test1.dat,而test1.awk中利用system执行了 sed 1,2d test1.dat >test2.dat 和mv test2.dat test1.dat,  此时虽然test1.dat减少了2行，但是在接下来的NR并不会减少2,会照常进行。但是如果再次调用上面的两条命令，则sed针对的将是删掉2行后的新文件.

# sprintf 用于右值. 例如: onefile_code=sprintf ("%s %s",onefile_code,NR)   而print printf 都是打印出来.

# ======================== 重定向 ============================
# awk 支持:    print FILENAME ": 第 " lineno " 行Switch 代码块中没有Default."   > "checklist.log" 
#              将会把输出信息输入checklist.log,没有会创建，注意文件名必须加 ""
#              但是通常在shell 中: awk -f switch_sed_chk.awk $1 &>checklist.log  会更好.




