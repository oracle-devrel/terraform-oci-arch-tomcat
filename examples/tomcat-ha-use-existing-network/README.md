## Create Tomcat multi-node + custom network injected into module
This is an example of how to use the oci-arch-tomcat module to deploy Tomcat HA (multi-node) with MDS and network cloud infrastrucutre elements injected into the module..
  
### Using this example
Update terraform.tfvars with the required information.

### Deploy the Tomcat
Initialize Terraform:
```
$ terraform init
```
View what Terraform plans do before actually doing it:
```
$ terraform plan
```

Create a `terraform.tfvars` file, and specify the following variables:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid = "<compartment_ocid>"
```

Use Terraform to Provision resources:
```
$ terraform apply -auto-approve
```

### Testing your Deployment
After the deployment is finished, you can test if your Tomcat have been deployed correctly. Pick up the value of the tomcat_home_URL:

```
tomcat_home_URL = http://193.122.204.54/
```

### Destroy the Tomcat 

Use Terraform to destroy resources:
```
$ terraform destroy -auto-approve
```