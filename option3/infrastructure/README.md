
## Instructions

1. Ensure your AWS CLI has been configured properly: `aws configure`

1. Update the terraform/vars.tf file with a valid key pair name, if you need to access the EC2 instances.

1. Change the 'allow_ssh_from_cidr_blocks' variable, in the vars.tf file, to restrict access to valid IP addresses.
