#!/bin/sh

until mysqladmin -ucactiuser -pcactipwd -h cacti_db  ping ; do
  sleep 1
done

if [ "`mysql -ucactiuser -pcactipwd  -h cacti_db cacti  -e 'show tables'`" = "" ]  ; then
  mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -prootpwd mysql -h cacti_db
  cat /usr/share/doc/cacti/cacti.sql |  mysql -ucactiuser -pcactipwd cacti -h cacti_db
fi

exec "$@"

