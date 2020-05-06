FROM centos:centos8
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime ; \
    dnf -y update ; dnf -y install epel-release rsyslog logrotate cronie fontconfig unzip ; \
    mkdir /usr/share/fonts/ipa ; \
    curl -L https://ipafont.ipa.go.jp/IPAfont/IPAMTTC00303.zip > /usr/share/fonts/ipa/ttc.zip ; \
    unzip /usr/share/fonts/ipa/ttc.zip -d /usr/share/fonts/ipa/ ; \
    curl -L https://ipafont.ipa.go.jp/IPAfont/IPAfont00303.zip > /usr/share/fonts/ipa/ttf.zip ; \
    unzip /usr/share/fonts/ipa/ttf.zip -d /usr/share/fonts/ipa/ ; \
    rm -f /usr/share/fonts/ipa/*.zip ; \
    fc-cache -f ; \
    dnf -y install cacti-spine php mod_ssl ;\
    echo 'HTTPD_LANG=ja_JP.UTF-8' >> /etc/sysconfig/httpd ;\
    sed -i 's/^[^#]..*Require\ host\ localhost/Require all granted/' /etc/httpd/conf.d/cacti.conf ;\
    sed -i 's/^#//' /etc/cron.d/cacti ; \
    sed -i 's/database_hostname\ =..*/database_hostname\ =\ '\''cacti_db'\'';/g' /usr/share/cacti/include/config.php ;\
    sed -i 's/database_username\ =..*/database_username\ =\ '\''cactiuser'\'';/g' /usr/share/cacti/include/config.php ;\
    sed -i 's/database_password\ =..*/database_password\ =\ '\''cactipwd'\'';/g' /usr/share/cacti/include/config.php ;\
    sed -i 's/^\$cacti_cookie_domain\ /#\$cacti_cookie_domain\ /g' /usr/share/cacti/include/config.php ;\
    sed -i 's/^max_execution_time\ =..*/max_execution_time\ =\ 60/' /etc/php.ini ;\
    sed -i 's/^memory_limit\ =..*/memory_limit\ =\ 800M/' /etc/php.ini ;\
    sed -i 's/^;date.timezone\ =.*/date.timezone\ = '\''Asia\/Tokyo'\''/' /etc/php.ini ;\
    sed -i 's/DB_Host..*/DB_Host\ cacti_db/g' /etc/spine.conf ;\
    sed -i 's/DB_User..*/DB_User\ cactiuser/g' /etc/spine.conf ;\
    sed -i 's/DB_Pass..*/DB_Pass\ cactipwd/g' /etc/spine.conf ;\
    systemctl enable httpd 
COPY docker-entrypoint.sh /usr/local/bin/
COPY templates/ss_netsnmp_memory.php /var/lib/cacti/scripts/
RUN ln -s usr/local/bin/docker-entrypoint.sh / 
ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "/usr/sbin/init" ]
