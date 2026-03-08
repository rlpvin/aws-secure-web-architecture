variable "project_name" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_arn" {
  type = string
}

variable "aliases" {
  description = "List of custom domain names (CNAMEs) for the distribution"
  type        = list(string)
  default     = []
}

variable "certificate_arn" {
  description = "ARN of an ACM certificate in us-east-1 to use for the aliases"
  type        = string
  default     = ""
}
