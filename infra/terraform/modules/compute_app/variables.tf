variable "zone" {
  type        = string
  description = "GCP zone where the Managed Instance Group will be created"
}

variable "instance_name" {
  type        = string
  description = "Base name for web resources (template, MIG, health check)"
  default     = "todo-web"
}

variable "machine_type" {
  type        = string
  description = "Machine type for web instances (free-tier friendly)"
  default     = "e2-micro"
}

variable "subnetwork_self_link" {
  type        = string
  description = "Self link of the subnet where web instances will be created"
}

variable "web_tag" {
  type        = string
  description = "Network tag applied to web instances (used by firewall rules)"
  default     = "web"
}

variable "ssh_username" {
  type        = string
  description = "Linux username to be added to the docker group"
}

variable "mongo_private_ip" {
  type        = string
  description = "Private IP address of the MongoDB VM"
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

variable "api_image" {
  type        = string
  description = "Docker image for the Todo API"
}

variable "api_container_port" {
  type        = number
  description = "Port exposed by the API container (mapped to 127.0.0.1:3000)"
  default     = 3000
}

variable "frontend_image" {
  type        = string
  description = "Docker image for the Todo frontend app"
}

variable "frontend_container_port" {
  type        = number
  description = "Port exposed by the frontend container (mapped to 127.0.0.1:80)"
  default     = 80
}

variable "boot_image" {
  type        = string
  description = "Fixed boot image used for the web instance template (pin to avoid unintended replacements)"
}
