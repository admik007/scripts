#!/bin/bash
FILEPATH="/home/virtual/ztk-comp.eu/public/www/balea_lake"
URL="https://cdn.skylinewebcams.com/live3075.webp"
NAME=`date '+%F_%T' | sed "s/:/-/g" | sed "s/-//g"`
DIR=`echo ${NAME} | cut -d "_" -f1`
FILELIST="filelist.txt"
BALEA_OUT="balea_lake.mp4"

cd ${FILEPATH}


if [ ! -d ${FILEPATH}/${DIR} ];then
 mkdir ${FILEPATH}/${DIR}
fi

wget -q ${URL} -O ${FILEPATH}/${DIR}/${NAME}.webp

dwebp ${FILEPATH}/${DIR}/${NAME}.webp -o ${FILEPATH}/${DIR}/${NAME}.png
convert ${FILEPATH}/${DIR}/${NAME}.png -font Arial -pointsize 20 -fill red -annotate +10+25 "${NAME}" ${FILEPATH}/${DIR}/${NAME}.jpg

convert -delay 10 ${FILEPATH}/${DIR}/*.jpg ${FILEPATH}/${DIR}/${DIR}.mp4
chown www-data:www-data ${FILEPATH}/${DIR}/${DIR}.mp4
chmod 644 ${FILEPATH}/${DIR}/${DIR}.mp4


# CREATE FULL VIDEO
if [ -f ${FILELIST} ]; then
 rm ${FILELIST}
fi

if [ -f ${BALEA_OUT} ]; then
 rm ${BALEA_OUT}
fi


for file in `ls | grep -E "^[0-9]{8}$"`; do
 echo "file ${file}/${file}.mp4" >> ${FILELIST}
done
ffmpeg -f concat -i ${FILELIST} -c copy ${BALEA_OUT}
chown www-data:www-data ${BALEA_OUT}
chmod 644 ${BALEA_OUT}


echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
 <title> Balea Lake </title>
 <link rel=\"SHORTCUT ICON\" href=\"icon.ico\" type=\"image/x-icon\">
 <meta http-equiv=\"Expires\" CONTENT=\"Sun, 12 May 2003 00:36:05 GMT\">
 <meta http-equiv=\"Pragma\" CONTENT=\"no-cache\">
 <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
 <meta http-equiv=\"Cache-control\" content=\"no-cache\">
 <meta http-equiv=\"Content-Language\" content=\"sk\">
 <meta name=\"google-site-verification\" content=\"GHY_X_yeijpdBowWr_AKSMWAT8WQ-ILU-Z441AsYG9A\">
 <meta name=\"GOOGLEBOT\" CONTENT=\"noodp\">
 <meta name=\"pagerank\" content=\"10\">
 <meta name=\"msnbot\" content=\"robots-terms\">
 <meta name=\"msvalidate.01\" content=\"B786069E75B8F08919826E2B980B971A\">
 <meta name=\"revisit-after\" content=\"2 days\">
 <meta name=\"robots\" CONTENT=\"index, follow\">
 <meta name=\"alexa\" content=\"100\">
 <meta name=\"distribution\" content=\"Global\">
 <meta name=\"keywords\" lang=\"sk\" content=\"Balea Lake\">
 <meta name=\"description\" content=\"Balea Lake\">
 <meta name=\"Author\" content=\"ZTK-Comp WEBHOSTING\">
 <meta name=\"copyright\" content=\"(c) 2025 ZTK-Comp\">
</head>
<body bgcolor=\"black\">

<video width=\"320\" height=\"240\" controls>
 <source src=\"balea_lake.mp4\" type=\"video/mp4\">
</video><hr color=\"black\">

" > ${FILEPATH}/index.php

for PHPFILE in `ls -r ${FILEPATH}/ | egrep  "^20"`; do
MP4FILE=`echo ${PHPFILE} | cut -d "." -f1`

echo "
<video width=\"320\" height=\"240\" controls>
 <source src=\"${MP4FILE}/${MP4FILE}.mp4\" type=\"video/mp4\">
</video>
" >> ${FILEPATH}/index.php
done

echo "</body>
</html>" >> ${FILEPATH}/index.php
