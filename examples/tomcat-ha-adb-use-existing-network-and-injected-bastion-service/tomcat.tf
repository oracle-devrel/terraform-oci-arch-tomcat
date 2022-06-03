## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-arch-tomcat" {
  #source                             = "github.com/oracle-devrel/terraform-oci-arch-tomcat"
  source                              = "../../"
  tenancy_ocid                        = var.tenancy_ocid
  vcn_id                              = oci_core_virtual_network.tomcat_vcn.id
  numberOfNodes                       = var.numberOfNodes
  availability_domain_name            = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availability_domain_name
  compartment_ocid                    = var.compartment_ocid
  tomcat_version                      = var.tomcat_version
  tomcat_http_port                    = "8080"
  image_id                            = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  shape                               = var.node_shape
  flex_shape_ocpus                    = var.node_flex_shape_ocpus
  flex_shape_memory                   = var.node_flex_shape_memory
  label_prefix                        = var.label_prefix
  ssh_authorized_keys                 = var.ssh_public_key
  tomcat_subnet_id                    = oci_core_subnet.tomcat_subnet.id
  tomcat_nsg_ids                      = [oci_core_network_security_group.tomcat_security_group.id]
  lb_subnet_id                        = oci_core_subnet.lb_subnet_public.id 
  fss_subnet_id                       = oci_core_subnet.fss_subnet_private.id 
  display_name                        = var.tomcat_instance_name
  lb_shape                            = var.lb_shape 
  flex_lb_min_shape                   = var.flex_lb_min_shape 
  flex_lb_max_shape                   = var.flex_lb_max_shape 
  oci_adb_setup                       = true
  oci_adb_username                    = var.oci_adb_username 
  oci_adb_password                    = var.oci_adb_password
  oci_adb_db_name                     = var.oci_adb_name
  oci_adb_tde_wallet_zip_file         = var.oci_adb_tde_wallet_zip_file
  oci_adb_wallet_content              = module.oci-arch-adb.adb_database.adb_wallet_content
  oracle_instant_client_version       = var.oracle_instant_client_version
  oracle_instant_client_version_short = var.oracle_instant_client_version_short
  oci_mds_setup                       = false
  use_bastion_service                 = true
  inject_bastion_server_public_ip     = false
  bastion_service_id                  = oci_bastion_bastion.bastion_service.id
  bastion_service_region              = var.region
}
