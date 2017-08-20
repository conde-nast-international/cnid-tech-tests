terraform {
  required_version = "> 0.10.0"
}

# Define AWS credentials, region and defaults
provider "aws" {
  region     = "${var.region}"
}
 
data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {}

# Look up the default subnets in the AZs available to this account (up to a max of 3)
data "aws_subnet" "default" {
  count = "${min(length(data.aws_availability_zones.available.names), 3)}"
  default_for_az = true
  vpc_id = "${data.aws_vpc.default.id}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
}

# Create ECS Cluster
module "ecs_cluster" {
  source = "./ecs-cluster"
  name = "nwa-ecs-cluster"
  size = 6
  instance_type = "t2.micro"
  key_pair_name = "${var.key_pair_name}"
  vpc_id = "${data.aws_vpc.default.id}"
  subnet_ids = ["${data.aws_subnet.default.*.id}"]
  allow_ssh_from_cidr_blocks = "${var.allow_ssh_from_cidr}"
  allow_inbound_ports_and_cidr_blocks = "${var.allow_inbound_ports_and_cidr}"
}

# Define application service
module "node-web-app" {
  source = "./ecs-service"
  name = "node-web-app"
  ecs_cluster_id = "${module.ecs_cluster.ecs_cluster_id}"
  image = "${var.container_image}"
  version = "${var.application_version}"
  cpu = 1024
  memory = 768
  desired_count = 2
  container_port = "${var.application_port}"
  host_port = "${var.application_port}"
  elb_name = "${module.nwa_elb.elb_name}"
}

# Define ELB
module "nwa_elb" {
  source = "./elb"
  name = "nwa-elb"
  vpc_id = "${data.aws_vpc.default.id}"
  subnet_ids = ["${data.aws_subnet.default.*.id}"]
  allow_inbound_ports_and_cidr_blocks = "${var.allow_inbound_ports_and_cidr}"
  instance_port = "${var.application_port}"
  health_check_path = "${var.health_check_path}"
}
