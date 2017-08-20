# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN ELB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_elb" "elb" {
  name = "${var.name}"
  subnets = ["${var.subnet_ids}"]
  security_groups = ["${aws_security_group.elb.id}"]
  cross_zone_load_balancing = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 15

    target = "HTTP:${var.instance_port}/${var.health_check_path}"
  }

  listener {
    instance_port = "${var.instance_port}"
    instance_protocol = "http"
    lb_port = "${var.instance_port}"
    lb_protocol = "http"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP THAT CONTROLS WHAT TRAFFIC CAN GO IN AND OUT OF THE ELB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "elb" {
  name = "${var.name}"
  description = "The security group for the ${var.name} ELB"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "all_outbound_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "all_inbound_ports" {
  count = "${length(var.allow_inbound_ports_and_cidr_blocks)}"
  type = "ingress"
  from_port = "${element(keys(var.allow_inbound_ports_and_cidr_blocks), count.index)}"
  to_port = "${element(keys(var.allow_inbound_ports_and_cidr_blocks), count.index)}"
  protocol = "tcp"
  cidr_blocks = ["${lookup(var.allow_inbound_ports_and_cidr_blocks, element(keys(var.allow_inbound_ports_and_cidr_blocks), count.index))}"]
  security_group_id = "${aws_security_group.elb.id}"
}
