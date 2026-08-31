#!/bin/bash

#for i in `ls | grep webp | cut -d "." -f1`; do
# echo $i;
# NAME=`echo $i | cut -d "_" -f1`
#  dwebp $i.webp -o $i.png;
# convert $i.png -font Arial -pointsize 20 -fill red -annotate +10+25 "${i}" $i.jpg
#done



for i in `ls | grep ".jpg$" | cut -d "." -f1`; do
 convert $i.jpg -font Arial -pointsize 20 -fill red -annotate +10+25 "${i}" $i-new.jpg
done

NAME=`echo $i | cut -d "_" -f1`

convert -delay 15 *-new.jpg ${NAME}.mp4
chown www-data:www-data ${NAME}.mp4
chmod 644 ${NAME}.mp4
