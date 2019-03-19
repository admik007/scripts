#!/bin/bash
RSYNC='/usr/bin/rsync'
DATA_LOCAL='/data /data2 /data3'
#DISK=`dmesg | grep removable | tail -n 1| cut -d '[' -f3 | cut -d ']' -f1`
DISK=`ls /dev/ | grep sd | grep -v sda | grep -v sdb | head -1`
DATA_REMOTE='/USB'
TCPASS='p@55woRD'
EXCLUDE='--exclude *.mp3 --exclude *.avi --exclude *.wma --exclude *.mp4 --exclude *.iso --exclude *.MOV --exclude *.exe --exclude *.pst --exclude *.zip --exclude *.rar --exclude *.7z'

truecrypt -d

echo "Get mount list"
NR=`truecrypt --list | grep $DATA_REMOTE | wc -l`

if [ $NR -eq '0' ]; then
 echo "Mount truecrypt"
 truecrypt --text --non-interactive -p $TCPASS  /dev/${DISK}1 $DATA_REMOTE
 echo "Done"
fi

NR=`truecrypt --list | grep $DATA_REMOTE | wc -l`
if [ $NR -eq '1' ]; then
 echo "Start sync"
 $RSYNC -avzrtplh --stats --delete $EXCLUDE $DATA_LOCAL $DATA_REMOTE
 echo \"`date`\" > $DATA_REMOTE/_last_backup.txt
 echo \"`date`\" > /root/_USB_last_backup.txt
 echo "Sync done"
fi

truecrypt -d
echo "Umount "
