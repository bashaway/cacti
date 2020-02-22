Unofficial cacti docker-compose.yml

# Parameters

Network

|key|value|
|:-:|:-:|
|name|cacti_cacti_nw|
|subnet|-(dynamic)|
|interface|br_cacti_nw|

Container

|server|app|address|listen|
|:-:|:-:|:-:|:-:|
|cacti_db|MariaDB|-(dynamic)|3306/tcp|
|cacti_sv|cacti|-(dynamic)|80/tcp<BR>161,162/udp|

# Firewall Policy add

```
firewall-cmd --add-masquerade --permanent
firewall-cmd --reload
```


# build servers

## git clone

```
git clone https://github.com/bashaway/cacti
```

## Build and Start Containers
```
cd cacti
docker-compose build
docker-compose up -d
```

# Setup

## Access Cacti Server

http://[hostname or address]/cacti

## login web console
Username : admin
Password : admin
![Screenshot from Gyazo](https://gyazo.com/a5228098cfe01716e03853f7ba7cf9fa/raw)

change default password
![Screenshot from Gyazo](https://gyazo.com/3b2d06832bcbd97f09ead6af765b5b85/raw)

![Screenshot from Gyazo](https://gyazo.com/5647932d6e00c091e33019191d285d22/raw)

environment check
![Screenshot from Gyazo](https://gyazo.com/811472f22d12284d4e29792f0f6e0c38/raw)

select New Primary Server　
![Screenshot from Gyazo](https://gyazo.com/b1369c2711a48531baa8b916a438a181/raw)

![Screenshot from Gyazo](https://gyazo.com/2ac81a30cc16dcbc51e40b49bc8daccb/raw)

![Screenshot from Gyazo](https://gyazo.com/d568ad96412a1007ad41dc19f4162858/raw)


## spine configuration


Console --> Configuration --> Settings --> Poller TAB
PollerType : cmd.php --> spine
![image.png](https://qiita-image-store.s3.amazonaws.com/0/334782/19e128a7-7260-9ff5-9bcd-ebb75c526e50.png)


check spine process

```
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



# Appendix

## Install Docker

### DockerCE

```
dnf -y update
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf -y --nobest install docker-ce docker-ce-cli containerd.io
dnf -y update https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm
dnf -y update
systemctl enable docker
systemctl start docker
```

### Docker Compose
```
curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

