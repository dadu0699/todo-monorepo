variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "GCP zone"
  default     = "us-central1-a"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
  default     = "todo-vpc"
}

variable "public_subnet_name" {
  type        = string
  description = "Public subnet name"
  default     = "public-subnet"
}

variable "private_subnet_name" {
  type        = string
  description = "Private subnet name"
  default     = "private-subnet"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for public subnet"
  default     = "10.10.0.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR for private subnet"
  default     = "10.20.0.0/24"
}

variable "ssh_username" {
  type    = string
  default = "didier_dominguez_gt"
}

variable "mongo_root_username" {
  type    = string
  default = "root"
}

variable "mongo_root_password" {
  type    = string
  default = "root"
}

variable "api_image" {
  type    = string
  default = "ghcr.io/traefik/whoami:latest"
}
