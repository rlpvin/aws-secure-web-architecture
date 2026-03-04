module "network" {
  source = "./modules/network"
  project_name = var.project_name
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}