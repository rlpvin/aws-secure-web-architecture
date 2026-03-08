variable "domain_name" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "cloudfront_domain" {
  type = string
}

# certificate is created for the full website name generated from domain+subdomain
variable "create_certificate" {
  description = "Whether to request an ACM certificate for the site (us-east-1)"
  type        = bool
  default     = true
}
