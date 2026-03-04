module "network" {
  source = "./modules/network"
  project_name = var.project_name
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  
  project_name = var.project_name
  vpc_id = module.network.vpc_id
  public_subnets = module.network.public_subnets
  alb_security_group_id = module.security.alb_sg_id
}
