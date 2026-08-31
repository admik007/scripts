#!/bin/sh
CPUTEMP=`cat /var/log/syslog | grep ddrfreq | tail -1 | cut -d '=' -f2 | cut -d ' ' -f1`
echo $CPUTEMP
echo 0
echo 0
echo 0
