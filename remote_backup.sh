#!/bin/bash

RSYNC='/usr/bin/rsync'
LOCDATA='/bin /boot /etc /data /home /lib /opt /root /sbin /selinux /var /usr'
EXCLUDE='--exclude=/backup --exclude=/var/lib/motion'
SHARE='/backup'

HOSTNAME=`cat /etc/hostname`

LHOST='192.168.xxx.xxx'
VHOST='backup.domain.com'
USER='USER_HERE'
DBPASS='PASSWORD_HERE'

ping -c 4 -W 2 ${LHOST} > /dev/null
LIVE=`echo $?`
if [ "${LIVE}" -eq "0" ]; then
 HOST=${LHOST}
 echo "LHOST alive"
else
 ping -c 4 -W 2 ${VHOST} > /dev/null
 LIVE=`echo $?`
 if [ "${LIVE}" -eq "0" ]; then
  HOST=${VHOST}
  echo "VHOST alive"
 else
  echo "Koncim"
  exit 0
 fi
fi

echo "${HOST} - ${HOSTNAME} - ${SHARE}"

dpkg-query --list > /root/list_all_packages.txt

if [ -e /proc/cpuinfo ]; then
 cat /proc/cpuinfo | grep "model name" | uniq | cut -d ':' -f2 > /root/RPI.txt
 cat /proc/cpuinfo | egrep "Serial|Model" >> /root/RPI.txt
fi

if [ -e /proc/device-tree/model ]; then
 cat /proc/device-tree/model >> /root/RPI.txt
fi

echo "`date +%F`" > /root/_last_backup



for i in `mysqlshow -uroot -p${DBPASS} | grep "|" | egrep -v "Database|information_schema|performance_schema" | tr -d "|" | tr -d " "`; do
 echo "Backup of ${i}";
 mysqldump -uroot -p${DBPASS} ${i} --ignore-table=${i}.gps_tracking_archive_XXXXXXX  > /root/mysql_${i}.sql;
done


echo "${RSYNC} -e \"ssh -o StrictHostKeyChecking=no\" --mkpath --archive --compress --human-readable --verbose --times --acls --hard-links --links --recursive --stats --perms --group --owner --delete --delete-excluded --ignore-missing-args ${EXCLUDE} ${LOCDATA} ${USER}@${HOST}:${SHARE}/SRV_${HOSTNAME}.ztk-comp.sk/"

sleep 10

${RSYNC} -e "ssh -o StrictHostKeyChecking=no" --mkpath --archive --compress --human-readable --verbose --times --acls --hard-links --links --recursive --stats --perms --group --owner --delete-excluded --ignore-missing-args ${EXCLUDE} ${LOCDATA} ${USER}@${HOST}:${SHARE}/SRV_${HOSTNAME}.ztk-comp.sk/

rm -f /root/mysql_*.sql
