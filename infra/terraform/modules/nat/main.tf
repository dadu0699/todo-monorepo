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

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
