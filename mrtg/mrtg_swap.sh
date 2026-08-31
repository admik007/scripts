#!/bin/sh
USED=`free -m | grep Swap | awk {'print $3'}`
FREE=`free -m | grep Swap | awk {'print $4'}`
echo $USED
echo $FREE
echo 0
echo 0
