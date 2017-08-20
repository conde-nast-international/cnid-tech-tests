terraform {
  required_version = "> 0.10.0"
}

# Define AWS credentials and region
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Define ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.name}"
}

# Define ASG for ECS cluster
data "aws_availability_zones" "available" {}

data "aws_subnet" "default" {
  count = "${min(length(data.aws_availability_zones.available.names), 3)}"
  default_for_az = true
  vpc_id = "${data.aws_vpc.default.id}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
}
resource "aws_autoscaling_group" "ecs_cluster_instances" {
  name = "${var.name}"
  min_size = "${var.ecs_cluster_size["min_size"]}"
  max_size = "${var.ecs_cluster_size["max_size"]}"
  launch_configuration = "${aws_launch_configuration.ecs_instance.name}"
  vpc_zone_identifier = ["${data.aws_subnet.default.*.id}"]

  tag {
    key = "Name"
    value = "${var.name}"
    propagate_at_launch = true
  }
}

# Define ASG Launch configuration
resource "aws_launch_configuration" "ecs_instance" {
  name_prefix = "${var.name}-"
  image_id = "${lookup(var.ecs_ami, var.region)}"
  instance_type = "${var.instance_size}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance.name}"
  key_name = "${var.key_pair_name}"
  security_groups = ["${aws_security_group.ecs_instance.id}"]
  user_data = <<EOF
#!/bin/bash
echo "ECS_CLUSTER=${var.name}" >> /etc/ecs/ecs.config
EOF
  lifecycle {
    create_before_destroy = true
  }
}

# Define IAM roles to attach to ECS instances
data "aws_iam_policy_document" "ecs_instance" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance" {
  name = "${var.name}-ecs-role"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_instance.json}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = "${var.name}-ecs-profile"
  role = "${aws_iam_role.ecs_instance.name}"
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ecs_cluster_permissions" {
  statement {
    effect = "Allow"
    resources = ["*"]
    actions = [
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_cluster_permissions" {
  name = "ecs-cluster-permissions"
  role = "${aws_iam_role.ecs_instance.id}"
  policy = "${data.aws_iam_policy_document.ecs_cluster_permissions.json}"
}

# Define SG to access cluster
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ecs_instance" {
  name = "${var.name}-ecs-sg"
  description = "Security group for the EC2 instances in the ECS cluster ${var.name}"
  vpc_id = "${data.aws_vpc.default.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ecs_all_outbound_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs_instance.id}"
}

resource "aws_security_group_rule" "ecs_all_inbound_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${var.allow_ssh_from_cidr_blocks}"]
  security_group_id = "${aws_security_group.ecs_instance.id}"
}

resource "aws_security_group_rule" "ecs_all_inbound_ports" {
  count = "${length(var.allow_inbound_ports_and_cidr_blocks)}"
  type = "ingress"
  from_port = "${element(keys(var.allow_inbound_ports_and_cidr_blocks), count.index)}"
  to_port = "${element(keys(var.allow_inbound_ports_and_cidr_blocks), count.index)}"
  protocol = "tcp"
  cidr_blocks = ["${lookup(var.allow_inbound_ports_and_cidr_blocks, element(keys(var.allow_inbound_ports_and_cidr_blocks), count.index))}"]
  security_group_id = "${aws_security_group.ecs_instance.id}"
}

# Define ECS Task to run Docker container
resource "aws_ecs_task_definition" "task_def" {
  family = "${var.name}"
  container_definitions = <<EOF
[
  {
    "name": "${var.name}",
    "image": "${var.container_repository}/${var.name}:${var.version}",
    "cpu": ${var.cpu},
    "memory": ${var.memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${var.application_port},
        "hostPort": ${var.application_port},
        "protocol": "tcp"
      }
    ]
  }
]
EOF
}

# Define ECS Service to run task
resource "aws_ecs_service" "ecs_service" {
  name = "${var.name}-ecs-service"
  cluster = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.task_def.arn}"
  desired_count = "${var.desired_count}"
  iam_role = "${aws_iam_role.ecs_service_role.arn}"

  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent = "${var.deployment_maximum_percent}"

  load_balancer {
    elb_name = "${var.elb_name}"
    container_name = "${var.name}"
    container_port = "${var.application_port}"
  }

  depends_on = ["aws_iam_role_policy.ecs_service_policy"]
}

#Define IAM role and permissions for ECS service
data "aws_iam_policy_document" "ecs_service_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_service_role" {
  name = "${var.name}-ecs-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_service_role.json}"
}

data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    effect = "Allow"
    resources = ["*"]
    actions = [
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_service_policy" {
  name = "ecs-service-policy"
  role = "${aws_iam_role.ecs_service_role.id}"
  policy = "${data.aws_iam_policy_document.ecs_service_policy.json}"
}

# Define Security group for ELB
resource "aws_security_group" "elb" {
  name = "${var.name}-elb-sg"
  description = "The security group for the ${var.name} ELB"
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_security_group_rule" "elb_all_outbound_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "elb_all_inbound_all" {
  type = "ingress"
  from_port = "${var.lb_port}"
  to_port = "${var.lb_port}"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

# Define ELB
resource "aws_elb" "elb" {
  name = "${var.name}-elb"
  subnets = ["${data.aws_subnet.default.*.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 15
    target = "HTTP:${var.application_port}/${var.health_check_path}"
  }
  listener {
    instance_port = "${var.application_port}"
    instance_protocol = "http"
    lb_port = "${var.lb_port}"
    lb_protocol = "http"
  }
}
