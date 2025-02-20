#!/bin/bash
SPATH="/var/lib/mod_tile/default/"
DPATH="/var/www/html/"

for MAP in `ls -Sr ${SPATH} | grep "pbf$" | grep "australia-oceania-latest.osm.pbf"`; do
 echo "Step_01"
 service postgresql restart

 echo "Step_02"
 gosu postgres psql -c "DROP DATABASE world;"

 echo "Step_03"
 gosu postgres psql -c "CREATE DATABASE world;"

 echo "Step_04"
 gosu postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE world TO osm;"

 echo "Step_05"
 gosu postgres psql -c "CREATE EXTENSION hstore;" -d world

 echo "Step_06"
 gosu postgres psql -c "CREATE EXTENSION postgis;" -d world

 echo "Step_07"
 su osm -c "osm2pgsql --slim --database world --disable-parallel-indexing --cache 2048 --cache-strategy sparse --hstore --style /home/osm/openstreetmap-carto-2.29.1/openstreetmap-carto.style ${SPATH}${MAP}"

 echo "Step_08"
 MAPA=`echo $MAP | cut -d '.' -f1`

 echo "Step_09"
 mv ${SPATH}${MAP} ${SPATH}${MAP}.done

 echo "Step_10"
 gosu postgres pg_dump -d world > ${DPATH}${MAPA}.psql

done
