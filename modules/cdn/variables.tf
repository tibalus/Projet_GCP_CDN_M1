
# -----------------------------------------------------------------------------
# Général
# -----------------------------------------------------------------------------
variable "project_id" {
  description = "ID du projet GCP"
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
  default     = "europe-west1"
}

variable "name_prefix" {
  description = "Préfixe pour nommer les ressources"
  type        = string
  default     = "cdn"
}

# -----------------------------------------------------------------------------
# Storage Bucket
# -----------------------------------------------------------------------------
variable "bucket_location" {
  description = "Localisation du bucket"
  type        = string
  default     = "EU"
}

variable "storage_class" {
  description = "Classe de stockage"
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "Supprimer le bucket même s'il contient des objets"
  type        = bool
  default     = false
}

variable "index_page" {
  description = "Page d'accueil"
  type        = string
  default     = "index.html"
}

variable "error_page" {
  description = "Page d'erreur 404"
  type        = string
  default     = "404.html"
}

# -----------------------------------------------------------------------------
# CDN Policy
# -----------------------------------------------------------------------------
variable "enable_cdn" {
  description = "Activer le CDN"
  type        = bool
  default     = true
}

variable "cache_mode" {
  description = "Mode de cache (CACHE_ALL_STATIC, USE_ORIGIN_HEADERS, FORCE_CACHE_ALL)"
  type        = string
  default     = "CACHE_ALL_STATIC"
}

variable "default_ttl" {
  description = "TTL par défaut en secondes"
  type        = number
  default     = 3600
}

variable "max_ttl" {
  description = "TTL maximum en secondes"
  type        = number
  default     = 86400
}

variable "client_ttl" {
  description = "TTL client en secondes"
  type        = number
  default     = 3600
}

variable "negative_caching" {
  description = "Activer le cache des réponses négatives (404, etc.)"
  type        = bool
  default     = true
}

variable "serve_while_stale" {
  description = "Durée de service du contenu périmé en secondes"
  type        = number
  default     = 86400
}

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------
variable "labels" {
  description = "Labels à appliquer aux ressources"
  type        = map(string)
  default     = {}
}
