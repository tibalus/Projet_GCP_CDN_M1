resource "google_dns_managed_zone" "this" {
  name        = var.zone_name
  dns_name    = var.domain
  description = var.zone_description

  visibility = var.zone_type

  dynamic "private_visibility_config" {
    for_each = var.zone_type == "private" ? [1] : []
    content {
      dynamic "networks" {
        for_each = var.private_visibility_networks
        content {
          network_url = networks.value
        }
      }
    }
  }

  # DNSSEC pour les zones publiques (optionnel)
  dynamic "dnssec_config" {
    for_each = var.enable_dnssec && var.zone_type == "public" ? [1] : []
    content {
      state = "on"
    }
  }

  labels = var.labels
}

# -----------------------------------------------------------------------------
# Enregistrements DNS dynamiques (A, CNAME, TXT, etc.)
# Voir le tableau services dans variables.tf
# -----------------------------------------------------------------------------
resource "google_dns_record_set" "records" {
  for_each = { for record in var.dns_records : "${record.name}-${record.type}" => record }

  name         = each.value.name == "" ? google_dns_managed_zone.this.dns_name : "${each.value.name}.${google_dns_managed_zone.this.dns_name}"
  managed_zone = google_dns_managed_zone.this.name
  type         = each.value.type
  ttl          = each.value.ttl
  project      = var.project_id
  rrdatas = each.value.records
}