variable "network_self_link" {
  type        = string
  description = "Self link de la VPC"
}

variable "web_tag" {
  type        = string
  description = "Tag para instancias web/app"
  default     = "web"
}

variable "db_tag" {
  type        = string
  description = "Tag para instancias db"
  default     = "db"
}

variable "allow_http_world" {
  type        = bool
  description = "Si true, permite 80 desde 0.0.0.0/0 hacia web. Útil mientras NO hay LB."
  default     = true
}

variable "iap_ssh_source_ranges" {
  type        = list(string)
  description = "Rango IAP para SSH"
  default     = ["35.235.240.0/20"]
}

variable "lb_source_ranges" {
  type        = list(string)
  description = "Rangos de LB/health checks para permitir tráfico hacia las instancias"
  default     = ["35.191.0.0/16", "130.211.0.0/22"]
}
