## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "public_ip" {
  value = var.numberOfNodes > 1 ? oci_core_public_ip.tomcat_public_ip_for_multi_node.*.ip_address : oci_core_public_ip.tomcat_public_ip_for_single_node.*.ip_address
}

output "tomcat_nodes_ids" {
  value = concat(oci_core_instance.tomcat.*.id, oci_core_instance.tomcat_from_image.*.id)
}

output "tomcat_nodes_private_ips" {
  value = var.numberOfNodes > 1 ? concat(oci_core_instance.tomcat.*.private_ip, oci_core_instance.tomcat_from_image.*.private_ip) : oci_core_public_ip.tomcat_public_ip_for_single_node.*.ip_address
}

output "tomcat_host_name" {
  value = concat(oci_core_instance.tomcat.*.display_name, oci_core_instance.tomcat_from_image.*.display_name)
}

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "generated_ssh_public_key" {
  value     = tls_private_key.public_private_key_pair.public_key_openssh
  sensitive = true
}

output "bastion_session_ids" {
  value = concat(oci_bastion_session.ssh_via_bastion_service.*.id, oci_bastion_session.ssh_via_bastion_service2plus.*.id)
}

output "bastion_host_private_ip" {
  value = (var.numberOfNodes > 1 && !var.use_bastion_service && !var.inject_bastion_server_public_ip) ? oci_core_instance.bastion_instance[0].public_ip : ""
}