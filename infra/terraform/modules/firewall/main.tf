resource "google_compute_firewall" "allow_ssh_iap" {
  name      = "allow-ssh-iap"
  network   = var.network_self_link
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.iap_ssh_source_ranges
  target_tags   = [var.web_tag, var.db_tag]
}

resource "google_compute_firewall" "allow_mongo_from_web" {
  name      = "allow-mongo-from-web"
  network   = var.network_self_link
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_tags = [var.web_tag]
  target_tags = [var.db_tag]
}

resource "google_compute_firewall" "allow_lb_http" {
  name      = "allow-lb-http"
  network   = var.network_self_link
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.lb_source_ranges
  target_tags   = [var.web_tag]
}

resource "google_compute_firewall" "allow_http_to_web" {
  count     = var.allow_http_world ? 1 : 0
  name      = "allow-http-to-web"
  network   = var.network_self_link
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.web_tag]
}
