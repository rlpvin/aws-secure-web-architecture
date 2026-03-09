variable "project_name" {
  type = string
}

variable "cloudfront_oac_arn" {
  description = "ARN of the CloudFront Origin Access Control"
  type        = string
  default     = ""
}
