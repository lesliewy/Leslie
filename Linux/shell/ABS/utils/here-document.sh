#! /bin/bash

NAME=LESLIE
RESPONDENT="The author of this script"

cat <<- Endofmessage

   name:$NAME
   $RESPONDENT

Endofmessage

#cat <<- \specialend                            #  \ 和 specialend 之间最好不要加空格. 
#cat <<- "specialend"                           # 这3种效果是一样的: 都将使here document 中不能使用 命令 算术计算 转义
cat <<- 'specialend'                          
 Directory listing would follow if 
limit string were not quoted.
`ls -l`
   # comment not allowed here
 Arithmetic expansion would take place if
limit string were not quoted.
$(( 3*3))

a single backslash would echo if
limit string were not quoted.
\\

specialend

#   here document 中不能加注释.
#   <<-   :  - 必须紧跟 <<, 去掉here document 中的前导tabs.
