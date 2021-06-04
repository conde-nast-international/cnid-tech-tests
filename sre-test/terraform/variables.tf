variable "region" {
  default = "ap-southeast-2"
}

variable "managed_by" {
  default     = "terraform"
  description = "terraform"
}

variable "app_name" {
  default     = "node-hello-world"
  description = "Name of the application"
}

variable "environment" {
  default     = "dev"
  description = "Name of the environment. e.g. prod, qa, dev"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use"
  default     = 2
}

variable "repository_name" {
  default     = "node-hello-world"
  description = "Name for Docker repo"
}