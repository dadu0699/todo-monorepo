variable "region" {
  type        = string
  description = "GCP region where subnets will be created (e.g. us-central1)"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "todo-vpc"
}

variable "public_subnet_name" {
  type        = string
  description = "Name of the public subnet (web tier)"
  default     = "public-subnet"
}

variable "private_subnet_name" {
  type        = string
  description = "Name of the private subnet (db tier)"
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
