variable "zone" {
  type = string
}

variable "instance_name" {
  type    = string
  default = "todo-web"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "subnetwork_self_link" {
  type = string
}

variable "web_tag" {
  type    = string
  default = "web"
}

variable "ssh_username" {
  type = string
}

variable "mongo_private_ip" {
  type = string
}

variable "mongo_root_username" {
  type = string
}

variable "mongo_root_password" {
  type = string
}

variable "api_image" {
  type = string
}

variable "api_container_port" {
  type    = number
  default = 3000
}
