terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "projet-gcp-insset1-state"
    prefix = "projet-cdn-front-back/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}