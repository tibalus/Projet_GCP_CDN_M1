resource "google_dns_managed_zone" "this" {
  name        = var.zone_name
  dns_name    = var.domain
  description = var.zone_description
  visibility  = var.zone_type

  # DNSSEC - uniquement si activé
  dnssec_config {
    state = var.enable_dnssec ? "on" : "off"
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
  rrdatas      = each.value.records
}