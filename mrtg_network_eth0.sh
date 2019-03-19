#!/bin/sh
IF=`ip r | grep default | awk {'print $5'}`
/usr/bin/vnstat -i ${IF} -u

ETH0RX=`vnstat -i eth0 | grep today | awk {'print $2'}`
ETH0RXS=`vnstat -i eth0 | grep today | awk {'print $3'}`
if [ "${ETH0RXS}" = "MiB" ]; then
 ETH0RX=${ETH0RX};
fi
if [ "${ETH0RXS}" = "GiB" ]; then
  ETH0RX=`echo ${ETH0RX}*1024 | bc`;
fi

ETH0TX=`vnstat -i eth0 | grep today | awk {'print $5'}`
ETH0TXS=`vnstat -i eth0 | grep today | awk {'print $6'}`
if [ ${ETH0TXS} = "MiB" ]; then
 ETH0TX=${ETH0TX};
fi
if [ "${ETH0TXS}" = "GiB" ]; then
  ETH0TX=`echo ${ETH0TX}*1024 | bc`;
fi

echo $ETH0RX
echo $ETH0TX
echo 0
echo 0
