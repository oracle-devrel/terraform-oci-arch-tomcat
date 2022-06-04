## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
#!/bin/bash

# Install Java JDK 
echo '--> Install Java OpenJDK...'
yum install -y java-1.8.0-openjdk
echo '-[100%]-> Java OpenJDK install finished.'

echo '--> Adding tomcat user...'
# Add user tomcat
useradd tomcat
echo '-[100%]-> Tomcat user added.'

# Mount NFS storage when use_shared_storage=TRUE 
export use_shared_storage='${use_shared_storage}'
if [[ $use_shared_storage == "true" ]]; then
	echo '--> Mounting NFS share: /u01...'
  yum install -y nfs-utils
  mkdir -p /u01
  echo '${mt_ip_address}:/u01 /u01 nfs nosharecache,context="system_u:object_r:httpd_sys_rw_content_t:s0" 0 0' >> /etc/fstab
  setsebool -P httpd_use_nfs=1
  mount /u01
  mount
  chown -R tomcat:tomcat /u01
  echo '-[100%]-> NFS share mounted.'
else
  mkdir -p /u01
fi

# Install Tomcat
echo '--> Installing Tomcat...'
wget -O /u01/apache-tomcat-${tomcat_version}.zip https://archive.apache.org/dist/tomcat/tomcat-${tomcat_major_release}/v${tomcat_version}/bin/apache-tomcat-${tomcat_version}.zip
unzip /u01/apache-tomcat-${tomcat_version}.zip -d /u01/
chown -R tomcat:tomcat /u01
chmod +x /u01/apache-tomcat-${tomcat_version}/bin/*.sh
echo '-[100%]-> Tomcat installed.'

# Prepare Tomcat context.xml for OCI MDS
export oci_mds_setup='${oci_mds_setup}'
if [[ $oci_mds_setup == "true" ]]; then
	echo '--> Prepare Tomcat context.xml for OCI MDS...'
	cp /home/opc/context_mds.xml /u01/apache-tomcat-${tomcat_version}/conf/context.xml
	echo '-[100%]-> MDS context.xml in place.'
fi	

# Prepare Tomcat context.xml for OCI ADB
export oci_adb_setup='${oci_adb_setup}'
if [[ $oci_adb_setup == "true" ]]; then
	echo '--> Prepare Tomcat context.xml for OCI ADB...'
	cp /home/opc/context_adb.xml /u01/apache-tomcat-${tomcat_version}/conf/context.xml
	echo '-[100%]-> ADB context.xml in place.'
fi

# Start Tomcat
echo '--> Start Tomcat...'
chmod +x /u01/apache-tomcat-${tomcat_version}/bin/*.sh
sudo -u tomcat nohup /u01/apache-tomcat-${tomcat_version}/bin/startup.sh &
echo '-[100%]-> Tomcat started.'

# Adding Tomcat as systemd service
echo '--> Adding Tomcat as systemd service and start the service...'
cp /home/opc/tomcat.service /etc/systemd/system/
ls -latr /etc/systemd/system/tomcat.service
chown root:root /etc/systemd/system/tomcat.service
cat /etc/systemd/system/tomcat.service
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat
sleep 20
ps -ef | grep tomcat
echo '-[100%]-> Tomcat added as systemd service and started'





