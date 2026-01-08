# Instance Template
resource "google_compute_instance_template" "template" {
  name_prefix  = "${var.instance_name}-template-"
  machine_type = var.machine_type
  project      = var.project_id
  region       = var.region

  tags = concat(["ssh-enabled"], var.additional_tags)

  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
    disk_size_gb = var.disk_size_gb
  }

  network_interface {
    subnetwork = var.subnet_id

    dynamic "access_config" {
      for_each = var.enable_external_ip ? [1] : []
      content {
        # Ephemeral external IP
      }
    }
  }

  metadata = var.metadata

  metadata_startup_script = var.startup_script

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Health Check
resource "google_compute_health_check" "autohealing" {
  name                = "${var.instance_name}-health-check"
  project             = var.project_id
  check_interval_sec  = var.health_check_interval
  timeout_sec         = var.health_check_timeout
  healthy_threshold   = var.health_check_healthy_threshold
  unhealthy_threshold = var.health_check_unhealthy_threshold

  tcp_health_check {
    port = var.health_check_port
  }
}

# Managed Instance Group
resource "google_compute_region_instance_group_manager" "mig" {
  name               = "${var.instance_name}-mig"
  base_instance_name = var.instance_name
  region             = var.region
  project            = var.project_id

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = var.min_replicas

  named_port {
    name = var.named_port_name
    port = var.named_port
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = var.auto_healing_initial_delay
  }

  update_policy {
    type                         = "PROACTIVE"
    minimal_action               = "REPLACE"
    max_surge_fixed              = 3
    max_unavailable_fixed        = 0
    instance_redistribution_type = "PROACTIVE"
  }
}

# Autoscaler
resource "google_compute_region_autoscaler" "autoscaler" {
  name    = "${var.instance_name}-autoscaler"
  project = var.project_id
  region  = var.region
  target  = google_compute_region_instance_group_manager.mig.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period

    cpu_utilization {
      target = var.cpu_utilization_target
    }
  }
}
