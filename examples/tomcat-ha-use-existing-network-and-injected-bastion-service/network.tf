## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_virtual_network" "tomcat_vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = var.vcn
  dns_label      = "jomdsvcn"
}


resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "internet_gateway"
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
}


resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
  display_name   = "nat_gateway"
}


resource "oci_core_route_table" "public_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
  display_name   = "RouteTableViaIGW"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

resource "oci_core_route_table" "private_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
  display_name   = "RouteTableViaNATGW"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

resource "oci_core_security_list" "ssh_security_list" {
  compartment_id = var.compartment_ocid
  display_name   = "ssh_security_list"
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "lb_http_security_list" {
  compartment_id = var.compartment_ocid
  display_name   = "lb_http_security_list"
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    tcp_options {
      max = 80
      min = 80
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "tomcat_http_security_list" {
  compartment_id = var.compartment_ocid
  display_name   = "tomcat_http_security_list"
  vcn_id         = oci_core_virtual_network.tomcat_vcn.id
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    tcp_options {
      max = 8080
      min = 8080
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "tomcat_subnet" {
  cidr_block                 = cidrsubnet(var.vcn_cidr, 8, 2)
  display_name               = "tomcat_subnet"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.tomcat_vcn.id
  route_table_id             = oci_core_route_table.private_route_table.id 
  security_list_ids          = [oci_core_security_list.ssh_security_list.id, oci_core_security_list.tomcat_http_security_list.id]
  dhcp_options_id            = oci_core_virtual_network.tomcat_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true 
  dns_label                  = "tomsub"
}

resource "oci_core_subnet" "lb_subnet_public" {
  cidr_block        = cidrsubnet(var.vcn_cidr, 8, 0)
  display_name      = "lb_public_subnet"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.tomcat_vcn.id
  route_table_id    = oci_core_route_table.public_route_table.id
  security_list_ids = [oci_core_security_list.lb_http_security_list.id]
  dhcp_options_id   = oci_core_virtual_network.tomcat_vcn.default_dhcp_options_id
  dns_label         = "lbpub"
}

resource "oci_core_subnet" "fss_subnet_private" {
  cidr_block                 = cidrsubnet(var.vcn_cidr, 8, 4)
  display_name               = "fss_private_subnet"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.tomcat_vcn.id
  route_table_id             = oci_core_route_table.private_route_table.id
  dhcp_options_id            = oci_core_virtual_network.tomcat_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = "true"
  dns_label                  = "fsspriv"
}





