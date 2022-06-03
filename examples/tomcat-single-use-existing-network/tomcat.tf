## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-arch-tomcat" {
  source                    = "github.com/oracle-devrel/terraform-oci-arch-tomcat"
  tenancy_ocid              = var.tenancy_ocid
  vcn_id                    = oci_core_virtual_network.tomcat_vcn.id
  numberOfNodes             = 1
  availability_domain_name  = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availability_domain_name
  compartment_ocid          = var.compartment_ocid
  image_id                  = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  shape                     = var.node_shape
  flex_shape_ocpus          = var.node_flex_shape_ocpus
  flex_shape_memory         = var.node_flex_shape_memory
  tomcat_subnet_id          = oci_core_subnet.tomcat_subnet.id
  display_name              = var.tomcat_instance_name
  tomcat_http_port          = var.tomcat_http_port
  oci_adb_setup             = true 
  oci_mds_setup             = true
}

