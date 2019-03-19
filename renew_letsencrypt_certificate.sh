#!/bin/bash

for i in `ps -ef | grep -v grep | grep apache2 | awk {'print $2'}`; do
 kill -9 $i
done

for DOMAIN in `ls /home/virtual`; do
 echo "Working with domain: ${DOMAIN}"
 for SUBDOMAIN in `cat /home/virtual/${DOMAIN}/_config/apache | grep 443 | awk {'print $2'} | cut -d ':' -f1 | grep -v "^${DOMAIN}" | cut -d "." -f1`; do
  SUBDOMAIN2=${SUBDOMAIN2}"-d ${SUBDOMAIN}.${DOMAIN} "
 done
  /root/letsencrypt/letsencrypt-auto certonly --standalone -d ${DOMAIN} ${SUBDOMAIN2}
#  /root/letsencrypt/letsencrypt-auto renew
  SUBDOMAIN2=""
done

/etc/init.d/apache2 stop
/etc/init.d/apache2 start
