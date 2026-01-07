
# environments/dev/variables.tf

variable "project_id" {
  description = "ID du projet GCP"
  type        = string
  default = "projet-gcp-insset1"
}

variable "region" {
  description = "Région GCP principale"
  type        = string
  default     = "europe-west2"
}

variable "zone" {
  description = "Zone GCP pour les ressources zonales"
  type        = string
  default     = "europe-west2-c"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# ========================================
# Bastion Configuration
# ========================================
variable "bastion_machine_type" {
  description = "Type de machine pour le bastion"
  type        = string
  default     = "e2-micro"
}
