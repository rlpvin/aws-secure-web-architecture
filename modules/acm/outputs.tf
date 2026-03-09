output "certificate_arn" {
  value       = var.create_certificate ? aws_acm_certificate.cdn[0].arn : ""
  description = "ARN of the ACM certificate for the FQDN"
}

output "domain_validation_options" {
  value       = var.create_certificate ? aws_acm_certificate.cdn[0].domain_validation_options : []
  description = "Domain validation options for the certificate"
}