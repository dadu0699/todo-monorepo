variable "instance_name" {
  type        = string
  description = "Nombre de la VM de base de datos"
  default     = "todo-db"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the DB VM"
  default     = "e2-micro"
}

variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "db_tag" {
  type        = string
  description = "Network tag for the DB VM"
  default     = "db"
}

variable "subnetwork_self_link" {
  type        = string
  description = "Subnetwork self link where the DB VM will live"
}

variable "mongo_root_username" {
  type        = string
  description = "Mongo root username"
}

variable "mongo_root_password" {
  type        = string
  description = "Mongo root password"
}

variable "ssh_username" {
  type        = string
  description = "Linux user who will be granted permissions to use docker without sudo"
}
