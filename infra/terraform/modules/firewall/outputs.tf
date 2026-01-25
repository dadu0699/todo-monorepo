output "ssh_rule_name" {
  value = google_compute_firewall.allow_ssh_iap.name
}

output "mongo_rule_name" {
  value = google_compute_firewall.allow_mongo_from_web.name
}

output "lb_http_rule_name" {
  value = google_compute_firewall.allow_lb_http.name
}

output "http_world_rule_name" {
  value = try(google_compute_firewall.allow_http_to_web[0].name, null)
}
