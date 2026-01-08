# modules/bastion/variables.tf

variable "project_id" {
  description = "ID du projet GCP"
  type        = string
}

variable "bastion_name" {
  description = "Nom de l'instance bastion"
  type        = string
  default     = "bst1"
}

variable "region" {
  description = "Région GCP"
  type        = string
}

variable "zone" {
  description = "Zone GCP pour le bastion"
  type        = string
}

variable "network_name" {
  description = "Nom du réseau VPC"
  type        = string
  default     = "vpc1"
}

variable "subnet_self_link" {
  description = "Self link du sous-réseau"
  type        = string
}

variable "bastion_internal_ip" {
  description = "Adresse IP interne du bastion"
  type        = string
  default     = "10.0.1.10"
}

variable "machine_type" {
  description = "Type de machine pour le bastion"
  type        = string
  default     = "e2-micro"
}

variable "image" {
  description = "Image du système d'exploitation"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "disk_size_gb" {
  description = "Taille du disque en GB"
  type        = number
  default     = 10
}

variable "enable_external_ip" {
  description = "Activer l'IP externe pour le bastion"
  type        = bool
  default     = false
}

variable "bastion_sa_roles" {
  description = "Rôles IAM pour le service account du bastion"
  type        = list(string)
  default = [
    "roles/compute.osLogin",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter"
  ]
}

variable "target_tags" {
  description = "Tags des instances cibles accessibles depuis le bastion"
  type        = list(string)
  default     = ["frontend", "backend"]
}

variable "metadata" {
  description = "Metadata supplémentaires pour l'instance"
  type        = map(string)
  default     = {}
}

variable "startup_script" {
  description = "Script de démarrage pour le bastion"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels supplémentaires"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}