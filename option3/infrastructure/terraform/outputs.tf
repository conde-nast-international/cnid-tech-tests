output "application_url" {
  value = "http://${module.nwa_elb.elb_dns_name}"
}
