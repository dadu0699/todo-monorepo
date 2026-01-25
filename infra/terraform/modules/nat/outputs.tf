output "nat_name" {
  value = google_compute_router_nat.nat.name
}

output "nat_ip" {
  value = google_compute_address.nat_ip.address
}

output "router_name" {
  value = google_compute_router.router.name
}
