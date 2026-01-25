############################
# Global / Project settings
############################

variable "project_id" {
  type        = string
  description = "GCP Project ID where all resources will be created"
}

variable "region" {
  type        = string
  description = "Default GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Default GCP zone"
  default     = "us-central1-a"
}

############################
# Networking
############################

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "todo-vpc"
}

variable "public_subnet_name" {
  type        = string
  description = "Name of the public subnet (used by web tier)"
  default     = "public-subnet"
}

variable "private_subnet_name" {
  type        = string
  description = "Name of the private subnet (used by database tier)"
  default     = "private-subnet"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
  default     = "10.10.0.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
  default     = "10.20.0.0/24"
}

############################
# Compute / OS
############################

variable "boot_image" {
  type        = string
  description = "Fixed Ubuntu image used for VMs and instance templates (prevents unintended replacements)"
  default     = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20260114"
}

variable "ssh_username" {
  type        = string
  description = "Linux username added to instances for SSH access"
  default     = "didier_dominguez_gt"
}

############################
# Database (MongoDB)
############################

variable "mongo_root_username" {
  type        = string
  description = "MongoDB root username"
  default     = "root"
}

variable "mongo_root_password" {
  type        = string
  description = "MongoDB root password"
  default     = "root"
}

############################
# Application
############################

variable "api_image" {
  type        = string
  description = "Docker image for the Todo API"
  default     = "dadu0699/todo-api:v1"
}
