#! /bin/bash

ROOT_UID=0
E_WRONG_USER=85

BLOCKSIZE=1024
MINBLOCKS=40
SUCCESS=0

if [ "$UID" -ne "$ROOT_UID" ];then
   echo "YOU MUST BE ROOT."
   exit $E_WRONG_USER
fi

[ "$#" -ne 2 ] && (echo "`basename $0` block-num file-name";echo "Exit.") && exit $E_WRONG_ARGS
blocks=${1:-$MINBLOCKS}
FILE=$2

if [ $blocks -lt $MINBLOCKS ];then
   blocks=$MINBLOCKS
fi

echo "Creating swap file of size $blocks blocks (KB)"
dd if=/dev/zero of=$FILE bs=$BLOCKSIZE count=$blocks 
