#!/bin/sh
CPUS=`cat /proc/cpuinfo | grep bogomips | wc -l`
FIRST=`cat /proc/loadavg | awk {'print $1'}`
SECOND=`cat /proc/loadavg | awk {'print $2'}`
echo $FIRST*100/$CPUS | bc | cut -d "." -f1
echo $SECOND*100/$CPUS | bc | cut -d "." -f1
echo 0
echo 0
