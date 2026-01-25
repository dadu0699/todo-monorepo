output "lb_ip" {
  description = "Public IP address of the external HTTP Load Balancer"
  value       = google_compute_global_address.lb_ip.address
}
