output "alb_dns" {
  value = "http://${module.loadbalancer.alb_dns_name}"
}

output "cloudfront_url" {
  value = "http://${module.cdn.cloudfront_domain}"
}
