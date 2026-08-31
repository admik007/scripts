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

root@backup (rw) /data1/video/Balea_Lake # cat year_video
cat: year_video: Is a directory
root@backup (rw) /data1/video/Balea_Lake # cat mass_convert.sh
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
root@backup (rw) /data1/video/Balea_Lake # cat make_full_video.sh
#!/bin/bash
FILELIST="filelist.txt"
BALEA_OUT="balea_lake.mp4"

for file in `find . -name "*.mp4" | sort | sed 's/^.\/2/2/g'`; do
 echo "file ${file}" >> ${FILELIST}
done
ffmpeg -f concat -i ${FILELIST} -c copy ${BALEA_OUT}
chown www-data:www-data ${BALEA_OUT}
chmod 644 ${BALEA_OUT}
