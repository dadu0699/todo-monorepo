variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "subnetwork_self_link" {
  type        = string
  description = "Subnetwork self link where the DB VM will live"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the DB VM"
  default     = "e2-micro"
}

variable "db_tag" {
  type        = string
  description = "Network tag for the DB VM"
  default     = "db"
}
