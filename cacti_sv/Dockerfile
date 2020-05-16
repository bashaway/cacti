FROM centos:centos8
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime ; \
    # 
    # Package install
    # 
    dnf -y update ; dnf -y install epel-release rsyslog logrotate cronie fontconfig unzip ; \
    # 
    # Japanese Font
    mkdir /usr/share/fonts/ipa ; \
    curl -L https://ipafont.ipa.go.jp/IPAfont/IPAMTTC00303.zip > /usr/share/fonts/ipa/ttc.zip ; \
    unzip /usr/share/fonts/ipa/ttc.zip -d /usr/share/fonts/ipa/ ; \
    curl -L https://ipafont.ipa.go.jp/IPAfont/IPAfont00303.zip > /usr/share/fonts/ipa/ttf.zip ; \
    unzip /usr/share/fonts/ipa/ttf.zip -d /usr/share/fonts/ipa/ ; \
    rm -f /usr/share/fonts/ipa/*.zip ; \
    fc-cache -f ; \
    # 
    # Install cacti
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
    systemctl enable httpd ;\
    # 
    # INSTALL PLUGINS
    # 
    dnf -y install vim git ;\
    # 
    ## webseer : Cacti Web Services Monitoring Plugin
    mkdir /usr/share/cacti/plugins/webseer ;\
    git clone https://github.com/Cacti/plugin_webseer /usr/share/cacti/plugins/webseer ;\
    # 
    ## thold : Thold Plugin for Cacti
    mkdir /usr/share/cacti/plugins/thold ;\
    git clone https://github.com/Cacti/plugin_thold /usr/share/cacti/plugins/thold ;\
    # 
    ## maint : Maint Plugin for Cacti
    mkdir /usr/share/cacti/plugins/maint ;\
    git clone https://github.com/Cacti/plugin_maint /usr/share/cacti/plugins/maint ;\
    # 
    ## flowview : FlowView Plugin for Cacti
    mkdir /usr/share/cacti/plugins/flowview ;\
    git clone https://github.com/Cacti/plugin_flowview /usr/share/cacti/plugins/flowview ;\
    # 
    ## gexport : Cacti Graph Export Plugin
    mkdir /usr/share/cacti/plugins/gexport ;\
    git clone https://github.com/Cacti/plugin_gexport /usr/share/cacti/plugins/gexport ;\
    # 
    ## syslog : Syslog Plugin for Cacti
    mkdir /usr/share/cacti/plugins/syslog ;\
    git clone https://github.com/Cacti/plugin_syslog /usr/share/cacti/plugins/syslog ;\
    # 
    ## npc : Nagios Plugin for Cacti is a complete UI replacement for Nagios fully integrated into Cacti.
    mkdir /usr/share/cacti/plugins/npc ;\
    git clone https://github.com/Cacti/plugin_npc /usr/share/cacti/plugins/npc ;\
    # 
    ## monitor : Monitor Plugin for Cacti
    mkdir /usr/share/cacti/plugins/monitor ;\
    git clone https://github.com/Cacti/plugin_monitor /usr/share/cacti/plugins/monitor ;\
    # 
    ## mactrack : Mactrack Plugin for Cacti
    mkdir /usr/share/cacti/plugins/mactrack ;\
    git clone https://github.com/Cacti/plugin_mactrack /usr/share/cacti/plugins/mactrack ;\
    # 
    ## cycle : The Cacti Cycle plugin allows you to automatically view the Cacti graphs one by one after a specified time delay.
    mkdir /usr/share/cacti/plugins/cycle ;\
    git clone https://github.com/Cacti/plugin_cycle /usr/share/cacti/plugins/cycle ;\
    # 
    ## routerconfigs : Router Config Plugin for Cacti
    mkdir /usr/share/cacti/plugins/routerconfigs ;\
    git clone https://github.com/Cacti/plugin_routerconfigs /usr/share/cacti/plugins/routerconfigs ;\
    # 
    ## mkkrotik : Mikrotik Plugin for Cacti
    mkdir /usr/share/cacti/plugins/mikrotik ;\
    git clone https://github.com/Cacti/plugin_mikrotik /usr/share/cacti/plugins/mikrotik ;\
    # 
    ## hmib : HMib Plugin for Cacti
    mkdir /usr/share/cacti/plugins/hmib ;\
    git clone https://github.com/Cacti/plugin_hmib /usr/share/cacti/plugins/hmib ;\
    # 
    ## audit : Audit Plugin for Cacti
    mkdir /usr/share/cacti/plugins/audit ;\
    git clone https://github.com/Cacti/plugin_audit /usr/share/cacti/plugins/audit ;\
    # 
    ## wmi : Cacti WMI Plugin
    mkdir /usr/share/cacti/plugins/wmi ;\
    git clone https://github.com/Cacti/plugin_wmi /usr/share/cacti/plugins/wmi ;\
    # 
    ## reportit :  ReportIt Plugin for Cacti
    mkdir /usr/share/cacti/plugins/reportit ;\
    git clone https://github.com/Cacti/plugin_reportit /usr/share/cacti/plugins/reportit ;\
    # 
    ## gpsmap : GPS Maps Plugin for Cacti
    mkdir /usr/share/cacti/plugins/gpsmap ;\
    git clone https://github.com/Cacti/plugin_gpsmap /usr/share/cacti/plugins/gpsmap ;\
    # 
    ## rrdcalendar : This cacti plugin provides the ability to display graphs on the system in calendar format.
    mkdir /usr/share/cacti/plugins/rrdcalendar ;\
    git clone https://github.com/bashaway/rrdcalendar /usr/share/cacti/plugins/rrdcalendar ;\
    #chown apache.apache /usr/share/cacti/plugins/rrdcalendar/cache ;\
    #dnf -y install ImageMagick ;\
    # 
    ## haruca : Half Ability Router Utility and Config Archiver
    mkdir /usr/share/cacti/plugins/haruca ;\
    git clone https://github.com/bashaway/haruca /usr/share/cacti/plugins/haruca ;\
    #chown apache.apache /usr/share/cacti/plugins/haruca/bin/conffile ;\
    #dnf -y install gcc zip perl-CPAN perl-DBI perl-DBD-MySQL ;\
    #cpan -i Net::SSH::Expect Net::Telnet ;\
    #ln -s /usr/share/cacti/plugins/haruca/bin/haruca.pm /usr/lib64/perl5/ ;\
    # 
    # 
    # NOP
    cd
COPY docker-entrypoint.sh /usr/local/bin/
COPY cacti_db_backup /etc/cron.d/
COPY templates/ss_netsnmp_memory.php /usr/share/cacti/scripts/
RUN ln -s usr/local/bin/docker-entrypoint.sh / 
ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "/usr/sbin/init" ]
