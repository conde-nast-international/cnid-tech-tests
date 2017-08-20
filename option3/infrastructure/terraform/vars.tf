# Set default variables

variable "container_repository" {
  description = "The repository hosting the containers"
  default = "sonicintrusion"
}

variable "name" {
  description = "Name of this project"
  default = "node-web-app"
}

variable "version" {
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

variable "ecs_ami" {
  description = "Maps to a list of suitable AMIs"
  type = "map"
  default = {
    us-east-2	= "ami-bb8eaede"
    us-east-1	= "ami-d61027ad"
    us-west-2	= "ami-c6f81abe"
    us-west-1	= "ami-514e6431"
    eu-west-2	= "ami-0a85946e"
    eu-west-1	= "ami-bd7e8dc4"
    eu-central-1	= "ami-f15ff69e"
    ap-northeast-1	= "ami-ab5ea9cd"
    ap-southeast-2	= "ami-c3233ba0"
    ap-southeast-1	= "ami-ae0b91cd"
    ca-central-1	= "ami-32bb0556"
  }
}

variable "ecs_cluster_id" {
  default = ""
}

variable "ecs_cluster_size" {
  description = "Size of the ECS cluster"
  type = "map"
  default = {
    min_size = 5
    max_size = 5
  }
}

variable "allow_ssh_from_cidr_blocks" {
  description = "List of CIDR blocks to permit SSH access into cluster"
  default = ["0.0.0.0/0"]
}

variable "allow_inbound_ports_and_cidr_blocks" {
  description = "Permit all ports in this list from the associated CIDR blocks"
  type = "map"
  default = {
    "80"   = "0.0.0.0/0"
    "443"  = "0.0.0.0/0"
    "8080" = "0.0.0.0/0"
  }
}

variable "cpu" {
  description = "The number of CPU units to give the ECS Task, where 1024 represents one vCPU."
  default = 1024
}

variable "memory" {
  description = "The amount of memory, in MB, to give the ECS Task."
  default = 768
}

variable "application_port" {
  description = "The port the Docker container in the ECS Task is listening on."
  default = 8080
}

variable "desired_count" {
  description = "The number of ECS Tasks to run for this ECS Service."
  default = 2
}

variable "deployment_maximum_percent" {
  description = "The upper limit, as a percentage of var.desired_count."
  default = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit, as a percentage of var.desired_count."
  default = 100
}

variable "lb_port" {
  description = "The port the ELB listens on."
  default = 80
}

variable "health_check_path" {
  description = "Path of ELB health check target"
  default = ""
}

variable "elb_name" {
  description = "The name of the ELB"
  default = ""
}

variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}
