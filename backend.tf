
terraform {
  backend "gcs" {
    bucket = "projet-gcp-insset1-state"
    prefix = "projet-cdn/state"
  }
}
