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

# request an ACM certificate in us-east-1 and validate via DNS
resource "aws_acm_certificate" "cdn" {
  count             = var.create_certificate ? 1 : 0
  domain_name       = local.fqdn
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count   = var.create_certificate ? length(tolist(aws_acm_certificate.cdn[0].domain_validation_options)) : 0
  zone_id = aws_route53_zone.main.zone_id
  name    = tolist(aws_acm_certificate.cdn[0].domain_validation_options)[count.index].resource_record_name
  type    = tolist(aws_acm_certificate.cdn[0].domain_validation_options)[count.index].resource_record_type
  records = [tolist(aws_acm_certificate.cdn[0].domain_validation_options)[count.index].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cdn" {
  count                   = var.create_certificate ? 1 : 0
  certificate_arn         = aws_acm_certificate.cdn[0].arn
  validation_record_fqdns = var.create_certificate ? [for r in aws_route53_record.cert_validation : r.fqdn] : []
}
