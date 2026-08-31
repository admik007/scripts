#!/bin/bash
 DESTFILE_mrtg="vpn.mrtg"
 DESTFILE_html="vpn.html"

 echo " " > $DESTFILE_mrtg
 echo " " > $DESTFILE_html

for i in `ls /etc/openvpn/ccd/ | grep "domain.com"`; do
 DESTFILE="vpn_${i}.sh"
 echo "#!/bin/bash" > $DESTFILE
 echo "echo \`ping -c 1 -W 1 `cat /etc/openvpn/ccd/${i} | grep ifconfig-push | awk {'print $2'}` > /dev/null\` \$\?\"00\""
 echo "echo 0" >> $DESTFILE
 echo "echo 0" >> $DESTFILE
 echo "echo 0" >> $DESTFILE

 echo " " >> $DESTFILE_mrtg
 echo "Title[${i}]: VPN - ${i}" >> $DESTFILE_mrtg
 echo "PageTop[${i}]: <H1>${i}</H1>" >> $DESTFILE_mrtg
 echo "Options[${i}]: nobanner,gauge,noinfo,nopercent" >> $DESTFILE_mrtg
 echo "Target[${i}]: \`/opt/mrtg/$DESTFILE\`" >> $DESTFILE_mrtg
 echo "MaxBytes[${i}]: 100" >> $DESTFILE_mrtg
 echo "AbsMax[${i}]: 100" >> $DESTFILE_mrtg
 echo "YLegend[${i}]: ${i}" >> $DESTFILE_mrtg
 echo "Unscaled[${i}]: ymwd" >> $DESTFILE_mrtg
 echo "LegendI[${i}]: ${i}" >> $DESTFILE_mrtg
 echo "LegendO[${i}]: ${i}" >> $DESTFILE_mrtg
 echo "Suppress[${i}]: y" >> $DESTFILE_mrtg

 echo " " >> $DESTFILE_html
 echo " <tr>" >> $DESTFILE_html
 echo "  <td>" >> $DESTFILE_html
 echo "   ${i}" >> $DESTFILE_html
 echo "  </td>" >> $DESTFILE_html
 echo " </tr>" >> $DESTFILE_html
 echo " <tr>" >> $DESTFILE_html
 echo "  <td>" >> $DESTFILE_html
 echo "   <a href=\"${i}.html\"><img src=\"${i}-day.png\"></a>" >> $DESTFILE_html
 echo "  </td>" >> $DESTFILE_html
 echo " </tr>" >> $DESTFILE_html

 chmod a+x $DESTFILE
done

cat $DESTFILE_mrtg
cat $DESTFILE_html

rm $DESTFILE_mrtg
rm $DESTFILE_html
