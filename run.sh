#!/bin/sh
#
# Snapshot the initial database
#
IP=`cat /tmp/ip.txt`
sed -i 's/$HOST/'"$IP"'/' /var/lib/postgresql/9.1/main/recovery.conf 
mkdir -p /var/lib/postgresql/9.1/main2
/usr/bin/pg_basebackup -h $IP -p 5432 -D /var/lib/postgresql/9.1/main2 -U postgres -v -P -x
cp -rf /var/lib/postgresql/9.1/main/recovery.conf /var/lib/postgresql/9.1/main2
cp -rf /var/lib/postgresql/9.1/main/server.* /var/lib/postgresql/9.1/main2
rm -Rf /var/lib/postgresql/9.1/main
mv /var/lib/postgresql/9.1/main2 /var/lib/postgresql/9.1/main
#
# Start the postgresql server
#
/usr/lib/postgresql/9.1/bin/postgres -D /var/lib/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf
