data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "db" {
  name         = "todo-db"
  machine_type = var.machine_type
  zone         = var.zone

  tags = [var.db_tag]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
    # No external IP -> egress via Cloud NAT
  }

  metadata_startup_script = <<-EOF
    #!/usr/bin/env bash
    set -euo pipefail

    export DEBIAN_FRONTEND=noninteractive

    apt-get update -y
    apt-get install -y mongodb

    systemctl enable mongodb
    systemctl start mongodb
  EOF
}

