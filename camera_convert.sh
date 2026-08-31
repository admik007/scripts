#!/bin/bash
FILEPATH="/data1/camera"
NAME=`date '+%F_%T' | sed "s/:/-/g" | sed "s/-//g"`
HR=`date '+%H'`
DIR=`echo ${NAME} | cut -d "_" -f1`
FILELIST="filelist.txt"
BALEA_OUT="balea_lake.mp4"

sleep 90

if [ ! -d ${FILEPATH}/${DIR} ];then
 mkdir ${FILEPATH}/${DIR}
fi

mv ${FILEPATH}/${DIR}*.jpg ${FILEPATH}/${DIR}/

cat ${FILEPATH}/${DIR}/${DIR}_${HR}*.jpg | ffmpeg -f image2pipe -i - ${FILEPATH}/${DIR}/${DIR}_${HR}.mkv && rm -f ${FILEPATH}/${DIR}/${DIR}_${HR}*.jpg
ffmpeg -i ${FILEPATH}/${DIR}/${DIR}_${HR}.mkv -codec copy ${FILEPATH}/${DIR}/${DIR}_${HR}.mp4 && rm -f ${FILEPATH}/${DIR}/${DIR}_${HR}.mkv


cd ${FILEPATH}/${DIR}/

if [ "${HR}" == "23" ]; then

 for file in `ls | grep -E "^[0-9]" | grep "mp4"`; do
  echo "file ${file}" >> ${FILEPATH}/${DIR}/${FILELIST};
 done
 ffmpeg -f concat -i ${FILEPATH}/${DIR}/${FILELIST} -c copy ${FILEPATH}/${DIR}/${DIR}.mp4
fi


#Cleaning
if [ -f ${FILEPATH}/${DIR}/${DIR}.mp4 ]; then
 if [ -f ${FILEPATH}/${DIR}/${FILELIST} ]; then
  rm ${FILEPATH}/${DIR}/${FILELIST}
 fi

 for file in `ls | grep -E "^[0-9]" | grep "mp4" | grep "_"`; do
  if [ -f ${file} ]; then
   rm ${file}
  fi
 done
fi
