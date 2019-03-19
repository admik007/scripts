#!/bin/bash
/etc/initd.motion stop
rm -rf /var/lib/motion/*
mount 192.168.254.220:/var/www/html/`hostname` /var/lib/motion
/etc/init.d/motion start
