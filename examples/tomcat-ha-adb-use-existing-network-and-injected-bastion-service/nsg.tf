## Copyright (c) 2022 Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# adb_security_group

resource "oci_core_network_security_group" "adb_security_group" {
  compartment_id = var.compartment_ocid
  display_name   = "adb_security_group"
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
}

# adb_security_group_rules

# EGRESS

resource "oci_core_network_security_group_security_rule" "adb_security_group_egress_rule1" {
  network_security_group_id = oci_core_network_security_group.adb_security_group.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "adb_security_group_ingress_rule1" {
  network_security_group_id = oci_core_network_security_group.adb_security_group.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 1522
      min = 1522
    }
  }
}


# tomcat_security_group

resource "oci_core_network_security_group" "tomcat_security_group" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
  display_name   = "tomcat_security_group"
}

# adb_security_group_rules

# EGRESS

resource "oci_core_network_security_group_security_rule" "tomcat_security_group_egress_rule1" {
  network_security_group_id = oci_core_network_security_group.tomcat_security_group.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.adb_security_group.id
  destination_type          = "NETWORK_SECURITY_GROUP"
}

resource "oci_core_network_security_group_security_rule" "tomcat_security_group_egress_rule2" {
  network_security_group_id = oci_core_network_security_group.tomcat_security_group.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS 

resource "oci_core_network_security_group_security_rule" "tomcat_security_group_ingress_rule1" {
  network_security_group_id = oci_core_network_security_group.tomcat_security_group.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 8080
      min = 8080
    }
  }
}


