#!/bin/bash
IP=`ifconfig | grep 10.241 | awk {'print $2'} | cut -d '.' -f4`
DEST="/tmp/temp_cpu_${IP}.txt"
/opt/vc/bin/vcgencmd measure_temp | cut -d '=' -f2 | cut -d "'" -f1 > ${DEST}
cat ${DEST}
echo 0
echo 0
echo 0
rm -f /tmp/temp_cpu_.txt
