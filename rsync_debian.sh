!/bin/bash

rsync --recursive --links --hard-links --times --verbose --compress --delete \
--exclude="*alpha*" \
--exclude="*arm*" \
--exclude="*hppa*" \
--exclude="*m68k*" \
--exclude="*amd64*" \
--exclude="*armel*" \
--exclude="*ia64*" \
--exclude="*mips*" \
--exclude="*powerpc*" \
--exclude="*s390*" \
--exclude="*sparc*" \
--exclude="*kfreebsd*" \
--exclude="*.iso*" \
ftp.antik.sk::debian/ /data2/share/debian
