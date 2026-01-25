variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "instance_count" {
  type        = number
  description = "Number of instances in the web MIG"
  default     = 1
}

variable "machine_type" {
  type        = string
  description = "Machine type for web instances"
  default     = "e2-micro"
}

variable "subnet_self_link" {
  type        = string
  description = "Subnetwork self link for the web instances"
}

variable "mongo_private_ip" {
  type        = string
  description = "Private IP of the MongoDB instance (optional for future use)"
  default     = ""
}

variable "web_tag" {
  type        = string
  description = "Network tag for web instances"
  default     = "web"
}

variable "repo_ref" {
  type        = string
  description = "Branch/tag/commit"
  default     = "main"
}

variable "db_private_ip" {
  type        = string
  description = "IP privada de la VM de DB"
}

variable "api_port" {
  type    = number
  default = 3000
}
