
resource "google_storage_bucket" "default" {
  name                        = "${var.name_prefix}-bucket"
  location                    = var.bucket_location
  project                     = var.project_id
  storage_class               = var.storage_class
  uniform_bucket_level_access = true
  force_destroy               = var.force_destroy

  website {
    main_page_suffix = var.index_page
    not_found_page   = var.error_page
  }

  labels = var.labels
}

# Rendre le bucket public
# trivy:ignore:AVD-GCP-0001
resource "google_storage_bucket_iam_member" "public_read" {
  bucket = google_storage_bucket.default.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}


resource "google_storage_bucket_object" "index" {
  name         = var.index_page
  bucket       = google_storage_bucket.default.name
  content      = "<html><body><h1>CDN OK</h1></body></html>"
  content_type = "text/html"
}

resource "google_storage_bucket_object" "error" {
  name         = var.error_page
  bucket       = google_storage_bucket.default.name
  content      = "<html><body><h1>404 - Not Found</h1></body></html>"
  content_type = "text/html"
}


resource "google_compute_global_address" "default" {
  name    = "${var.name_prefix}-ip"
  project = var.project_id
}

resource "google_compute_backend_bucket" "default" {
  name        = "${var.name_prefix}-backend"
  project     = var.project_id
  bucket_name = google_storage_bucket.default.name
  enable_cdn  = var.enable_cdn

  cdn_policy {
    cache_mode        = var.cache_mode
    default_ttl       = var.default_ttl
    max_ttl           = var.max_ttl
    client_ttl        = var.client_ttl
    negative_caching  = var.negative_caching
    serve_while_stale = var.serve_while_stale
  }
}

resource "google_compute_url_map" "default" {
  name            = "${var.name_prefix}-url-map"
  project         = var.project_id
  default_service = google_compute_backend_bucket.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.name_prefix}-http-proxy"
  project = var.project_id
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.name_prefix}-forwarding-rule"
  project               = var.project_id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}
