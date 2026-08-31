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
repo.zabbix.com::zabbix /data1/linux/zabbix/
