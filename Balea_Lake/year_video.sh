#!/bin/bash

FILELIST="filelist.txt"
BALEA_OUT="balea_lake.mp4"
if [ -f ${FILELIST} ]; then
 rm ${FILELIST}
fi


for file in `ls year_video/`; do
 echo "file year_video/${file}" >> ${FILELIST}
done
ffmpeg -f concat -i ${FILELIST} -c copy ${BALEA_OUT}
#chown www-data:www-data ${BALEA_OUT}
#chmod 644 ${BALEA_OUT}
