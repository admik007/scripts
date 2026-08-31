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
--max-size=3M \
--no-owner \
--no-group \
--no-perms \
--delete \
--exclude="*favicon.ico*" \
--exclude="*snapshotindex.txt*" \
--exclude="*raspbian.public.key*" \
--exclude="*multiarch*" \
rsync.archive.debian.org::debian-archive /data1/linux/debian-archive/
