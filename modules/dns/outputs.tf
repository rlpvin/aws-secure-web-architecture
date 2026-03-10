output "nameservers" {
  value = aws_route53_zone.main.name_servers
}

output "website_url" {
  value = aws_route53_record.website.name
}

output "certificate_arn" {
  value       = var.create_certificate ? aws_acm_certificate_validation.cdn[0].certificate_arn : var.certificate_arn
  description = "ARN of the validated ACM certificate for the FQDN"
}

output "zone_id" {
  value       = aws_route53_zone.main.zone_id
  description = "ID of the hosted zone (useful for alias records)"
}
