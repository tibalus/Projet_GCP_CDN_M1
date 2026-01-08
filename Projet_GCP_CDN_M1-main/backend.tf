
terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.50.0"
    }
  }

  backend "gcs" {
    bucket = "projet-gcp-insset1-state"  # ← Remplacer par le nom du bucket créé
    prefix = "projet-cdn/state"
  }
}
