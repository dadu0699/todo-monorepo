variable "name" {
  type        = string
  description = "Base name used for all load balancer resources"
}

variable "instance_group" {
  type        = string
  description = "Self link of the Managed Instance Group used as backend"
}

variable "health_check" {
  type        = string
  description = "Self link of the health check associated with the backend service"
}
