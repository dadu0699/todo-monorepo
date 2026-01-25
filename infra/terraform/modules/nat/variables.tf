variable "region" {
  type        = string
  description = "GCP region where the Cloud Router and Cloud NAT will be created"
}

variable "network_self_link" {
  type        = string
  description = "Self link of the VPC network"
}

variable "private_subnet_self_link" {
  type        = string
  description = "Self link of the private subnet (required). Typically used by the db tier."
}

variable "public_subnet_self_link" {
  type        = string
  description = "Self link of the public subnet (optional). Include if instances in public subnet have no external IP (e.g., behind an external LB)."
  default     = null
}
