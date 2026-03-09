variable "domain_name" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "cloudfront_domain" {
  type = string
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
  default     = ""
}

variable "domain_validation_options" {
  description = "Domain validation options for the certificate"
  type        = list(any)
  default     = []
}

variable "create_certificate" {
  description = "Whether to request an ACM certificate for the site (us-east-1)"
  type        = bool
  default     = true
}
