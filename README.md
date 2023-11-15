Unofficial cacti docker-compose.yml

# CACTI Install Manual

https://docs.cacti.net/Install-Under-CentOS_LAMP.md

# Parameters

Container

|server|app|address|listen|
|:-:|:-:|:-:|:-:|
|cacti_db|MariaDB|-(dynamic)|3306/tcp|
|cacti_sv|cacti<BR>cacti-spine|-(dynamic)|-|
|cacti_web|apache|-(dynamic)|80/tcp<BR>443/tcp|


# build servers

## git clone

```
git clone https://github.com/bashaway/cacti
```

## Build and Start Containers
```shell
cd cacti
docker compose up --build -d
```

# Setup

## Access Cacti Server

http://[hostname or address]/cacti

## login web console
Username : admin
Password : admin


## spine configuration
Console --> Configuration --> Settings --> Poller<BR> 
PollerType : cmd.php --> spine


check spine process

```shell
# spine -V=3 -R
SPINE: Using spine config file [/etc/spine.conf]
SPINE: Version 1.1.38 starting
2019/01/09 23:07:24 - SPINE: Poller[1] NOTE: Spine will support multithread device polling.
2019/01/09 23:07:24 - SPINE: Poller[1] DEBUG: Initial Value of Active Threads is 0
2019/01/09 23:07:24 - SPINE: Poller[1] SPINE: Active Threads is 1, Pending is 1
2019/01/09 23:07:24 - SPINE: Poller[1] Device[1] TH[1] NOTE: There are '5' Polling Items for this Device
2019/01/09 23:07:24 - SPINE: Poller[1] Device[1] TH[1] DS[1] SCRIPT: perl /usr/share/cacti/scripts/unix_processes.pl, output: 184
2019/01/09 23:07:24 - SPINE: Poller[1] Device[1] TH[1] DS[2] SCRIPT: perl /usr/share/cacti/scripts/loadavg_multi.pl, output: 1min:0.00 5min:0.02 10min:0.09
2019/01/09 23:07:24 - SPINE: Poller[1] Device[1] TH[1] DS[3] SCRIPT: perl /usr/share/cacti/scripts/unix_users.pl '', output: 1
2019/01/09 23:07:24 - SPINE: Poller[1] Device[1] TH[1] DS[4] SCRIPT: perl /usr/share/cacti/scripts/linux_memory.pl 'MemFree:', output: 793572
2019/01/09 23:07:24 - SPINE: Poller[1] Device[1] TH[1] DS[5] SCRIPT: perl /usr/share/cacti/scripts/linux_memory.pl 'SwapFree:', output: 2097148
2019/01/09 23:07:24 - SPINE: Poller[1] Device[1] TH[1] Total Time: 0.058 Seconds
2019/01/09 23:07:24 - SPINE: Poller[1] POLLR: Active Threads is 0, Pending is 0
2019/01/09 23:07:25 - SPINE: Poller[1] SPINE: The Final Value of Threads is 0
2019/01/09 23:07:25 - SPINE: Poller[1] Time: 1.0277 s, Threads: 1, Devices: 1
#
```

# Database backup and restore

## RRA file
RRA directory mount on host machine.

`cacti_sv/Dockerfile`
```Dockerfile:cacti_sv/Dockerfile
----8<---(snip)---8<---
 cacti_sv:
    volumes:
      - ./rra:/var/lib/cacti/rra
---->8---(snip)--->8---
```

## Cacti database
Cacti database automates daily backups with CRON.

`crontab`
```crontab
2 5 * * *       root    cp -f /usr/share/cacti/rra/CACTI_DB_BACKUP.sql /usr/share/cacti/rra/CACTI_DB_BACKUP.sql.old
5 5 * * *       root    mysqldump -u cactiuser -pcactipwd cacti -h cacti_db > /usr/share/cacti/rra/CACTI_DB_BACKUP.sql 2>&1
```

## Restore cacti server

`cacti_sv/docker-entrypoint.sh`
```shell:cacti_sv/docker-entrypoint.sh
if [ "`mysql -ucactiuser -pcactipwd  -h cacti_db cacti  -e 'show tables'`" = "" ]  ; then

  if [ -e /usr/share/cacti/rra/CACTI_DB_BACKUP.sql ]  ; then
    mysql -ucactiuser -pcactipwd cacti -h cacti_db < /usr/share/cacti/rra/CACTI_DB_BACKUP.sql
  else
    mysql -ucactiuser -pcactipwd cacti -h cacti_db < /usr/share/doc/cacti/cacti.sql
  fi

  chown -R apache.apache /var/lib/cacti/rra
fi
```

# remove servers

## Stop and remove containers, networks, images, and volumes
```
docker compose down --rmi all --volumes
```

## docker command : Clean Up All Container and Images
```
docker ps -aq | xargs docker rm -f ; \
docker images -aq | xargs docker rmi
```

