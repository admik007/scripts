#!/bin/bash
LOGFILE='/var/log/mail.log /var/log/mail.log.1'
TODAY=`date "+%b %d" | sed 's/ 0/  /g'`
SPAM=`cat ${LOGFILE} | grep "Blocked SPAM" | grep "${TODAY}" | grep -v root | wc -l`
BANNED=`cat ${LOGFILE} | grep "Blocked BANNED" | grep "${TODAY}" | grep -v root | wc -l`
RECEIVED=`cat ${LOGFILE} | grep postfix/virtual | grep -v spam_vir | grep "${TODAY}" | grep -v root | wc -l`
SEND=`cat ${LOGFILE} | grep postfix/smtp | grep -v "relay=127.0.0.1" | grep status=sent | grep "${TODAY}" | grep -v root | wc -l`
echo "SPAM: "${SPAM}
echo "BANNED: "${BANNED}
echo "RECEIVED: "${RECEIVED}
echo "SEND: "${SEND}
echo "Today: "${TODAY}
