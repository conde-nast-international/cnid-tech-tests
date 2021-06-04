output "load_balancer_address" {
  value = "${aws_alb.alb.dns_name}"
}

output "ecr_repo_url" {
  value = "${aws_ecr_repository.ecr_repo.repository_url}"
}

output "ecs_service_name" {
  value = "${aws_ecs_service.web.name}"
}

output "ecs_cluster_name" {
  value = "${aws_ecs_cluster.cluster.name}"
}