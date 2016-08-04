#! /bin/bash

for x;do                              # means: for x in $@
   sed -f sedsrc $x > tmp.$x
done
