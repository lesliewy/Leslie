#! /bin/bash

TMOUT=3    #  shell buildin 变量

echo "Quick,you have 3 seconds to answer:"
echo -n "what is your name:"
read name

if [ -n "$name" ];then
   echo "Your answer is $name"
else
   echo
   echo "sorry!"
fi
