output "web_public_ip" {
  value = google_compute_instance.web.network_interface[0].access_config[0].nat_ip
}

output "web_private_ip" {
  value = google_compute_instance.web.network_interface[0].network_ip
}

output "instance_name" {
  value = google_compute_instance.web.name
}
