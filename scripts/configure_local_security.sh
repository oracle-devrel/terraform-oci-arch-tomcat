#!/bin/bash
#set -x

echo '--> Setting firewall rules for Tomcat with firewall-cmd...'
firewall-cmd --zone=public --permanent --add-port=${tomcat_http_port}/tcp
firewall-cmd --zone=public --permanent --add-port=${tomcat_https_port}/tcp
firewall-cmd --reload
echo '-[100%]-> Firewall rules added.'

echo '--> Setting SELinux exclusions for Tomcat with chcon and setsebool...'
chcon --type httpd_sys_rw_content_t /u01/
chcon --type httpd_sys_rw_content_t /u01/*
setsebool -P tomcat_can_network_connect_db 1
setsebool httpd_can_network_connect 1
echo '-[100%]-> SELinux configured for Tomcat'


