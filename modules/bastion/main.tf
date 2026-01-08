# modules/bastion/main.tf

# Service Account pour le bastion
resource "google_service_account" "bastion" {
  account_id   = "${var.bastion_name}-sa"
  display_name = "Service Account for Bastion Host"
  project      = var.project_id
}

# IAM roles pour le service account
resource "google_project_iam_member" "bastion_roles" {
  for_each = toset(var.bastion_sa_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.bastion.email}"
}

# Adresse IP statique interne pour le bastion
resource "google_compute_address" "bastion_internal" {
  name         = "${var.bastion_name}-internal-ip"
  subnetwork   = var.subnet_self_link
  address_type = "INTERNAL"
  address      = var.bastion_internal_ip
  region       = var.region
  project      = var.project_id
}

# Instance de bastion
resource "google_compute_instance" "bastion" {
  name         = var.bastion_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  tags = ["bastion", "ssh-access"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size_gb
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = var.subnet_self_link
    network_ip = google_compute_address.bastion_internal.address

    # Pas d'IP externe par défaut (accès via IAP)
    dynamic "access_config" {
      for_each = var.enable_external_ip ? [1] : []
      content {
        nat_ip = null
      }
    }
  }

  service_account {
    email  = google_service_account.bastion.email
    scopes = ["cloud-platform"]
  }

  metadata = merge(
    {
      enable-oslogin         = "TRUE"
      block-project-ssh-keys = "TRUE"
    },
    var.metadata
  )

  metadata_startup_script = var.startup_script

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  labels = merge(
    {
      role        = "bastion"
      environment = var.environment
    },
    var.labels
  )

  allow_stopping_for_update = true
}

# Firewall rule pour SSH via IAP
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.bastion_name}-allow-iap-ssh"
  network = var.network_name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # IP range pour IAP (Identity-Aware Proxy)
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["bastion"]
}

# Firewall rule pour SSH depuis le bastion vers les autres instances
resource "google_compute_firewall" "allow_bastion_ssh" {
  name    = "${var.bastion_name}-allow-ssh-to-instances"
  network = var.network_name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion"]
  target_tags = var.target_tags
}