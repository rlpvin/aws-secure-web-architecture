variable "project_name" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ec2_security_group_id" {
  type = string
}

variable "GIT_REPO" {
  type = string
}

variable "bucket_name" {
  type = string
}