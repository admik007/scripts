#!/bin/bash
ping -c 1 -W 1 xxx.xxx.xxx.xxx > /dev/null
AVAILABLE=`echo $?`
if [ "${AVAILABLE}" -eq "0" ]; then
 echo 0
else
 echo 100
fi
echo 0
echo 0
echo 0
