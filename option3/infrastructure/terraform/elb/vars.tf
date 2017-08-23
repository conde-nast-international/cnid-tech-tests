# REQUIRED parameters

variable "name" {
  description = "The name of the ELB"
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the ELB."
}

variable "subnet_ids" {
  description = "The subnet IDs in which to deploy the ELB."
  type = "list"
}

variable "instance_port" {
  description = "The port the EC2 Instance is listening on. The ELB will route traffic to this port."
}

variable "health_check_path" {
  description = "The path on the instance the ELB can use for health checks. Do NOT include a leading slash."
}

variable "allow_inbound_ports_and_cidr_blocks" {
  description = "A map of port to CIDR block. For each entry in this map, the ESC Cluster will allow incoming requests on the specified port from the specified CIDR blocks."
  type = "map"
  default = {}
}

# No OPTIONAL parameters
