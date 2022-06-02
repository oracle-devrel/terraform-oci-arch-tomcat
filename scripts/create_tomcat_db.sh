## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
#!/bin/bash

# Check if oci_adb_setup==TRUE

export oci_adb_setup='${oci_adb_setup}'
if [[ $oci_adb_setup == "true" ]]; then

	# Install Oracle instant client
	echo '--> Install Oracle instant client...'
	if [[ $(uname -r | sed 's/^.*\(el[0-9]\+\).*$/\1/') == "el8" ]]
	then 
  		if [[ $(uname -m | sed 's/^.*\(el[0-9]\+\).*$/\1/') == "aarch64" ]]
  		then
  			yum install -y https://yum.oracle.com/repo/OracleLinux/OL8/oracle/instantclient/aarch64/getPackage/oracle-instantclient19.10-basic-19.10.0.0.0-1.aarch64.rpm
  			yum install -y https://yum.oracle.com/repo/OracleLinux/OL8/oracle/instantclient/aarch64/getPackage/oracle-instantclient19.10-sqlplus-19.10.0.0.0-1.aarch64.rpm
    		echo '-[100%]-> Oracle Client (aarch64/OL8) installed.' 
  		else
    		dnf install -y https://yum.oracle.com/repo/OracleLinux/OL8/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.10-basic-19.10.0.0.0-1.x86_64.rpm
    		dnf install -y https://yum.oracle.com/repo/OracleLinux/OL8/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.10-sqlplus-19.10.0.0.0-1.x86_64.rpm
  		    echo '-[100%]-> Oracle Client (x86_64/OL8) installed.' 
  		fi	
	else
  		if [[ $(uname -m | sed 's/^.*\(el[0-9]\+\).*$/\1/') == "aarch64" ]]
  		then 	
  			yum install -y https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/aarch64/getPackage/oracle-instantclient19.10-basic-19.10.0.0.0-1.aarch64.rpm
    		yum install -y https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/aarch64/getPackage/oracle-instantclient19.10-sqlplus-19.10.0.0.0-1.aarch64.rpm
    		echo '-[100%]-> Oracle Client (aarch64/OL7) installed.' 
  		else
    		yum install -y https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.10-basic-19.10.0.0.0-1.x86_64.rpm
    		yum install -y https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.10-sqlplus-19.10.0.0.0-1.x86_64.rpm
  		    echo '-[100%]-> Oracle Client (x86_64/OL7) installed.' 
  		fi
	fi 

	# Prepare TDE wallet 
	echo '--> Prepare Oracle Client TDE wallet...'
	unzip -o /tmp/${oci_adb_tde_wallet_zip_file} -d /usr/lib/oracle/${oracle_instant_client_version_short}/client64/lib/network/admin/
	echo '-[100%]-> Oracle TDE in place.' 

fi

# Check if oci_mds_setup==TRUE

export oci_mds_setup='${oci_mds_setup}'
if [[ $oci_mds_setup == "true" ]]; then

	echo '--> Install of mysql-shell...'
	yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
	yum install -y mysql-shell
	echo '-[100%]-> mysql-shell installed.' 

	echo '--> Install of mysql-connector-java...'
	yum install -y mysql-connector-java
	echo '-[100%]-> mysql-connector-java installed.' 

fi
