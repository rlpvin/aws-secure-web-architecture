variable "project_name" {
  description = "Project name prefix"
  type = string
  default = "secure-web"
}

variable "aws_region" {
  description = "AWS region"
  type = string
  default = "ap-south-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type = string
  sensitive = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type = string
  sensitive = true
}
