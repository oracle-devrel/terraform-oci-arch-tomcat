## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-arch-adb" {
  source                                = "github.com/oracle-devrel/terraform-oci-arch-adb"
  compartment_ocid                      = var.compartment_ocid
  adb_database_db_name                  = var.oci_adb_name
  adb_database_display_name             = var.oci_adb_name
  adb_password                          = var.oci_adb_admin_password
  adb_database_db_workload              = "OLTP"
  adb_free_tier                         = false
  adb_database_cpu_core_count           = var.oci_adb_cpu_core_count
  adb_database_data_storage_size_in_tbs = var.oci_adb_data_storage_size_in_tbs
  adb_database_db_version               = var.oci_adb_db_version
  adb_database_license_model            = var.oci_adb_license_model
  use_existing_vcn                      = true
  adb_private_endpoint                  = true
  adb_private_endpoint_label            = var.oci_adb_private_endpoint_label 
  vcn_id                                = oci_core_virtual_network.tomcat_vcn.id
  adb_subnet_id                         = oci_core_subnet.adb_subnet_private.id 
  adb_nsg_id                            = oci_core_network_security_group.adb_security_group.id
}

