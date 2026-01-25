output "instance_group" {
  value = google_compute_instance_group_manager.web.instance_group
}

output "health_check" {
  value = google_compute_health_check.http.self_link
}
