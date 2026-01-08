# Project Configuration
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for resources"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "GCP zone for resources"
  type        = string
  default     = "europe-west1-b"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Frontend Configuration
variable "frontend_machine_type" {
  description = "Machine type for frontend instances"
  type        = string
  default     = "e2-medium"
}

variable "frontend_source_image" {
  description = "Source image for frontend instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "frontend_min_replicas" {
  description = "Minimum number of frontend instances"
  type        = number
  default     = 1
}

variable "frontend_max_replicas" {
  description = "Maximum number of frontend instances"
  type        = number
  default     = 5
}

variable "frontend_cpu_target" {
  description = "Target CPU utilization for frontend autoscaling (0.0 to 1.0)"
  type        = number
  default     = 0.6
}

variable "frontend_startup_script" {
  description = "Startup script for frontend instances"
  type        = string
  default     = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Frontend Server - $(hostname)</h1>" > /var/www/html/index.html
  EOT
}

# Backend Configuration
variable "backend_machine_type" {
  description = "Machine type for backend instances"
  type        = string
  default     = "e2-medium"
}

variable "backend_source_image" {
  description = "Source image for backend instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "backend_min_replicas" {
  description = "Minimum number of backend instances"
  type        = number
  default     = 1
}

variable "backend_max_replicas" {
  description = "Maximum number of backend instances"
  type        = number
  default     = 5
}

variable "backend_cpu_target" {
  description = "Target CPU utilization for backend autoscaling (0.0 to 1.0)"
  type        = number
  default     = 0.6
}

variable "backend_startup_script" {
  description = "Startup script for backend instances"
  type        = string
  default     = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y python3 python3-pip
    echo "Backend Server - $(hostname)" > /tmp/backend.txt
  EOT
}

# Service Account
variable "service_account_email" {
  description = "Service account email for instances (optional)"
  type        = string
  default     = null
}

variable "domain" {
  description = "Domaine principal"
  type        = string
  default     = "groupe1.pierremalherbe.com."
}

# ========================================
# Bastion Configuration
# ========================================
variable "bastion_machine_type" {
  description = "Type de machine pour le bastion"
  type        = string
  default     = "e2-micro"
}
