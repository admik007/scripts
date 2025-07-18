#!/bin/bash
SPATH="/source/"
DPATH="/source/"


#for MAP in `ls -Sr ${SPATH} | grep "pbf$"`; do

for MAP in `ssh home.domain.com "ls -Sr /data2/docker/source/ | grep pbf | head -n1"`; do
 echo "Step_01"
 scp home.domain.com:/data2/docker/source/${MAP} ${SPATH}

 echo "Step_02"
 echo "Work with ${MAP}"

 echo "Step_03 - psql restart"
 service postgresql restart
 sleep 10

 echo "Step_04 - drop db"
 gosu postgres psql -c "DROP DATABASE world;"

 echo "Step_05 - create db"
 gosu postgres psql -c "CREATE DATABASE world;"

 echo "Step_06 - grant privileges"
 gosu postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE world TO osm;"

 echo "Step_07 - create hstore"
 gosu postgres psql -c "CREATE EXTENSION hstore;" -d world

 echo "Step_08 - created postgis"
 gosu postgres psql -c "CREATE EXTENSION postgis;" -d world

 echo "Step_09 - osm2pgsql"
 su osm -c "osm2pgsql --slim --database world --disable-parallel-indexing --cache 2048 --cache-strategy sparse --hstore --style /home/osm/openstreetmap-carto-2.29.1/openstreetmap-carto.style ${SPATH}${MAP}"

 echo "Step_10 - get name"
 MAPA=`echo $MAP | cut -d '.' -f1`

 echo "Step_11 - move to done"
 mv ${SPATH}${MAP} ${SPATH}${MAP}.done

 echo "Step_12 - make dump"
 gosu postgres pg_dump -d world > ${DPATH}${MAPA}.psql

 echo "Step_13 - check dump completed"
 COMPLETED=`tail ${DPATH}${MAPA}.psql | grep "PostgreSQL database dump complete" | wc -l`
 if [ "${COMPLETED}" == "1" ]; then

  echo "Step_14 - upload psql"
  scp ${DPATH}${MAPA}.psql home.domain.com:/data2/docker/source/psql/

  echo "Step_15 - remove psql"
  rm -f ${DPATH}${MAPA}.psql

  echo "Step_16 - upload done"
  scp ${SPATH}${MAP}.done home.domain.com:/data2/docker/source/done/

  echo "Step_17 - remove - done"
  rm -f ${SPATH}${MAP}.done

  echo "Step_18 - move done"
  ssh home.domain.com "rm /data2/docker/source/${MAP}"

 else
  exit 0
 fi

done
