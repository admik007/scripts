#!/bin/bash
domains=`cat /etc/passwd | grep "65..0:65..0" | cut -d ':' -f1 | grep -v webhosting | grep -v ztk`
for i in $domains; do
 ENTRY=`repquota -vgsi -a | grep $i `
 OVERLIMIT=`echo $ENTRY | awk {'print $2'}`
 USERS=''
 if [ $OVERLIMIT == '+-' ]; then
  DOMAIN=`echo $ENTRY | awk {'print $1'}`
  MAXLIMIT=`echo $ENTRY | awk {'print $4'}`
  CURRENT=`echo $ENTRY | awk {'print $3'}`
  EMAIL=`cat /etc/passwd | grep $DOMAIN | cut -d ':' -f5`
  DOMENA=`cat /etc/passwd| grep $DOMAIN | cut -d ':' -f6 | cut -d '/' -f4`
  for i in `cat /etc/passwd | grep \`cat /etc/passwd | grep $DOMAIN |  cut -d ':' -f3\` | cut -d ':' -f1`; do
   USERS=`repquota -vusi -a | grep $i | awk {'print $1,$3'}`"
"$USERS
  done
  echo "
Prokroceny limit pre domenu $DOMENA.
Max limit je $MAXLIMIT / domena.
Aktualna velkost $CURRENT (nezahrna prijate/odoslane e-maily)

Zoznam uzivatelov pre domenu $DOMENA, a ich obsadenie miesta
$USERS

Zmazte niektore data.
Tento e-mail je generovany automaticky, kazdych 24 hodin.
" | mutt -s "Prekrocena kvota pre domenu $DOMENA" -F /home/data/bin/MUTTRC.ZTK $EMAIL
  echo E-mail - $EMAIL
  echo Domain - $DOMAIN
  echo Current - $CURRENT
  echo Max - $MAXLIMIT
 fi
done
