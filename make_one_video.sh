#!/bin/bash

NEWDIR="/data1/video/"
FILELIST="file_list.txt"
sleep 900

cd ${NEWDIR}


for FILES in `ls ${NEWDIR} | grep -i ".h264.mp4$" `; do
 > ${FILELIST}
 NODE=`echo ${FILES} | cut -d "_" -f1`
 DATE=`echo ${FILES} | cut -d "_" -f2`
 for FILE in `ls ${NEWDIR} | grep ".h264.mp4$" | grep "${NODE}" | grep "${DATE}"`; do
  echo "file '${FILE}'" >> ${FILELIST}
 done

 if [ -s ${FILELIST} ]; then
  if [ ! -f ${NODE}_${DATE}.mp4 ]; then
   echo "ffmpeg -f concat -i ${FILELIST} -c copy ${NODE}_${DATE}.mp4"
   ffmpeg -f concat -i ${FILELIST} -c copy ${NODE}_${DATE}.mp4

   for FILE  in `cat ${FILELIST} | awk {'print $2'} | tr -d "'"`; do
    rm -f ${FILE}
   done
  fi
 fi

done
