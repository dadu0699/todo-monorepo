output "ssh_rule_name" {
  description = "Firewall rule name allowing SSH via IAP"
  value       = google_compute_firewall.allow_ssh_iap.name
}

output "mongo_rule_name" {
  description = "Firewall rule name allowing MongoDB access from web to db"
  value       = google_compute_firewall.allow_mongo_from_web.name
}

output "lb_http_rule_name" {
  description = "Firewall rule name allowing HTTP from Google LB ranges to web instances"
  value       = google_compute_firewall.allow_lb_http.name
}

output "http_world_rule_name" {
  description = "Firewall rule name allowing public HTTP directly to web instances (null if disabled)"
  value       = try(google_compute_firewall.allow_http_to_web[0].name, null)
}
