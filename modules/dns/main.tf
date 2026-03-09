terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "website" {

  zone_id = aws_route53_zone.main.zone_id
  name    = var.subdomain
  type    = "CNAME"
  ttl     = 300

  records = [var.cloudfront_domain]
}

locals {
  fqdn = "${var.subdomain}.${var.domain_name}"
}

resource "aws_route53_record" "cert_validation" {
  count   = var.create_certificate ? length(var.domain_validation_options) : 0
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_validation_options[count.index].resource_record_name
  type    = var.domain_validation_options[count.index].resource_record_type
  records = [var.domain_validation_options[count.index].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cdn" {
  count                   = var.create_certificate ? 1 : 0
  certificate_arn         = var.certificate_arn
  validation_record_fqdns = var.create_certificate ? [for r in aws_route53_record.cert_validation : r.fqdn] : []
}
