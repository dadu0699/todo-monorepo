######################################
# Provider configuration
######################################

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

######################################
# Networking
######################################

module "network" {
  source = "./modules/network"
  region = var.region

  vpc_name = var.vpc_name

  public_subnet_name = var.public_subnet_name
  public_subnet_cidr = var.public_subnet_cidr

  private_subnet_name = var.private_subnet_name
  private_subnet_cidr = var.private_subnet_cidr
}

######################################
# Firewall rules
######################################

module "firewall" {
  source            = "./modules/firewall"
  network_self_link = module.network.vpc_self_link

  web_tag = "web"
  db_tag  = "db"

  # HTTP access is only allowed via the Load Balancer
  allow_http_world = false
}

######################################
# Cloud NAT (for private subnet egress)
######################################

module "nat" {
  source = "./modules/nat"
  region = var.region

  network_self_link = module.network.vpc_self_link

  private_subnet_self_link = module.network.private_subnet_self_link
  public_subnet_self_link  = module.network.public_subnet_self_link
}

######################################
# Database VM (MongoDB)
######################################

module "db" {
  source = "./modules/compute_db"
  zone   = var.zone

  subnetwork_self_link = module.network.private_subnet_self_link

  mongo_root_username = var.mongo_root_username
  mongo_root_password = var.mongo_root_password

  ssh_username = var.ssh_username
  boot_image   = var.boot_image

  # Requires NAT for outbound access and firewall rules
  depends_on = [module.nat, module.firewall]
}

######################################
# Web / API tier (Managed Instance Group)
######################################

module "web" {
  source = "./modules/compute_app"
  zone   = var.zone

  subnetwork_self_link = module.network.public_subnet_self_link

  mongo_private_ip    = module.db.private_ip
  mongo_root_username = var.mongo_root_username
  mongo_root_password = var.mongo_root_password

  api_image      = var.api_image
  frontend_image = var.frontend_image
  ssh_username   = var.ssh_username
  boot_image     = var.boot_image

  depends_on = [module.firewall]
}

######################################
# External HTTP Load Balancer
######################################

module "lb_http" {
  source = "./modules/lb_http"

  name           = "todo-api"
  instance_group = module.web.instance_group
  health_check   = module.web.health_check
}
