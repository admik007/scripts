#!/bin/bash
MOTION=`ps -ef | grep motion | grep -v grep | grep -v check | wc -l`
if [ ${MOTION} -lt "1" ]; then
 /etc/init.d/motion restart
 echo "Restart"
else
 echo "Nothing"
fi
