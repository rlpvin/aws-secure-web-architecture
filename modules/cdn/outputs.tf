output "cloudfront_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "oac_arn" {
  value       = aws_cloudfront_origin_access_control.oac.arn
  description = "ARN of the CloudFront Origin Access Control for S3"
}
