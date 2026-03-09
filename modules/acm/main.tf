terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
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