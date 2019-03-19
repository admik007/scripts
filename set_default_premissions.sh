#!/bin/bash
echo "Zadaj domenu: "
read DOMENA

USER=`cat /etc/passwd | grep ${DOMENA} | cut -d ":" -f3`
GROUP=`cat /etc/passwd | grep ${DOMENA} | cut -d ":" -f4`

chmod 755 /home/virtual/${DOMENA}
chown webhosting:webhosting /home/virtual/${DOMENA} -R

chown root:root /home/virtual/${DOMENA}/_config -R
chown ${USER}:${GROUP} /home/virtual/${DOMENA}/public -R
