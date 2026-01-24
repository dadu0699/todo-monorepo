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

variable "web_instance_count" {
  type        = number
  description = "Number of instances in the web MIG"
  default     = 1
}

variable "web_tag" {
  type        = string
  description = "Network tag for web instances"
  default     = "web"
}
