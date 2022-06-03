## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "tomcat_home_URL" {
  value = "http://${module.oci-arch-tomcat.public_ip[0]}/"
}

output "tomcat_private_ips" {
   value = module.oci-arch-tomcat.tomcat_nodes_private_ips
}

output "bastion_host_private_ip" {
   value = module.oci-arch-tomcat.bastion_host_private_ip
}

output "generated_ssh_private_key" {
  value     = module.oci-arch-tomcat.generated_ssh_private_key
  sensitive = true
}

output "generated_ssh_public_key" {
  value     = module.oci-arch-tomcat.generated_ssh_public_key
  sensitive = true
}
