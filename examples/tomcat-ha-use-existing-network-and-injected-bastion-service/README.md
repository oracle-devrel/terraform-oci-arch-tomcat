## Create Tomcat multi-node + custom network & Bastion Service injected into module
This is an example of how to use the oci-arch-tomcat module to deploy Tomcat HA (multi-node) with MDS and network cloud infrastructure elements + Bastion Service injected into the module.
  
### Using this example
Update terraform.tfvars with the required information.

### Deploy the tomcat
Initialize Terraform:
```
$ terraform init
```
View what Terraform plans do before actually doing it:
```
$ terraform plan
```
Use Terraform to Provision resources:
```
$ terraform apply
```
