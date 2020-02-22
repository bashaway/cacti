#!/bin/sh

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -prootpwd mysql

