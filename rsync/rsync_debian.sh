#!/bin/bash
echo `date +%F`
rsync \
--archive \
--verbose \
--progress \
--append \
--times \
--links \
--hard-links \
--partial \
--block-size=8192 \
--no-owner \
--no-group \
--no-perms \
--delete \
--exclude="*favicon.ico*" \
--exclude="*snapshotindex.txt*" \
--exclude="*raspbian.public.key*" \
--exclude="*multiarch*" \
ftp.gwdg.de::pub/linux/debian/debian/ /data1/linux/debian/
