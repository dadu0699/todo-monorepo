provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source              = "./modules/network"
  region              = var.region
  vpc_name            = var.vpc_name
  public_subnet_name  = var.public_subnet_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_name = var.private_subnet_name
  private_subnet_cidr = var.private_subnet_cidr
}

module "nat" {
  source                   = "./modules/nat"
  region                   = var.region
  network_self_link        = module.network.vpc_self_link
  private_subnet_self_link = module.network.private_subnet_self_link
  public_subnet_self_link  = module.network.public_subnet_self_link
}

module "db" {
  source = "./modules/compute_db"
  zone   = var.zone

  subnetwork_self_link = module.network.private_subnet_self_link

  mongo_root_username = var.mongo_root_username
  mongo_root_password = var.mongo_root_password

  ssh_username = var.ssh_username

  depends_on = [module.nat]
}

module "web" {
  source = "./modules/compute_app"
  zone   = var.zone

  subnetwork_self_link = module.network.public_subnet_self_link

  mongo_private_ip    = module.db.private_ip
  mongo_root_username = var.mongo_root_username
  mongo_root_password = var.mongo_root_password

  api_image = var.api_image

  ssh_username = var.ssh_username
}
