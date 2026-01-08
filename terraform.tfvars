# Project Configuration
project_id  = "projet-gcp-insset1"
region      = "europe-west1"
environment = "dev"

# Frontend Configuration
frontend_machine_type = "e2-medium"
frontend_min_replicas = 1
frontend_max_replicas = 5
frontend_cpu_target   = 0.6

# Backend Configuration
backend_machine_type = "e2-medium"
backend_min_replicas = 1
backend_max_replicas = 5
backend_cpu_target   = 0.6

# Bastion
bastion_machine_type = "e2-micro"
