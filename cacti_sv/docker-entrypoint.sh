#!/bin/sh

until mysqladmin -ucactiuser -pcactipwd -h cacti_db  ping ; do
  sleep 1
done

if [ "`mysql -ucactiuser -pcactipwd  -h cacti_db cacti  -e 'show tables'`" = "" ]  ; then

  if [ -e /usr/share/cacti/rra/CACTI_DB_BACKUP.sql ]  ; then
    mysql -ucactiuser -pcactipwd cacti -h cacti_db < /usr/share/cacti/rra/CACTI_DB_BACKUP.sql
  else
    mysql -ucactiuser -pcactipwd cacti -h cacti_db < /usr/share/doc/cacti/cacti.sql 
  fi

  chown -R apache.apache /var/lib/cacti/rra
fi

exec "$@"

