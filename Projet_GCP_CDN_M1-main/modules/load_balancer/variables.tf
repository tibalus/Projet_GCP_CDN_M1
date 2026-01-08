variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "instance_group" {
  description = "The self link of the instance group to load balance"
  type        = string
}
