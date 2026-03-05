output "alb_dns" {
  value = module.loadbalancer.alb_dns_name
}

output "cloudfront_url" {
  value = module.cdn.cloudfront_domain
}
