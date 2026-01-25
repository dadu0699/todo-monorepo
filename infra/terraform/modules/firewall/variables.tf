variable "network_self_link" {
  type        = string
  description = "Self link of the VPC network where firewall rules will be created"
}

variable "web_tag" {
  type        = string
  description = "Network tag applied to web/app instances"
  default     = "web"
}

variable "db_tag" {
  type        = string
  description = "Network tag applied to database instances"
  default     = "db"
}

variable "allow_http_world" {
  type        = bool
  description = "If true, allows TCP/80 from 0.0.0.0/0 to instances tagged as web (use only before LB exists)"
  default     = true
}

variable "iap_ssh_source_ranges" {
  type        = list(string)
  description = "IAP TCP forwarding source ranges used to allow SSH over IAP"
  default     = ["35.235.240.0/20"]
}

variable "lb_source_ranges" {
  type        = list(string)
  description = "Google Cloud Load Balancer and health check source ranges allowed to reach web instances"
  default     = ["35.191.0.0/16", "130.211.0.0/22"]
}
