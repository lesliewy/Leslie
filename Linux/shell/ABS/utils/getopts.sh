#! /bin/bash

NO_ARGS=0
E_OPTERROR=85
if [ $# -eq "$NO_ARGS" ];then
   echo "Usage: `basename $0`: options (-mnopqrs)"
   exit $E_OPTERROR
fi

while getopts ":mnopq:rs" option;do                         # 与普通的while condition不同.
   case "$option" in 
      m) echo "Scenario #1: option -m-  [OPTIND=$OPTIND]"
         ;;
      n|o) echo "Scenario #1: option -$option-  [OPTIND=$OPTIND]"
         ;;
      p) echo "Scenario #1: option -p-  [OPTIND=$OPTIND]"
         ;;
      q) echo "Scenario #1: option -q- with argument \"$OPTARG\" [OPTIND=$OPTIND]"           # 必须要有参数,如果没有参数，就自动退出了.
         ;;
      r|s) echo "Scenario #1: option -$option-  [OPTIND=$OPTIND]"
         ;;
      *) echo "unimplemented argument."
         ;;
   esac
done
shift $(($OPTIND-1))

exit $?

#  要使用$option, 在getopts 后面必须跟上所有的参数,否则参数取不到。  如果参数不在getopts后面列出的，则$option是"?".
