# Set default variables

variable "container_image" {
  description = "The repository hosting the containers"
  default = "sonicintrusion/node-web-app"
}

variable "name" {
  description = "Name of this project"
  default = "node-web-app"
}

variable "application_version" {
  description = "Defined version of the app to deploy"
  default = "latest"
}

variable "region" {
  description = "The region to deploy the application"
  default = "eu-west-2"
}

variable "instance_size" {
  description = "The size of the instance to be deployed. Free tier limit is the defined default."
  default = "t2.micro"
}

variable "key_pair_name" {
  description = "The name of the Key Pair that can be used to SSH to each EC2 instance in the ECS cluster. By default not key is defined."
  default = ""
}

variable "allow_ssh_from_cidr" {
  description = "List of CIDR blocks to permit SSH access into cluster"
  default = ["0.0.0.0/0"]
}

variable "allow_inbound_ports_and_cidr" {
  description = "Permit all ports in this list from the associated CIDR blocks"
  type = "map"
  default = {
    "80"   = "0.0.0.0/0"
    "443"  = "0.0.0.0/0"
    "8080" = "0.0.0.0/0"
  }
}

variable "application_port" {
  description = "The port the Docker container in the ECS Task is listening on."
  default = 8080
}

variable "health_check_path" {
  description = "Path of ELB health check target"
  default = ""
}
