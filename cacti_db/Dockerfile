FROM mariadb/server:latest
COPY cacti.cnf /etc/mysql/conf.d
COPY tz.sql /docker-entrypoint-initdb.d
COPY tz.sh /docker-entrypoint-initdb.d
