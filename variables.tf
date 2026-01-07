variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  default     = "projet-gcp-insset1"
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
  default     = "europe-west9"
}

variable "zone" {
  description = "The zone to deploy resources in"
  type        = string
  default     = "europe-west9-b"
}

variable "ssh_keys" {
  description = "Public SSH keys to access the instance. Format: 'user:ssh-rsa ...'"
  type        = string
}

variable "domain" {
  description = "Domaine principal"
  type        = string
  default     = "groupe1.pierremalherbe.com."
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}
# Tableau avec les instances
variable "services" {
  default = {
    "cdn" = { type = "A", ttl = 300, records = ["34.117.246.135"] }
    "app" = { type = "A", ttl = 300, records = instance_internal_ip}
  }
}
