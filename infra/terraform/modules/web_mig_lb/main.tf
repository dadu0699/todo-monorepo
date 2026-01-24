data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

locals {
  nginx_conf = <<-NGINX
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;
      index index.html;

      location = /healthz {
        default_type text/plain;
        return 200 'ok';
      }

      location / {
        try_files $uri $uri/ =404;
      }
    }
  NGINX

  startup_script = replace(<<-SCRIPT
    #!/usr/bin/env bash
    set -euo pipefail

    export DEBIAN_FRONTEND=noninteractive

    apt-get update -y
    apt-get install -y nginx unzip curl

    cat >/var/www/html/index.html <<'HTML'
    <html>
      <head><title>TODO Web</title></head>
      <body>
        <h1>TODO Web is up ✅</h1>
      </body>
    </html>
HTML

    cat >/etc/nginx/sites-available/default <<'NGINX'
${local.nginx_conf}
NGINX

    nginx -t
    systemctl enable nginx
    systemctl restart nginx
  SCRIPT
  , "\r\n", "\n")
}

resource "google_compute_instance_template" "web_tpl" {
  name_prefix  = "todo-web-"
  machine_type = var.machine_type

  tags = [var.web_tag]

  disk {
    source_image = data.google_compute_image.ubuntu.self_link
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = var.subnet_self_link
  }

  metadata = {
    startup-script = local.startup_script
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "mig" {
  name               = "todo-web-mig"
  base_instance_name = "todo-web"
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.web_tpl.self_link
  }

  target_size = var.instance_count

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_health_check" "http" {
  name = "todo-web-hc"

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = 80
    request_path = "/healthz"
  }
}

resource "google_compute_backend_service" "backend" {
  name                  = "todo-web-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 10

  health_checks = [google_compute_health_check.http.self_link]

  backend {
    group = google_compute_instance_group_manager.mig.instance_group
  }
}

resource "google_compute_url_map" "urlmap" {
  name            = "todo-web-urlmap"
  default_service = google_compute_backend_service.backend.self_link
}

resource "google_compute_target_http_proxy" "proxy" {
  name    = "todo-web-proxy"
  url_map = google_compute_url_map.urlmap.self_link
}

resource "google_compute_global_address" "lb_ip" {
  name = "todo-web-lb-ip"
}

resource "google_compute_global_forwarding_rule" "fwd" {
  name                  = "todo-web-fwd"
  ip_address            = google_compute_global_address.lb_ip.address
  port_range            = "80"
  target                = google_compute_target_http_proxy.proxy.self_link
  load_balancing_scheme = "EXTERNAL_MANAGED"
}
