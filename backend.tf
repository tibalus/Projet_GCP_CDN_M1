
terraform {
  backend "gcs" {
    bucket = "projet-gcp-insset1-state"  # ← Remplacer par le nom du bucket créé
    prefix = "projet-cdn/state"
  }
}
