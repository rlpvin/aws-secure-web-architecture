output "alb_dns" {
  value = "http://${module.loadbalancer.alb_dns_name}"
}

output "cloudfront_url" {
  value = "http://${module.cdn.cloudfront_domain}"
}

output "dns_nameservers" {
  value = module.dns.nameservers
}

output "website_url" {
  value = module.dns.website_url
}

output "certificate_arn" {
  value       = module.dns.certificate_arn
  description = "TLS certificate used by CloudFront for the custom domain"
}
