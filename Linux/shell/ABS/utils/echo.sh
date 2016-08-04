#!/bin/bash

echo -n "input variable a:"
read -s -n 3  a                 # -s 不显示输入的字符.   最多输入3个字符.                          
echo "a is $a"

echo "arrow key"                # up is: \[A  down is: \[B  right is: \[C  left is: \[D
while true;do
   read -s -n 1 a
   [ "$a"==`echo -en "\e"` ] || continue
   read -s -n 1 a
   [ "$a"=="[" ] || continue
   read -s -n 1 a
   case "$a" in
      A) echo "up"
         ;;
      B) echo "down"
         ;;
      C) echo "right"
         ;;
      D) echo "left"
         ;;
   esac
done
#  每次只读入一个字符,用最后一个字母来判断.
