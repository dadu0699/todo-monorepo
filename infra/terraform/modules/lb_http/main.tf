######################################
# External HTTP Load Balancer (L7)
#
# This module creates:
# - Global static IP address
# - Backend Service (pointing to a MIG)
# - URL Map
# - Target HTTP Proxy
# - Global Forwarding Rule (port 80)
#
# Traffic flow:
# Internet → Global IP → Forwarding Rule → HTTP Proxy → URL Map → Backend Service → MIG
######################################

# Global static IP for the Load Balancer
resource "google_compute_global_address" "lb_ip" {
  name = "${var.name}-ip"
}

# Backend service pointing to the Managed Instance Group
resource "google_compute_backend_service" "default" {
  name                  = "${var.name}-backend"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  health_checks         = [var.health_check]
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = var.instance_group
  }
}

# URL map (single backend, no path-based routing for now)
resource "google_compute_url_map" "default" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.default.self_link
}

# HTTP proxy
resource "google_compute_target_http_proxy" "default" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.default.self_link
}

# Global forwarding rule (port 80)
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.name}-fwd-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.self_link
  ip_address            = google_compute_global_address.lb_ip.address
}
