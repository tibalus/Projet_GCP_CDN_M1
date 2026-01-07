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
