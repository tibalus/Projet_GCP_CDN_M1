
variable "project_id" {
  description = "ID du projet GCP"
  type        = string
}

variable "zone_name" {
  description = "Nom de la zone DNS (identifiant interne)"
  type        = string
}

variable "domain" {
  description = "Nom de domaine complet avec le point final (ex: example.com.)"
  type        = string

  validation {
    condition     = can(regex("\\.$", var.domain))
    error_message = "Le domaine doit se terminer par un point (ex: example.com.)"
  }
}

variable "zone_description" {
  description = "Description de la zone DNS"
  type        = string
  default     = "Zone DNS gérée par Terraform"
}

variable "zone_type" {
  description = "Type de zone: 'public' ou 'private'"
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.zone_type)
    error_message = "Le type de zone doit être 'public' ou 'private'"
  }
}

variable "private_visibility_networks" {
  description = "Liste des URLs de réseaux VPC pour les zones privées"
  type        = list(string)
  default     = []
}

variable "enable_dnssec" {
  description = "Activer DNSSEC pour les zones publiques"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels à appliquer à la zone DNS"
  type        = map(string)
  default     = {}
}

variable "dns_records" {
  description = "Liste des enregistrements DNS à créer"
  type = list(object({
    name    = string       # Sous-domaine (vide "" pour l'apex)
    type    = string       # Type: A, AAAA, CNAME, TXT, MX, etc.
    ttl     = number       # TTL en secondes
    records = list(string) # Liste des valeurs
  }))
  default = []

  validation {
    condition = alltrue([
      for record in var.dns_records :
      contains(["A", "AAAA", "CAA", "CNAME", "MX", "NAPTR", "NS", "PTR", "SOA", "SPF", "SRV", "TXT"], record.type)
    ])
    error_message = "Le type d'enregistrement doit être valide (A, AAAA, CNAME, TXT, MX, etc.)"
  }
}
