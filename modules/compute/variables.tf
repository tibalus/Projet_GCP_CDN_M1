variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for the instance group"
  type        = string
}

variable "instance_name" {
  description = "Base name for instances"
  type        = string
}

variable "machine_type" {
  description = "Machine type for instances"
  type        = string
  default     = "e2-medium"
}

variable "source_image" {
  description = "Source image for instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "subnet_id" {
  description = "The subnet ID where instances will be created"
  type        = string
}

variable "enable_external_ip" {
  description = "Enable external IP for instances"
  type        = bool
  default     = true
}

variable "additional_tags" {
  description = "Additional network tags for instances"
  type        = list(string)
  default     = []
}

variable "metadata" {
  description = "Metadata key-value pairs for instances"
  type        = map(string)
  default     = {}
}

variable "startup_script" {
  description = "Startup script for instances"
  type        = string
  default     = ""
}

variable "service_account_email" {
  description = "Service account email for instances"
  type        = string
  default     = null
}

variable "service_account_scopes" {
  description = "Service account scopes for instances"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "min_replicas" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum number of instances"
  type        = number
  default     = 5
}

variable "cooldown_period" {
  description = "Cooldown period in seconds for autoscaling"
  type        = number
  default     = 60
}

variable "cpu_utilization_target" {
  description = "Target CPU utilization for autoscaling (0.0 to 1.0)"
  type        = number
  default     = 0.6
}

variable "health_check_port" {
  description = "Port for health check"
  type        = number
  default     = 80
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 5
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive successful health checks"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive failed health checks"
  type        = number
  default     = 2
}

variable "auto_healing_initial_delay" {
  description = "Initial delay for auto-healing in seconds"
  type        = number
  default     = 300
}

variable "named_port_name" {
  description = "Name for the named port"
  type        = string
  default     = "http"
}

variable "named_port" {
  description = "Port number for the named port"
  type        = number
  default     = 80
}
