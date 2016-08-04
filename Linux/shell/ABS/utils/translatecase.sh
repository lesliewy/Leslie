#! /bin/bash
# translatecase.sh : change lowcase to uppercase or uppercase to lowcase as you like.
# ls -l |sh translate.sh uppercase

E_ARGS=23
if [ -z "$1" ]; then
   echo "Usage: `basename $0` {lowcase|uppercase}"
   exit "$E_ARGS"
fi

case "$1" in 
   lowcase)
      tr 'A-Z' 'a-z'
      ;;
   uppercase)
      tr 'a-z' 'A-Z'
      ;;
esac
exit 0
