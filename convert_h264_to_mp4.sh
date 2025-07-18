#!/bin/bash
DIR="/motion/"
NEWDIR="/data1/video/"


for NODE in `ls ${DIR} | grep "node" `; do

 FILE=`ls ${DIR}${NODE}`
 EXCLUDE_FILE=`ls ${DIR}${NODE} | tail -n1`

 for MFILE in `ls ${DIR}${NODE} | grep -v "${EXCLUDE_FILE}"`; do
  echo "ffmpeg -framerate 24 -i ${DIR}${NODE}/${MFILE} -c copy ${NEWDIR}${MFILE}.mp4"
  ffmpeg -framerate 24 -i ${DIR}${NODE}/${MFILE} -c copy ${NEWDIR}${MFILE}.mp4
  rm -rf ${DIR}${NODE}/${MFILE}
 done
done
