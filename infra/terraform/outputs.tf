output "db_private_ip" {
  value = module.db.private_ip
}

output "web_public_ip" {
  value = module.web.web_public_ip
}

output "web_private_ip" {
  value = module.web.web_private_ip
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
