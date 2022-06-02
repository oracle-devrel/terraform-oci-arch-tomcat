## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {
}

variable "vcn_id" {
  description = "The OCID of the VCN"
  default     = ""
}

variable "tomcat_subnet_id" {
  description = "The OCID of the tomcat subnet to create the VNIC for public/private access. "
  default     = ""
}

variable "lb_subnet_id" {
  description = "The OCID of the Load Balancer subnet to create the VNIC for public access. "
  default     = ""
}

variable "bastion_subnet_id" {
  description = "The OCID of the Bastion subnet to create the VNIC for public access. "
  default     = ""
}

variable "fss_subnet_id" {
  description = "The OCID of the File Storage Service subnet to create the VNIC for private access. "
  default     = ""
}

variable "compartment_ocid" {
  description = "Compartment's OCID where VCN will be created. "
}

variable "availability_domain_name" {
  description = "The Availability Domain of the instance."
  default     = ""
}

variable "display_name" {
  description = "The name of the instance. "
  default     = ""
}

variable "subnet_id" {
  description = "The OCID of the Shell subnet to create the VNIC for public access. "
  default     = ""
}

variable "shape" {
  description = "Instance shape to use for master instance. "
  default     = "VM.Standard.E4.Flex"
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

variable "use_bastion_service" {
  default = false
}

variable "bastion_service_region" {
  description = "Bastion Service Region"
  default     = ""
}

variable "bastion_image_id" {
  default = ""
}

variable "bastion_shape" {
  default = "VM.Standard.E3.Flex"
}

variable "bastion_flex_shape_ocpus" {
  default = 1
}

variable "bastion_flex_shape_memory" {
  default = 1
}

variable "inject_bastion_service_id" {
  default = false
}

variable "bastion_service_id" {
  default = ""
}

variable "inject_bastion_server_public_ip" {
  default = false
}

variable "bastion_server_public_ip" {
  default = ""
}

variable "use_shared_storage" {
  description = "Decide if you want to use shared NFS on OCI FSS"
  default     = true
}

variable "tomcat_shared_working_dir" {
  description = "Decide where to store tomcat data"
  default     = "/sharedtomcat"
}

variable "flex_shape_ocpus" {
  description = "Flex Instance shape OCPUs"
  default = 1
}

variable "flex_shape_memory" {
  description = "Flex Instance shape Memory (GB)"
  default = 6
}

variable "label_prefix" {
  description = "To create unique identifier for multiple clusters in a compartment."
  default     = ""
}

variable "assign_public_ip" {
  description = "Whether the VNIC should be assigned a public IP address. Default 'false' do not assign a public IP address. "
  default     = true
}

variable "ssh_authorized_keys" {
  description = "Public SSH keys path to be included in the ~/.ssh/authorized_keys file for the default user on the instance. "
  default     = ""
}

variable "image_id" {
  description = "The OCID of an image for an instance to use. "
  default     = ""
}

variable "vm_user" {
  description = "The SSH user to connect to the master host."
  default     = "opc"
}

variable "tomcat_version" {
  default = "9.0.45"
}

variable "tomcat_http_port" {
  default = 8080
}

variable "tomcat_https_port" {
  default = 443
}

variable "tomcat_app_to_deploy" {
  default = false
}

variable "tomcat_app_url_to_deploy" {
  default = "https://github.com/oracle-devrel/terraform-oci-arch-tomcat-autonomous/releases/latest/download/todoapp-adb.war"
}

variable "tomcat_app_filename_to_deploy" {
  default = "todoapp.war"
}

variable "oci_adb_setup" {
  default = false
}

variable "oracle_instant_client_version" {
  default = "19.10"
}

variable "oracle_instant_client_version_short" {
  default = "19.10"
}

variable "oci_adb_tde_wallet_zip_file" {
  default = "tde_wallet_adbdb1.zip"
}

variable "oci_adb_username" {
  default = ""
}

variable "oci_adb_password" {
  default = ""
}

variable "oci_adb_db_name" {
  default = ""
}

variable "oci_mds_setup" {
  default = false
}

variable "oci_mds_db_name" {
  default = "ocidb"
}

variable "oci_mds_username" {
  default = ""
}
    
variable "oci_mds_password" {
  default = ""
}

variable "oci_mds_ip_address" {
  default = ""
}

variable "numberOfNodes" {
    description = "Amount of Webservers to deploy"
    default = 1
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_node_shape = contains(local.compute_flexible_shapes, var.shape)
  is_flexible_lb_shape   = var.lb_shape == "flexible" ? true : false
}

variable "defined_tags" {
  description = "Defined tags for Tomcat host."
  type        = map(string)
  default     = {}
}
