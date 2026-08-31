#!/bin/bash
IP=`ifconfig | grep 10.241 | awk {'print $2'} | cut -d '.' -f4`
DEST="/tmp/temp_hum_${IP}.txt"
NOW=`date +%s`
LOGFILE='/var/log/Adafruit_BME280.log'

python /opt/bme280.py | grep "Temp " | sed 's/\=  /\= /g' > ${DEST}

 TEMP=`cat ${DEST} | cut -d ',' -f 1 | awk {'print $3'}`
 HUM=`cat ${DEST} | cut -d ',' -f 2 | awk {'print $3'}`
 PRES=`cat ${DEST} | cut -d ',' -f 3 | awk {'print $3'}`
 echo ${TEMP}
 echo ${HUM}
 echo ${PRES}
 echo "0"
 echo "T: ${TEMP}C, H: ${HUM}%, P: ${PRES} hPa    " >> ${DEST}
 echo "Created: ${NOW}" >> ${DEST}
 echo "Date `date`" >> ${DEST}
 cp ${DEST} /var/www/html/
rm -f /tmp/temp_hum_.txt
