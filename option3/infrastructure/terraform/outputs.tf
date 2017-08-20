output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.ecs_cluster.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.ecs_cluster_instances.name}"
}

output "iam_role_id" {
  value = "${aws_iam_role.ecs_instance.id}"
}

output "iam_role_name" {
  value = "${aws_iam_role.ecs_instance.name}"
}

output "security_group_id" {
  value = "${aws_security_group.ecs_instance.id}"
}

output "task_arn" {
  value = "${aws_ecs_task_definition.task_def.arn}"
}

output "ecs_service_id" {
  value = "${aws_ecs_service.ecs_service.id}"
}

output "elb_name" {
  value = "${aws_elb.elb.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}

output "elb_security_group_id" {
  value = "${aws_security_group.elb.id}"
}