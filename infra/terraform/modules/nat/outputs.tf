output "nat_name" {
  description = "Cloud NAT resource name"
  value       = google_compute_router_nat.nat.name
}

output "nat_ip" {
  description = "Static external IP address used by Cloud NAT for egress"
  value       = google_compute_address.nat_ip.address
}

output "router_name" {
  description = "Cloud Router name used by Cloud NAT"
  value       = google_compute_router.router.name
}
