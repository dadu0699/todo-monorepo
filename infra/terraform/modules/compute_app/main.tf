data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "web" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = [var.web_tag]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = var.subnetwork_self_link

    # Para esta fase incremental, dale IP pública para probar rápido.
    # Luego, con LB, la quitamos.
    access_config {}
  }

  metadata_startup_script = replace(
    templatefile("${path.module}/startup.sh.tftpl", {
      ssh_username        = var.ssh_username
      mongo_private_ip    = var.mongo_private_ip
      mongo_root_username = var.mongo_root_username
      mongo_root_password = var.mongo_root_password
      api_image           = var.api_image
      api_container_port  = var.api_container_port
    }),
    "\r",
    ""
  )
}
