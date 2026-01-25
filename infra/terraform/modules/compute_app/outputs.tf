output "instance_group" {
  description = "Instance Group self link used by the Load Balancer backend service"
  value       = google_compute_instance_group_manager.web.instance_group
}

output "health_check" {
  description = "Health check self link used by the Load Balancer backend service"
  value       = google_compute_health_check.http.self_link
}
