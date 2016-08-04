#指定字段分隔符，输出每行的第一个字段,对每一行都会执行除了BEGIN块和END块中的内容.
#BEGIN {FS=":"}{print $1;}
#输出包含leslie的所有行
#/leslie/ {print;}
#if 前面的"{"和最后一个"}"不能少
#BEGIN {FS=":"} {if($1=="leslie") {print $3;} else {print $2;}}
#检索每一行，如果第一个字段包含"esl",则输出该行的第三个字段
#BEGIN {FS=":"} $1 ~/esl/ {print $3;}
#检索每一行，如果第一个字段包含"esl"并且第二个字段是"x"，则输出改行.
#BEGIN {FS=":"} ($1 ~/esl/)&&($2=="x") {print;}
#检索每一行,查找是否存在空行.
#BEGIN {FS=":";x=0;} /^$/ {x=x+1;} END{print "I found ",x," blank lines";}
#检索每一行，将第一个字段的值加1，如果非数值型字符串,则默认该字段值为0，然后加1
#BEGIN {FS=":";} {print $1+1;}
#输出第20行
#BEGIN {FS=":";} {if(NR==20) {print $0;}}
#字段分隔符为换行符，记录分隔符为空白行
#BEGIN {FS="\n";RS="";}NR==1 {print $0;}
#默认的输出字段分隔符(OFS)为一个空格
#BIGIN {FS=":";} {print "hello","there","Jim";}
#指定输出分隔符为","
#BEGIN {FS=":";OFS=",";} {print $1,$2,$3;}
#BEGIN {FS=":";x=0;} {while(x<2){print;x++;}}
#输出数组的方法,数组下标可以是字符串.
#BEGIN {FS=":"}{ myarray[1]="leslie"; myarray[2]="ssssssss"; myarray[3]=324; {if(NR==1)for(x in myarray) {print myarray[x]}}} 
#删除数组中元素方法.用下标判断数组中是否存在某个元素
#BEGIN {FS=":"}{myarray[1]="leslie";myarray[2]="ssssssss";myarray[3]=324;delete myarray[2]; {if(3 in myarray)for(x in myarray) {print myarray[x]}}} 
#length : length(),返回当前记录的长度,即$0      
#BEGIN {FS=":"}{mystring="leslie"; {print length(mystring);print index(mystring,"lie")}}
#match与index区别： match中使用的是正则表达式 
#BEGIN {FS=":"}{mystring="i am leslie"; {print match(mystring,/l*l/)" " RSTART " " RLENGTH}}
#sub与gsub区别：sub只替换第一个找到的值,gsub替换所有匹配的值.
#BEGIN {FS=":"} { mystring="TIAN JING BEI JING NAN JING";{print gsub(/JING/,"jing",mystring);print mystring; }}
#split返回分割的字符串的个数
BEGIN {FS=":"} {numelements=split("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",mymonths,","); print mymonths[2];print mymonths[numelements]}
