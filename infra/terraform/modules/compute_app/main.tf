resource "google_compute_instance_template" "web" {
  name_prefix  = "${var.instance_name}-tpl-"
  machine_type = var.machine_type
  tags         = [var.web_tag]

  disk {
    source_image = var.boot_image
    auto_delete  = true
    boot         = true

    disk_size_gb = 20
    disk_type    = "pd-balanced"
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
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

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_health_check" "http" {
  name                = "${var.instance_name}-hc"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 80
    request_path = "/health"
  }
}

resource "google_compute_instance_group_manager" "web" {
  name               = "${var.instance_name}-mig"
  zone               = var.zone
  base_instance_name = var.instance_name
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.web.self_link
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http.self_link
    initial_delay_sec = 60
  }
}
