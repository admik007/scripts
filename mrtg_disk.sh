#!/bin/sh
DATA=`df -m / | tail -1`
USED=`echo $DATA | cut -f3 -d" "`
FREE=`echo $DATA | cut -f4 -d" "`
echo $USED
echo $FREE
echo 0
echo 0
