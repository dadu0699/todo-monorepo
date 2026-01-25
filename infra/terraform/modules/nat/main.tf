######################################
# Cloud NAT
#
# Purpose:
# - Provide outbound internet access (egress) for instances without external IPs.
# - Commonly used for private subnets (db tier), but we can also include the public subnet
#   when instances in that subnet do not have external IPs (e.g., behind an external LB).
#
# Notes:
# - We allocate a static external IP for predictable egress (MANUAL_ONLY).
# - We NAT only selected subnets (LIST_OF_SUBNETWORKS).
######################################

resource "google_compute_address" "nat_ip" {
  name   = "todo-nat-ip"
  region = var.region
}

resource "google_compute_router" "router" {
  name    = "todo-router"
  region  = var.region
  network = var.network_self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = "todo-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  # NAT the private subnet (required) and optionally the public subnet (when instances there have no external IP).
  dynamic "subnetwork" {
    for_each = toset(compact([
      var.private_subnet_self_link,
      var.public_subnet_self_link
    ]))

    content {
      name                    = subnetwork.value
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }

  # Keep logs minimal to avoid noise/cost.
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
