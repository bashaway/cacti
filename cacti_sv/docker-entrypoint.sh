#!/bin/sh

export DB_CACTI_USER=cactiuser
export DB_CACTI_PASS=cactipwd
export DB_ROOT_PASS=rootpwd

until mysqladmin -uroot -p${DB_ROOT_PASS} -h cacti_db  ping ; do
  sleep 5
done

if [ "`mysql -uroot -p${DB_ROOT_PASS} cacti -h cacti_db -e 'show tables'`" = "" ]  ; then
  mysql -e "create database cacti character set utf8mb4 collate utf8mb4_unicode_ci" -uroot -p${DB_ROOT_PASS}  -h cacti_db
  mysql -e "create user '${DB_CACTI_USER}'@'%' identified by '${DB_CACTI_PASS}'"   -uroot -p${DB_ROOT_PASS}  -h cacti_db
  mysql -e "grant all privileges on cacti.* to '${DB_CACTI_USER}'@'%'"          -uroot -p${DB_ROOT_PASS}  -h cacti_db
  mysql -e "GRANT SELECT ON mysql.time_zone_name TO '${DB_CACTI_USER}'@'%'" -uroot -p${DB_ROOT_PASS}  -h cacti_db
  mysql -e "FLUSH PRIVILEGES" -uroot -p${DB_ROOT_PASS}  -h cacti_db
  mysql -uroot -p${DB_ROOT_PASS} cacti -h cacti_db < /usr/share/doc/cacti/cacti.sql 
  #chown -R apache.apache /var/lib/cacti/rra
  chmod 777 /var/lib/cacti/rra
  echo "SETUP DATABASE DONE"
fi

exec "$@"

