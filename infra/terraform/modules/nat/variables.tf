variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "network_self_link" {
  type        = string
  description = "Self link of the VPC network"
}

variable "private_subnet_self_link" {
  type        = string
  description = "Self link of the private subnet (required)"
}

variable "public_subnet_self_link" {
  type        = string
  description = "Self link of the public subnet (optional). Include this if you run instances without external IPs in the public subnet."
  default     = null
}
