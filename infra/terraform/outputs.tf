output "db_private_ip" {
  value = module.db.private_ip
}

output "vpc_self_link" {
  value = module.network.vpc_self_link
}

output "public_subnet_self_link" {
  value = module.network.public_subnet_self_link
}

output "private_subnet_self_link" {
  value = module.network.private_subnet_self_link
}

output "lb_ip" {
  value = module.lb_http.lb_ip
}

output "nat_ip" {
  value = module.nat.nat_ip
}
