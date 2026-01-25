resource "google_compute_instance" "db" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = [var.db_tag]

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
  }

  metadata_startup_script = replace(
    templatefile("${path.module}/startup.sh.tftpl", {
      mongo_root_username = var.mongo_root_username
      mongo_root_password = var.mongo_root_password
      ssh_username        = var.ssh_username
    }),
    "\r",
    ""
  )
}
