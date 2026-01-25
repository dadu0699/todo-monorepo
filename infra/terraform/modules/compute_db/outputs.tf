output "private_ip" {
  description = "Private IP address of the DB VM (MongoDB)"
  value       = google_compute_instance.db.network_interface[0].network_ip
}
