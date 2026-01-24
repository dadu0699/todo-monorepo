provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "./modules/network"

  project_id          = var.project_id
  region              = var.region
  vpc_name            = var.vpc_name
  public_subnet_name  = var.public_subnet_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_name = var.private_subnet_name
  private_subnet_cidr = var.private_subnet_cidr
}

module "nat" {
  source = "./modules/nat"

  project_id               = var.project_id
  region                   = var.region
  network_self_link        = module.network.vpc_self_link
  private_subnet_self_link = module.network.private_subnet_self_link
  public_subnet_self_link  = module.network.public_subnet_self_link
}

resource "google_storage_bucket" "artifacts" {
  name          = "${var.project_id}-artifacts"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  versioning {
    enabled = false
  }
}

module "db" {
  source = "./modules/db_vm"

  project_id           = var.project_id
  zone                 = var.zone
  subnetwork_self_link = module.network.private_subnet_self_link

  depends_on = [module.nat]
}

module "web" {
  source = "./modules/web_mig_lb"

  project_id       = var.project_id
  region           = var.region
  zone             = var.zone
  instance_count   = var.web_instance_count
  subnet_self_link = module.network.private_subnet_self_link

  mongo_private_ip = module.db.private_ip
  artifacts_bucket = google_storage_bucket.artifacts.name
  web_tag          = var.web_tag

  depends_on = [module.nat]
}
