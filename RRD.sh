#!/bin/bash
#
# rrdtool tune /var/www/mrtg/fr24-node03.ztk-comp.sk-loadavg.rrd -r ds1:15min
# rrdtool tune /var/www/mrtg/fr24-node06.ztk-comp.sk-temp_hum.rrd --minimum Temp:-100`
RUNNING=`ps -ef | grep -ie mrtg -e rrd | grep -v grep | grep -v rrdcache | grep -v RRD.sh | wc -l`
if [ ${RUNNING} -gt "9" ]; then
 for i in `ps -ef | grep -ie mrtg -e rrd | grep -v grep | grep -v rrdcache | grep -v RRD.sh | awk {'print $2'}`; do
  kill -9 $i;
 done
fi


MRTG_PATH='/var/www/mrtg/'
NOW=`date '+%d-%m-%y %H:%M:%S'`
echo ${NOW}
for I in `cat /etc/mrtg.cfg | grep Title | cut -d ':' -f1 | cut -d '[' -f2 | cut -d ']' -f1`; do
 for PERIOD in `echo "day week month year"`; do
 DS0=`rrdtool info ${MRTG_PATH}${I}.rrd | grep ds | cut -d '.' -f1 | uniq | head -1 | cut -d '[' -f2 | cut -d ']' -f1`
 DS1=`rrdtool info ${MRTG_PATH}${I}.rrd | grep ds | cut -d '.' -f1 | uniq | tail -1 | cut -d '[' -f2 | cut -d ']' -f1`

echo "Working with ${I} in ${PERIOD} - DS0= ${DS0}, DS1= ${DS1}"
rrdtool graph ${MRTG_PATH}${I}-${PERIOD}.png -a PNG \
--title="${I} ${PERIOD}" \
--start "-1${PERIOD}" \
DEF:${DS0}=${MRTG_PATH}${I}.rrd:${DS0}:AVERAGE \
DEF:${DS1}=${MRTG_PATH}${I}.rrd:${DS1}:AVERAGE \
LINE1:${DS0}#CC9966 \
LINE2:${DS1}#339966 \
AREA:${DS1}#339966:"Current ${DS1}" \
AREA:${DS0}#CC9966:"Current ${DS0}" \
COMMENT:`date +%d.%m.%Y_%H-%M-%S` \
COMMENT:' \n' \
"GPRINT:${DS0}:LAST:Current ${DS0}\: %3.0lf" \
"GPRINT:${DS0}:AVERAGE:Average ${DS0}\: %3.0lf " \
"GPRINT:${DS0}:MAX:MAX ${DS0}\: %3.0lf \n" \
"GPRINT:${DS1}:LAST:Current ${DS1}\: %3.0lf " \
"GPRINT:${DS1}:AVERAGE:Average ${DS1}\: %3.0lf " \
"GPRINT:${DS1}:MAX:MAX ${DS1}\: %3.0lf \n"
 done
done
