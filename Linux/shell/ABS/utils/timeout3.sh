#! /bin/bash

# 利用 stty -icanon time 来指定当前终端的超时时间.   单位是1/10 s.
INTERVAL=5

timeout_read(){
   timeout=$1
   varname=$2
   old_tty_settings=`stty -g`
   stty -icanon min 3 time ${timeout}0
   eval read $varname
   stty "$old_tty_settings"
}


echo
echo -n "What's your name? Quick!"
timeout_read $INTERVAL your_name
echo
if [ ! -z "$your_name" ]; then
   echo "Your name is $your_name"
else
   echo "Timeout"
fi
echo

exit 0
