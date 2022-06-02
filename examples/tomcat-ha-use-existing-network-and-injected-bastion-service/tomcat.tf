## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-arch-tomcat" {
  #source                         = "github.com/oracle-devrel/terraform-oci-arch-tomcat"
  source                          = "../../"
  tenancy_ocid                    = var.tenancy_ocid
  vcn_id                          = oci_core_virtual_network.tomcat_vcn.id
  numberOfNodes                   = 3
  availability_domain_name        = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availability_domain_name
  compartment_ocid                = var.compartment_ocid
  image_id                        = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  shape                           = var.node_shape
  flex_shape_ocpus                = var.node_flex_shape_ocpus
  flex_shape_memory               = var.node_flex_shape_memory
  label_prefix                    = var.label_prefix
  ssh_authorized_keys             = var.ssh_public_key
  tomcat_subnet_id                = oci_core_subnet.tomcat_subnet.id
  lb_subnet_id                    = oci_core_subnet.lb_subnet_public.id 
  fss_subnet_id                   = oci_core_subnet.fss_subnet_private.id 
  display_name                    = var.tomcat_instance_name
  lb_shape                        = var.lb_shape 
  flex_lb_min_shape               = var.flex_lb_min_shape 
  flex_lb_max_shape               = var.flex_lb_max_shape 
  oci_adb_setup                   = false 
  oci_mds_setup                   = false
  tomcat_http_port                = "8080"
  use_bastion_service             = true
  inject_bastion_server_public_ip = false
  bastion_service_id              = oci_bastion_bastion.bastion_service.id
  bastion_service_region          = var.region
}
