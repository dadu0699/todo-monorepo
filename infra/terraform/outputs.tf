############################
# Networking outputs
############################

output "vpc_self_link" {
  description = "Self link of the VPC network"
  value       = module.network.vpc_self_link
}

output "public_subnet_self_link" {
  description = "Self link of the public subnet"
  value       = module.network.public_subnet_self_link
}

output "private_subnet_self_link" {
  description = "Self link of the private subnet"
  value       = module.network.private_subnet_self_link
}

############################
# Database
############################

output "db_private_ip" {
  description = "Private IP address of the MongoDB VM"
  value       = module.db.private_ip
}

############################
# Load Balancer / NAT
############################

output "lb_ip" {
  description = "External IP address of the HTTP Load Balancer"
  value       = module.lb_http.lb_ip
}

output "nat_ip" {
  description = "External IP address used by Cloud NAT for outbound traffic"
  value       = module.nat.nat_ip
}
