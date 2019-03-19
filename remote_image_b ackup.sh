#!/bin/bash
USER='user'
HOST='xxx.xxx.xxx.xxx'
DISKS=`dmesg | grep --color "mounted filesystem" | cut -d '(' -f2 | cut -d ')' -f1 | cut -c1,2,3`
DISK=`dmesg | grep --color "  ${DISKS}" | cut -d ':' -f1 | awk {'print $3'}`

dd if=/dev/${DISK} | gzip -1 - | pv | ssh ${USER}@${HOST} dd of=/data/share/backup/IMG_`hostname`.domain.com.gz
