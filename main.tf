module "network" {
  source       = "./modules/network"
  project_name = var.project_name
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  project_name          = var.project_name
  vpc_id                = module.network.vpc_id
  public_subnets        = module.network.public_subnets
  alb_security_group_id = module.security.alb_sg_id
}

module "compute" {
  source = "./modules/compute"

  project_name          = var.project_name
  private_subnets       = module.network.private_subnets
  ec2_security_group_id = module.security.ec2_sg_id
  GIT_REPO              = var.GIT_REPO
}

module "autoscaling" {
  source = "./modules/autoscaling"

  project_name       = var.project_name
  private_subnets    = module.network.private_subnets
  launch_template_id = module.compute.launch_template_id
  target_group_arn   = module.loadbalancer.target_group_arn
}

module "monitoring" {
  source = "./modules/monitoring"

  project_name = var.project_name
  asg_name     = module.autoscaling.asg_name
}

module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
}

module "acm" {
  source = "./modules/acm"

  domain_name        = var.domain_name
  subdomain          = var.subdomain
  create_certificate = true

  providers = {
    aws = aws.us_east_1
  }
}

module "cdn" {
  source = "./modules/cdn"

  project_name = var.project_name
  alb_dns_name = module.loadbalancer.alb_dns_name
  bucket_name  = module.storage.bucket_name
  bucket_arn   = module.storage.bucket_arn

  aliases         = ["${var.subdomain}.${var.domain_name}"]
  certificate_arn = module.dns.certificate_arn
}

module "dns" {
  source = "./modules/dns"

  domain_name               = var.domain_name
  subdomain                 = var.subdomain
  cloudfront_domain         = module.cdn.cloudfront_domain
  certificate_arn           = module.acm.certificate_arn
  domain_validation_options = module.acm.domain_validation_options

  providers = {
    aws = aws.us_east_1
  }
}


