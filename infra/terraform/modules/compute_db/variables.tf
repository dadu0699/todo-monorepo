variable "instance_name" {
  type        = string
  description = "Name of the database VM instance"
  default     = "todo-db"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the DB VM (free-tier friendly)"
  default     = "e2-micro"
}

variable "boot_image" {
  type        = string
  description = "Fixed boot image used for the DB VM (pin to avoid unintended replacements)"
}

variable "zone" {
  type        = string
  description = "GCP zone where the DB VM will be created"
}

variable "db_tag" {
  type        = string
  description = "Network tag applied to the DB VM"
  default     = "db"
}

variable "subnetwork_self_link" {
  type        = string
  description = "Self link of the subnetwork where the DB VM will be created"
}

variable "mongo_root_username" {
  type        = string
  description = "MongoDB root username"
}

variable "mongo_root_password" {
  type        = string
  description = "MongoDB root password"
  sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "Linux username that will be added to the docker group (so docker can run without sudo)"
}
